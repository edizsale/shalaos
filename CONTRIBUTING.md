# ShalaOS'a Katkı Rehberi

ShalaOS'a ilgin için teşekkürler! Bu proje Arch Linux tabanlı, KDE Plasma masaüstülü,
koyu-kırmızı "dardania" temalı bir Linux dağıtımıdır. Katkılar açıktır; aşağıdaki kurallar
sürecin düzenli ilerlemesi içindir.

## Önce oku

- **Mimari ve tasarım kararları:** depo kökündeki `CLAUDE.md` projenin nasıl kurulduğunu,
  neden bu şekilde olduğunu ve tuzakları anlatır. Katkıdan önce ilgili bölümü oku.
- **Derleme:** `docs/BUILD.md` — ISO nasıl üretilir (otomatik CI ve elle VM).
- **Marka:** `TRADEMARK.md` — isim/logo kullanımı GPL'den ayrıdır.

## Önemli kısıtlar

- **Build bu makinede yapılmaz varsayımı geçerliydi; artık CI var.** ISO'yu doğrulamak için
  bir tag atmadan `workflow_dispatch` ile CI'yı elle tetikleyebilir veya VM'de `./build.sh`
  çalıştırabilirsin.
- **`profile/airootfs/` paket kurulumundan ÖNCE kopyalanır** (live-build'in tersi). Paket
  sahibi dosyalar (os-release gibi) airootfs'ten ezilemez; `pacman.d/hooks` ile yazılır.
- **Yeni özel-izinli dosya eklersen** `profile/profiledef.sh` içindeki `file_permissions`
  dizisine de işlemelisin, yoksa izinler ISO'da kaybolur.
- **dardania temasını doğrudan `profile/airootfs` içinde düzenleme.** Tek kaynak
  `edizsale/dardania` deposudur; `./sync-dardania.sh` ile senkronla.
- **BIOS boot menülerinde Türkçe karakter kullanma** (isolinux/syslinux UTF-8 render edemez).

## Katkı akışı

1. Bir **issue** aç (hata veya öneri) — mükerrerleri önlemek için önce ara.
2. Depoyu forkla, açıklayıcı bir dal adı kullan (`fix/...`, `feat/...`).
3. Değişikliğini yap; commit mesajlarını **açık ve Türkçe** yaz (mevcut geçmişle uyumlu).
4. Betik değiştirdiysen yerelde **shellcheck** çalıştır (CI zaten kontrol eder).
5. Mümkünse değişikliği bir ISO derleyip test et.
6. `main`'e karşı bir **Pull Request** aç; şablonu doldur.

## Kod stili

- `.editorconfig` kurallarına uy (LF satır sonu, 2 boşluk girinti, son satırda newline).
- Kabuk betikleri: `#!/usr/bin/env bash` + `set -euo pipefail`, shellcheck temiz.
- Yapılandırma dosyalarını minimal ve yorumlu tut.

## Davranış

Tüm etkileşimler `CODE_OF_CONDUCT.md` kurallarına tabidir.

## Güvenlik

Güvenlik açıklarını herkese açık issue olarak değil, `SECURITY.md`'deki yolla bildir.
