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

---

## Kaynak Koda Erişim (GPL uyumu)

ShalaOS ISO'su, GPL ve benzeri copyleft lisanslarla korunan çok sayıda ikili paket içerir.
Bu lisanslar, ikiliyi dağıtan tarafın **kaynak koda erişim sağlamasını** ister. ShalaOS bu
yükümlülüğü aşağıdaki şekilde karşılar (GPLv3 §6(d): ikilinin yanında kaynağın nerede
bulunacağının açıkça belirtilmesi).

**Önemli:** ShalaOS, içerdiği hiçbir yukarı-akış paketini **yamalamaz veya değiştirmez**.
Paketler Arch Linux depolarından (Calamares için EndeavourOS deposundan) **olduğu gibi**
alınır. ShalaOS'a özgü olan tek şey, `profile/airootfs/` altındaki ek yapılandırma
dosyaları, betikler ve görsel kimliktir — bunların tamamı zaten bu deponun içinde açık
kaynaktır.

| Bileşen | Kaynak nerede? |
|---|---|
| **ShalaOS'un kendi kodu** (betikler, yapılandırma, archiso profili, dardania teması) | Bu depo: https://github.com/edizsale/shalaos — GPL-3.0 (bkz. `LICENSE`) |
| **Arch Linux paketleri** (çekirdek, KDE Plasma, systemd, GRUB vb. — değiştirilmemiş) | Arch paketleme depoları: https://gitlab.archlinux.org/archlinux/packaging/packages/ — her paketin `PKGBUILD`'i, yukarı-akış kaynağını ve uygulanan yamaları belirtir. Arşiv: https://archive.archlinux.org |
| **archiso `releng` profili** (uyarlandı) | https://gitlab.archlinux.org/archlinux/archiso — GPL-3.0 |
| **Calamares** (EndeavourOS ikili deposundan, değiştirilmemiş) | Yukarı-akış: https://github.com/calamares/calamares — GPL-3.0 · EndeavourOS paketleme: https://github.com/endeavouros-team/PKGBUILDS |
| **KDE Plasma / Breeze** (dardania temasının tabanı) | https://invent.kde.org — GPL/LGPL |

Belirli bir bileşenin kaynağına ulaşmakta zorlanırsan, [issue aç](https://github.com/edizsale/shalaos/issues)
veya **edizsale810@gmail.com** adresine yaz — yönlendirelim.

### Özgür olmayan bileşenler hakkında not

ShalaOS **%100 özgür yazılım dağıtımı değildir.** Diğer genel amaçlı dağıtımlar gibi,
donanımın çalışması için tescilli ama **yeniden dağıtılabilir** bileşenler içerir:

- `linux-firmware` — çeşitli üreticilerin cihaz firmware'leri (karışık lisanslar,
  çoğu ikili biçimde ve yeniden dağıtım izinli).
- `broadcom-wl` — Broadcom kablosuz ağ sürücüsü (tescilli, yeniden dağıtım izinli).

Bu bileşenler Arch Linux depolarından değiştirilmeden gelir; lisans koşulları ilgili
paketlerin kendi belgelerindedir.

---

Herhangi bir bileşenin atfı eksik veya hatalıysa lütfen bir issue açın.
