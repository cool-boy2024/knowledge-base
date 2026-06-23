#!/usr/bin/env python3
"""
graphify 后处理: 给 graph.json 节点 label 追加中文翻译, 并 patch graph.html.

每次跑完 `graphify extract . && graphify cluster-only . && graphify export html` 后,
运行此脚本即可让在线大脑图里的英文文件名带上 · 中文翻译.

数据来源 (按优先级):
1. md 文件 H1 里的 "X · Y" 格式 (Y 为中文翻译)
2. md frontmatter aliases 字段的第一个非空别名
"""
import json, re, sys
from pathlib import Path

VAULT = Path(__file__).resolve().parents[1]
GRAPH_JSON = VAULT / "graphify-out/graph.json"
GRAPH_HTML = VAULT / "graphify-out/graph.html"


def extract_aliases(text):
    """从 frontmatter 解析 aliases 数组"""
    m = re.match(r'^---\n(.*?)\n---', text, re.DOTALL)
    if not m:
        return []
    fm = m.group(1)
    am = re.search(r'^aliases:\s*\[(.*?)\]', fm, re.MULTILINE)
    if not am:
        return []
    return re.findall(r'"([^"]+)"', am.group(1))


def extract_h1_chinese(text):
    """从 '# Title · 中文' 格式中提取中文部分"""
    body = text.split('---\n', 2)[-1] if text.startswith('---') else text
    m = re.search(r'^# (.+)$', body, re.MULTILINE)
    if not m:
        return None
    h1 = m.group(1).strip()
    parts = re.split(r'\s*·\s*', h1)
    if len(parts) >= 2:
        return parts[1].strip()
    return None


def collect_translations():
    """扫所有 md, 返回 {相对路径: 中文翻译}"""
    result = {}
    for md in VAULT.rglob("*.md"):
        if any(part in str(md) for part in ['.git', 'graphify-out', '.claude']):
            continue
        try:
            text = md.read_text(encoding='utf-8')
        except Exception:
            continue
        rel = str(md.relative_to(VAULT))
        zh = extract_h1_chinese(text) or (extract_aliases(text)[0] if extract_aliases(text) else None)
        if zh and re.search(r'[一-鿿]', zh):  # 必须含中文
            result[rel] = zh
    return result


def patch_graph_json(translations):
    if not GRAPH_JSON.exists():
        print(f"WARN: {GRAPH_JSON} 不存在, 跳过")
        return 0
    g = json.loads(GRAPH_JSON.read_text(encoding='utf-8'))
    updated = 0
    for node in g['nodes']:
        sf = node.get('source_file', '')
        if sf in translations:
            zh = translations[sf]
            label = node['label']
            if '·' not in label and zh not in label:
                node['label'] = f"{label} · {zh}"
                updated += 1
    GRAPH_JSON.write_text(json.dumps(g, ensure_ascii=False, indent=2), encoding='utf-8')
    print(f"graph.json: {updated} 个节点已 patch")
    return updated


def patch_graph_html():
    if not GRAPH_HTML.exists():
        print(f"WARN: {GRAPH_HTML} 不存在, 跳过")
        return 0
    html = GRAPH_HTML.read_text(encoding='utf-8')
    graph = json.loads(GRAPH_JSON.read_text(encoding='utf-8'))
    id_to_label = {n['id']: n['label'] for n in graph['nodes'] if '·' in n.get('label', '')}

    m = re.search(r'const RAW_NODES = (\[.*?\]);', html, re.DOTALL)
    if not m:
        print("ERROR: HTML 里没找到 RAW_NODES 数组")
        return 0
    nodes = json.loads(m.group(1))
    patched = sum(1 for n in nodes if n['id'] in id_to_label and (n.__setitem__('label', id_to_label[n['id']]) or True))
    new_raw = json.dumps(nodes, ensure_ascii=False)
    new_html = html.replace(m.group(1), new_raw)
    GRAPH_HTML.write_text(new_html, encoding='utf-8')
    print(f"graph.html: {patched} 个节点已 patch")
    return patched


if __name__ == "__main__":
    print(f"=== graphify post-process: 注入中文 label ===")
    translations = collect_translations()
    print(f"扫到 {len(translations)} 个文件含中文翻译")
    patch_graph_json(translations)
    patch_graph_html()
    print("完成")
