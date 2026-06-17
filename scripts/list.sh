#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/lib.sh"

declare -A require_fonts

while IFS='=' read -r name url; do
  require_fonts["$name"]="$url"
done < <(read_font_entries < "$SCRIPT_DIR/fonts.list")

mapfile -t installed_families < <(typst fonts --font-path=fonts)

declare -A fam_map=()
for fam in "${installed_families[@]}"; do
  fam_map["${fam,,}"]=1
done

for name in "${!require_fonts[@]}"; do
  key="${name,,}"
  if [[ -z "${fam_map[$key]+x}" ]]; then
    echo "${name}=${require_fonts[$name]}"
  fi
done
