#!/usr/bin/env python3
"""ShalaOS hicolor ikon üreteci.

Bir kaynak PNG'den freedesktop hicolor ölçülerinde ikon seti üretir.
Alfa kanalı korunur; en-boy oranı bozulmaz (kare tuvale ortalanır).

Kullanım:
    python3 tools/ikon-uret.py tools/kaynak/ShalaOS_Logo_Baslat.png shalaos-baslat

İkinci argüman ikon adıdır (.desktop dosyalarındaki `Icon=` değeri ve
Plasma'nın `writeConfig("icon", ...)` çağrısı bu adı kullanır).

Gereksinim: Pillow  (pip install --user Pillow)
"""

import sys
from pathlib import Path

from PIL import Image, ImageFilter

# Panel/menü/ayarlar ekranlarının istediği ölçüler. 22 ve 24 KDE panelinin
# küçük simge boyutlarıdır — başlat düğmesi çoğu zaman bunlardan birini kullanır.
OLCULER = (16, 22, 24, 32, 48, 64, 128, 256)

# archiso profilindeki hedef kök
HICOLOR = Path("profile/airootfs/usr/share/icons/hicolor")


def uret(kaynak: Path, ad: str) -> None:
    im = Image.open(kaynak).convert("RGBA")

    # Saydam kenar boşluğunu at: ikon tuvalini tam doldursun, küçük
    # boyutlarda amblem gereksiz yere ufalmasın.
    kutu = im.getchannel("A").getbbox()
    if kutu:
        im = im.crop(kutu)

    for n in OLCULER:
        # En-boy oranını koruyarak n x n içine sığdır, kare tuvale ortala.
        kopya = im.copy()
        kopya.thumbnail((n, n), Image.LANCZOS)

        # Küçük ölçülerde LANCZOS ince çizgileri (kartalın çevresindeki yay,
        # kanat tüyleri) bulanıklaştırıyor; hafif keskinleştirme panelde
        # okunabilirliği belirgin artırıyor. Büyük ikonlarda gerek yok.
        if n <= 32:
            kopya = kopya.filter(
                ImageFilter.UnsharpMask(radius=0.6, percent=95, threshold=0)
            )

        tuval = Image.new("RGBA", (n, n), (0, 0, 0, 0))
        tuval.paste(kopya, ((n - kopya.width) // 2, (n - kopya.height) // 2))

        hedef = HICOLOR / f"{n}x{n}" / "apps" / f"{ad}.png"
        hedef.parent.mkdir(parents=True, exist_ok=True)
        # optimize: dosya boyutu ISO'ya girdiği için gereksiz bayt taşımayalım.
        tuval.save(hedef, "PNG", optimize=True)
        print(f"{hedef}  ({n}x{n})")


def main() -> int:
    if len(sys.argv) != 3:
        print(__doc__, file=sys.stderr)
        return 2

    kaynak = Path(sys.argv[1])
    if not kaynak.is_file():
        print(f"Kaynak bulunamadı: {kaynak}", file=sys.stderr)
        return 1

    if not HICOLOR.parent.is_dir():
        print("Bu betiği depo kökünden çalıştır.", file=sys.stderr)
        return 1

    uret(kaynak, sys.argv[2])
    return 0


if __name__ == "__main__":
    sys.exit(main())
