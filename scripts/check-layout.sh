#!/bin/sh
# Fail if the install manifests drift from UPSTREAM or the skills tree.
set -eu
root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
cd "$root"
python3 - <<'PY'
import json
import pathlib

plugin = json.load(open(".claude-plugin/plugin.json"))
market = json.load(open(".claude-plugin/marketplace.json"))
pkg = json.load(open("package.json"))
sha = open("UPSTREAM").read().strip()
assert plugin["name"] == "pstack"
assert plugin["version"] == sha[:12], (plugin["version"], sha[:12])
assert market["name"] == "s1-team"
entry = market["plugins"][0]
assert entry["name"] == "pstack" and entry["source"] == "./"
assert pkg["name"] == "pstack" and "pi-package" in pkg["keywords"]
skills = list(pathlib.Path("skills").glob("*/SKILL.md"))
assert skills, "no skills"
print(f"ok {len(skills)} skills at {plugin['version']}")
PY
