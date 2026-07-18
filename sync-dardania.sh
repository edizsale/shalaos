#!/usr/bin/env bash
# dardania temasini ~/dardania reposundan bu profile senkronlar.
# Tek kaynak dardania reposudur; ISO'daki kopyayi elle duzenleme.
set -euo pipefail
cd "$(dirname "$0")"

DARDANIA="${1:-$HOME/dardania}"
AIROOTFS="profile/airootfs"

[ -d "$DARDANIA" ] || { echo "dardania reposu bulunamadi: $DARDANIA" >&2; exit 1; }

install -Dm644 "$DARDANIA/color-schemes/DardaniaDark.colors" \
    "$AIROOTFS/usr/share/color-schemes/DardaniaDark.colors"

rm -rf "$AIROOTFS/usr/share/plasma/look-and-feel/org.shalaos.dardania"
mkdir -p "$AIROOTFS/usr/share/plasma/look-and-feel"
cp -rT "$DARDANIA/look-and-feel/org.shalaos.dardania" \
    "$AIROOTFS/usr/share/plasma/look-and-feel/org.shalaos.dardania"

echo "dardania senkronlandi."
