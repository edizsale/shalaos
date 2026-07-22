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

ShalaOS, "sade, şık ve güvenilir bir işletim sistemi" fikriyle tasarlanmış, kimliği baştan sona işlenmiş bir
Arch Linux dağıtımıdır. Koyu zemin + kırmızı vurgu (kırmızı kartal logosu) etrafında kurulu
**dardania** Plasma Global Teması ile gelir. Masaüstü ortamı olarak tema özgürlüğü yüksek KDE Plasma
tercih edilmiştir.


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

**En güncel ISO'yu [Releases](https://github.com/edizsale/shalaos/releases) sayfasından
indir, USB'ye yaz, başlat. Bu kadar.** Kurulum adımları: **[docs/kurulum.md](docs/kurulum.md)**.

<details>
<summary><b>İndirmeni doğrulamak istersen (opsiyonel)</b></summary>

Zorunlu değil — ama indirmenin bozulmadan geldiğinden emin olmak istersen, ISO'nun
yanındaki `.sha256` dosyasını da indir ve tek komut çalıştır:

```bash
sha256sum -c ShalaOS-*-Dardania-x86_64.iso.sha256   # "OK" görmelisin
```

**İleri düzey (GPG imza):** ISO'nun gerçekten ShalaOS tarafından yayımlandığını kriptografik
olarak doğrulamak istersen `.sig` dosyasıyla:

```bash
gpg --import KEYS
gpg --verify ShalaOS-*-Dardania-x86_64.iso.sig ShalaOS-*-Dardania-x86_64.iso
```

</details>

## Sistem gereksinimleri

ShalaOS hafiftir — **eski ve düşük güçlü bilgisayarlarda da rahat çalışır.** KDE Plasma
mütevazı donanımda akıcıdır ve kurulum internet gerektirmez.

| Bileşen | En az | Önerilen |
|---------|-------|----------|
| İşlemci | 64-bit (x86_64), çift çekirdek | 2+ çekirdek, ~2 GHz |
| RAM | **2 GB** | 4 GB |
| Disk | **20 GB** boş alan | 30 GB+ (SSD) |
| Ekran kartı | OpenGL destekli (entegre GPU yeterli) | — |
| Önyükleme | UEFI **veya** eski BIOS | UEFI |

> Not: Canlı ortamı denemek için ~2 GB RAM yeterlidir. Kurucu (Calamares) 15 GB'ın altındaki
> diskleri reddeder, bu yüzden hedef disk en az 20 GB olmalı.

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
