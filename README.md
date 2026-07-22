<div align="center">

<img src="docs/assets/logo.png" alt="ShalaOS" width="220" />

# ShalaOS

**Arch Linux tabanlı, KDE Plasma masaüstülü, koyu-kırmızı _"dardania"_ temalı özel Linux dağıtımı.**

[![Lisans: GPL-3.0](https://img.shields.io/github/license/edizsale/shalaos)](LICENSE)
[![Son sürüm](https://img.shields.io/github/v/release/edizsale/shalaos?display_name=release)](https://github.com/edizsale/shalaos/releases)
[![ISO derleme](https://github.com/edizsale/shalaos/actions/workflows/build-iso.yml/badge.svg)](https://github.com/edizsale/shalaos/actions/workflows/build-iso.yml)

[İndir](https://github.com/edizsale/shalaos/releases) ·
[Kurulum](docs/kurulum.md) ·
[Derleme](docs/BUILD.md) ·
[Katkı](CONTRIBUTING.md) ·
[English](README.en.md)

</div>

---

## Nedir?

ShalaOS, "her yerde ShalaOS görünsün" fikriyle tasarlanmış, kimliği baştan sona işlenmiş bir
Arch Linux dağıtımıdır. Koyu zemin + kırmızı vurgu (kırmızı kartal logosu) etrafında kurulu
**dardania** Plasma Global Teması ile gelir. GNOME yerine tema özgürlüğü yüksek KDE Plasma
tercih edilmiştir.

Debian/XFCE tabanlı öncül çalışma **Abinti**'nin devamıdır.

## Özellikler

- 🦅 **Baştan sona ShalaOS kimliği** — logo, duvar kağıdı, SDDM, Plymouth açılış, panel
  başlat düğmesi, karşılama sayfası.
- 🎨 **dardania teması** — Breeze Dark tabanlı koyu-kırmızı (AccentColor 228,20,30) Global
  Tema, renk şeması ve pencere dekorasyonu.
- 🇹🇷 **Türkçe yerelleştirme** — dil, klavye, saat dilimi (İstanbul) hazır.
- 💿 **Canlı ortam + kurulum** — Calamares ile diske kurulabilir; internet gerektirmez.
- 🖥️ **KDE Plasma** — Dolphin, Konsole, Kate, Spectacle, Chromium ve daha fazlası.
- 🔁 **Arch rolling** — kurulum sonrası `pacman -Syu` ile güncel kalır.
- 🔐 **İmzalı, doğrulanabilir ISO'lar** — SHA-256 + GPG imzası.

## İndirme ve doğrulama

En güncel ISO: **[Releases](https://github.com/edizsale/shalaos/releases)**.

| Dosya | Açıklama |
|-------|----------|
| `ShalaOS-<sürüm>-Dardania-x86_64.iso` | Canlı + kurulum ISO'su (x86_64, UEFI + BIOS) |
| `…​.iso.sha256` | SHA-256 sağlaması |
| `…​.iso.sig` | GPG detached imza |

```bash
sha256sum -c ShalaOS-*-Dardania-x86_64.iso.sha256
gpg --import KEYS
gpg --verify ShalaOS-*-Dardania-x86_64.iso.sig ShalaOS-*-Dardania-x86_64.iso
```

Kurulum adımları için: **[docs/kurulum.md](docs/kurulum.md)**.

## Derleme

ISO'yu kendin üretmek istersen iki yol var — otomatik CI (tag'e basınca) ve elle VM
derlemesi. Ayrıntılar: **[docs/BUILD.md](docs/BUILD.md)**.

```bash
# Yerel (Docker gerekir):
./build.sh          # ISO out/ dizinine düşer
```

## Proje yapısı

| Yol | Açıklama |
|-----|----------|
| `profile/` | archiso profili (paketler, airootfs, boot menüleri, Calamares) |
| `Dockerfile`, `build.sh` | container içinde `mkarchiso` ile ISO üretimi |
| `sync-dardania.sh` | dardania temasını ayrı depodan senkronlar |
| `.github/workflows/` | CI: ISO derleme + imzalı release, shellcheck, Pages |
| `docs/` | dokümantasyon ve tanıtım sitesi |
| `CLAUDE.md` | mimari kararlar, tuzaklar ve yol haritası |

## Katkı

Katkılar açıktır — bkz. [CONTRIBUTING.md](CONTRIBUTING.md) ve
[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md). Güvenlik için [SECURITY.md](SECURITY.md).

## Lisans ve marka

Kaynak kod **[GPL-3.0](LICENSE)** altındadır. **"ShalaOS" adı, kırmızı kartal logosu ve
görsel kimlik** ise korunur — bkz. [TRADEMARK.md](TRADEMARK.md). Üçüncü taraf atıfları:
[NOTICE.md](NOTICE.md).
