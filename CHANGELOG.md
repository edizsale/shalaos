# Değişiklik Günlüğü

Bu dosyanın biçimi [Keep a Changelog](https://keepachangelog.com/tr/1.1.0/) temellidir ve
proje [Anlamsal Sürümleme](https://semver.org/lang/tr/) (SemVer) kullanır.

## [Yayımlanmadı]

## [1.0.2] "Dardania" - 2026-07-28

Bakım sürümü: kurulan sistemde klavye düzeni düzeltmesi.

### Düzeltildi
- **Kurulumda seçilen klavye düzeni (ör. Türkçe) kurulan sistemde sıfırlanıyordu.**
  ShalaOS'ta `xorg-server` kurulu değildir; Plasma **Wayland** oturumunda çalışır.
  Calamares'in `keyboard` modülü düzeni yalnızca `/etc/X11/xorg.conf.d/00-keyboard.conf`
  ve `/etc/vconsole.conf` dosyalarına yazar — Wayland'de Plasma'nın klavye düzenini
  belirleyen dosya ise `kxkbrc`'dir. Bu yüzden seçilen düzen masaüstü oturumuna geçmiyor,
  kullanıcı Sistem Ayarları'ndan elle düzeltmek zorunda kalıyordu.
  - Yeni `usr/local/bin/shalaos-klavye-kur`, Calamares'in yazdığı düzen/varyant/modeli
    okuyup sistem geneli `/etc/xdg/kxkbrc`'ye çevirir. **Kullanıcının seçtiği düzen
    korunur** — Türkçe zorla dayatılmaz (Almanca seçen Almanca alır).
  - Calamares zincirine `shellprocess@klavye` adımı eklendi (`keyboard`/`localecfg`
    sonrası çalışır).
  - Canlı ortam için `etc/xdg/kxkbrc` varsayılanı (`tr`) eklendi; aynı zamanda
    X11 yapılandırması okunamazsa güvenli geri-düşüş görevi görür.

### Eklendi
- `NOTICE.md`: **Kaynak Koda Erişim (GPL uyumu)** bölümü — ISO'daki GPL bileşenlerinin
  kaynağına nereden ulaşılacağı bileşen bazında tablolandı (GPLv3 §6(d)). ShalaOS'un
  yukarı-akış paketlerini değiştirmediği açıkça belirtildi. Ayrıca özgür olmayan ama
  yeniden dağıtılabilir bileşenler (`linux-firmware`, `broadcom-wl`) hakkında dürüst not.
- `README.md` / `README.en.md`: ShalaOS'un Arch Linux'tan **türetildiği**, Arch projesi
  tarafından onaylanmadığı ibaresi (Arch marka politikasının önerdiği ifade) ve kaynak
  erişim bölümüne bağlantı.

## [1.0.1] "Dardania" - 2026-07-27

Bakım sürümü: kurulan sistemde oturum davranışı düzeltmesi. Kurulum, tema ve paket
seti 1.0.0 ile aynıdır — mevcut kullanıcıların yeniden kurmasına gerek yoktur
(düzeltme Sistem Ayarları'ndan da yapılabilir, bkz. aşağısı).

### Düzeltildi
- **Kurulan sistemde ikinci girişte uygulamalar kendiliğinden açılıyordu** (ör. hoş geldin
  sayfasını gösteren Chromium penceresi ve açık bırakılan Konsole). Sebep, Plasma'nın
  varsayılan oturum davranışıydı (`restorePreviousLogout` — kapatma anında açık olan
  uygulamaları geri yükler). Sistem geneli `etc/xdg/ksmserverrc` ile varsayılan
  `emptySession` yapıldı: her oturum temiz başlar. Kullanıcı dilerse Sistem Ayarları →
  Başlangıç ve Kapanış → Masaüstü Oturumu'ndan kendi tercihine çevirebilir.

## [1.0.0] "Dardania" - 2026-07-22

İlk resmî, imzalı ve otomatik üretilen sürüm.

### Eklendi — Resmîleşme katmanı (R1–R4)
- `LICENSE` (GPL-3.0), `TRADEMARK.md` (isim/logo marka politikası), `NOTICE.md` (üçüncü
  taraf atıfları).
- Yönetişim: `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, GitHub issue/PR
  şablonları.
- Sürümleme: `VERSION` dosyası (SemVer + kod adı) ve `profiledef.sh` içinde geriye-uyumlu
  `SHALAOS_VERSION` env desteği.
- CI/CD: tag'e basınca ISO üreten, SHA-256 sağlaması ve GPG imzası ekleyen `build-iso.yml`;
  `shellcheck` çalıştıran `lint.yml`; Pages dağıtan `pages.yml`; SourceForge bağlantısını
  ISO derlemeden doğrulayan `sf-test.yml`.
- Barındırma: ISO, GitHub'ın 2 GiB dosya sınırını aştığı için **SourceForge**'a yüklenir;
  GitHub Release'e sağlama (`.sha256`), imza (`.sig`) ve indirme linki konur.
- Tanıtım: yeniden yazılmış `README.md` (+ `README.en.md`), `docs/` GitHub Pages sitesi.
- `docs/BUILD.md` (CI + VM derleme + GPG kurulum), `docs/kurulum.md`.

### Değişti
- Derleme akışı elle `tar` + `gh release upload` yönteminden CI tabanlı imzalı release'e
  taşındı.

### Kaldırıldı
- Yanlışlıkla commit'lenmiş `gitcode.md` çöp dosyası.

## Geçmiş (sürümleme öncesi — Aşama 0–5)

- **Aşama 0–1:** Depo kurulumu ve archiso `releng` tabanlı derleme iskeleti.
- **Aşama 2:** KDE Plasma canlı ortam, ShalaOS kimliği (logo, duvar kağıdı, kdeglobals),
  Türkçe yerelleştirme, Plymouth `bgrt` açılış filigranı.
- **Aşama 3:** Calamares kurulumu (EndeavourOS ikili deposu). VM kurulum testi geçti
  (18 Tem 2026) — kurulum uçtan uca, `pacman -Syu` dahil sorunsuz.
- **Aşama 4:** dardania teması (ayrı depo `edizsale/dardania`) — DardaniaDark renk şeması,
  Look-and-Feel, splash, aurorae pencere dekorasyonu; `sync-dardania.sh` ile senkron.
- **Aşama 5:** VMware ve gerçek donanım denemeleri (denek bilgisayarda başarılı).

> İlk etiketli resmî sürüm **v1.0.0 "Dardania"** olacaktır; yukarıdaki "Yayımlanmadı"
> maddeleri bu sürümle birlikte tarihlenip taşınacaktır.
