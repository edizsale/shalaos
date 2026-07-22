# Üçüncü Taraf Bileşenler ve Atıflar (NOTICE)

ShalaOS, mevcut özgür yazılım ekosisteminin üzerine inşa edilmiştir. Bu dosya, projenin
doğrudan türetildiği veya paketlediği başlıca bileşenleri ve kökenlerini belgeler.

## Derleme temeli

- **archiso `releng` profili** — `profile/` dizini, Arch Linux'un resmî `archiso`
  projesindeki `releng` profilinden kopyalanıp uyarlanmıştır.
  Lisans: GPL-3.0. Kaynak: https://gitlab.archlinux.org/archlinux/archiso
- **Arch Linux** temel sistem ve paket depoları. https://archlinux.org

## Masaüstü ve tema

- **KDE Plasma / Breeze** — masaüstü ortamı ve "dardania" temasının tabanı (Breeze Dark).
  Lisanslar: GPL / LGPL / MIT (KDE bileşenlerine göre). https://kde.org
- **dardania teması** — ShalaOS'a özgü koyu-kırmızı Global Tema, renk şeması, LNF ve
  aurorae dekorasyonu. Kaynak: ayrı depo `edizsale/dardania`. ISO içindeki kopya oradan
  `sync-dardania.sh` ile senkronlanır.

## Kurulum aracı

- **Calamares** — sistem kurulum aracı. Arch resmî depolarında bulunmadığından
  **EndeavourOS ikili deposundan** alınır (`pacman.conf` içinde işaretli blok,
  `SigLevel = Never`; bu bir proje kararıdır). Kurulan sistemden Calamares'in
  `shellprocess@cleanup` adımı bu depoyu ve canlı-ortam kalıntılarını temizler.
  Calamares lisansı: GPL-3.0. https://calamares.io — EndeavourOS: https://endeavouros.com

## Görsel kimlik

- **ShalaOS logosu, duvar kağıtları ve tanıtım görselleri** — © 2026 edizsale.
  Bkz. `TRADEMARK.md`. GPL-3.0 kod lisansı bu görselleri kapsamaz.

## Önceki proje

- **Abinti** — ShalaOS'un öncülü olan Debian/XFCE tabanlı alpha çalışma; ayrı ve
  değişmeden korunan bir depodur.

Herhangi bir bileşenin atfı eksik veya hatalıysa lütfen bir issue açın.
