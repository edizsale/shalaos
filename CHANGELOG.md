# Değişiklik Günlüğü

Bu dosyanın biçimi [Keep a Changelog](https://keepachangelog.com/tr/1.1.0/) temellidir ve
proje [Anlamsal Sürümleme](https://semver.org/lang/tr/) (SemVer) kullanır.

## [Yayımlanmadı]

### Eklendi — Resmîleşme katmanı (R1–R4)
- `LICENSE` (GPL-3.0), `TRADEMARK.md` (isim/logo marka politikası), `NOTICE.md` (üçüncü
  taraf atıfları).
- Yönetişim: `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, GitHub issue/PR
  şablonları.
- Sürümleme: `VERSION` dosyası (SemVer + kod adı) ve `profiledef.sh` içinde geriye-uyumlu
  `SHALAOS_VERSION` env desteği.
- CI/CD: tag'e basınca ISO üreten, SHA-256 sağlaması ve GPG imzası ekleyip GitHub Release
  oluşturan `build-iso.yml`; `shellcheck` çalıştıran `lint.yml`; Pages dağıtan `pages.yml`.
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
