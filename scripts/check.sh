#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/lib.sh"

missing_count=0

while IFS='=' read -r name url; do
  missing_count=$((missing_count + 1))
  printf "%b• %b${BOLD}%s${RESET}%b is missing\n" \
    "$RED" "" "$name" "$RED"
  printf "   → Download at: %b%s%b\n" \
    "$CYAN" "$url" "$RESET"
done < <(read_font_entries)


# If any input arrived, treat each as a missing font and emit a warning
if (( missing_count )); then
  printf "\n%b%d font(s) is missing%b\n" \
    "$YELLOW" "$missing_count" "$RESET"
  exit 1
else
  printf "%b✓ All required fonts are available!%b\n" \
    "$GREEN$BOLD" "$RESET"
fi
