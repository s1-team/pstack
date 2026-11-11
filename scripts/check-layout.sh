#!/bin/sh
# Fail if the backup is missing its upstream commit or its skills.
set -eu
root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
cd "$root"
python3 - <<'PY'
import pathlib
import re

sha = open("UPSTREAM").read().strip()
assert re.fullmatch(r"[0-9a-f]{40}", sha), sha
skills = list(pathlib.Path("skills").glob("*/SKILL.md"))
assert skills, "no skills"
print(f"ok {len(skills)} skills at {sha}")
PY
