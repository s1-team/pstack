#!/bin/sh
# Copy pstack/skills from cursor/plugins into ./skills.
# UPSTREAM holds the commit that copy came from; the next run compares it to main.
set -eu

url=https://github.com/cursor/plugins.git
root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
stamp=$root/UPSTREAM

remote=$(git ls-remote "$url" refs/heads/main | awk 'NR==1 { print $1 }')
if [ -z "$remote" ]; then
  echo "failed to read upstream main" >&2
  exit 1
fi

have=
if [ -f "$stamp" ]; then
  have=$(awk 'NR==1 { print $1 }' "$stamp")
fi

if [ "$remote" = "$have" ]; then
  echo "up to date $have"
  exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

git clone --depth 1 --filter=blob:none --sparse "$url" "$tmp/plugins"
git -C "$tmp/plugins" sparse-checkout set pstack
sha=$(git -C "$tmp/plugins" rev-parse HEAD)

if [ "$sha" = "$have" ]; then
  echo "up to date $have"
  exit 0
fi

rm -rf "$root/skills.new"
cp -a "$tmp/plugins/pstack/skills" "$root/skills.new"
rm -rf "$root/skills"
mv "$root/skills.new" "$root/skills"
cp -a "$tmp/plugins/pstack/LICENSE" "$root/LICENSE"
printf '%s\n' "$sha" > "$stamp"
echo "updated ${have:-none} -> $sha"
