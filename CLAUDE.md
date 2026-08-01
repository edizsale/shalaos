# ShalaOS

Arch Linux tabanlı, **KDE Plasma** masaüstülü özel Linux dağıtımı. Abinti'nin (Debian/XFCE
alpha, saf haliyle korunuyor — o repoya DOKUNMA) devamı olan proje. Kimlik: kırmızı kartal
logo + siyah zemin; hedef görünüm koyu + kırmızı vurgulu **"dardania"** Plasma Global Teması
(Breeze Dark tabanı, AccentColor 228,20,30). GNOME'dan bilinçli vazgeçildi (tema özgürlüğü
düşük); kullanıcı "her yerde ShalaOS görünsün" istiyor.

## Mimari

- **Build bu makinede YAPILMAZ.** Kaynak burada düzenlenir, tarball GitHub release'ine
  yüklenir, kullanıcı Windows'taki VMware içindeki Debian VM'ine indirir ve orada
  `./build.sh` ile (Docker + archlinux imajı + mkarchiso) ISO üretir.
- `profile/` — archiso profili; archiso master'ın **releng** profilinden kopyalandı
  (live-build'deki auto/ + config/ karşılığı). Önemli parçalar:
  - `profiledef.sh` — ISO adı/etiketi, sıkıştırma, `file_permissions` (airootfs'e eklenen
    her özel izinli dosya buraya da işlenmeli, yoksa izinler kaybolur).
  - `packages.x86_64` — canlı sisteme kurulan paketler (tek sütun, alfabetik).
  - `airootfs/` — canlı sisteme kopyalanan dosyalar (includes.chroot karşılığı). DİKKAT:
    airootfs paket kurulumundan ÖNCE kopyalanır (live-build'in tersi!). Paket sahibi dosyalar
    (os-release gibi) airootfs'ten ezilemez — pacman hook ile yazılır:
    `etc/pacman.d/hooks/zz01-shalaos-branding.hook` → `usr/local/bin/shalaos-brand`
    (os-release + locale-gen). Yeni özel-izinli dosya eklersen `profiledef.sh`
    `file_permissions`'a da işle.
  - Canlı kullanıcı: `shala` (passwd/shadow/group/gshadow'da elle tanımlı, ArchWiki
    canlı-kullanıcı deseni; wheel + NOPASSWD sudo). SDDM otomatik girişi
    `etc/sddm.conf.d/shalaos.conf`. mkarchiso, passwd'deki kullanıcı için home'u kendisi açar.
  - Açılış ekranı (Plymouth): tema `bgrt` (UEFI'de üretici logosu altında ShalaOS filigranı;
    filigran kaynağı `usr/local/share/shalaos/watermark.png`, hook spinner temasına kopyalar). Yalnızca KURULAN sistemde
    aktif: `etc/mkinitcpio.conf.d/10-shalaos-plymouth.conf` HOOKS'u tanımlar ama canlıda
    alfabetik sonra gelen `archiso.conf` onu ezer; Calamares temizliği archiso.conf'u silince
    kurulan sistemde geçerli olur. `splash` parametresi grubcfg.conf'tan gelir.
  - Hoş geldin sayfası: `usr/share/shalaos/hosgeldiniz/index.html`, açan script
    `usr/local/bin/shalaos-hosgeldiniz` (autostart ile; canlıdaki shala kullanıcısında ve
    ikinci girişte çalışmaz — bayrak dosyası `~/.config/shalaos-hosgeldiniz-gosterildi`).
  - Panel düzeni + başlat düğmesi logosu: dardania LNF içindeki
    `contents/layouts/org.kde.plasma.desktop-layout.js` (kickoff icon=shalaos). Plasma bunu
    yalnızca İLK açılışta (boş plasma-org.kde.plasma.desktop-appletsrc) uygular.
  - Kimlik dosyaları: logo `usr/share/pixmaps/shalaos-logo.png` (+ hicolor ikonları),
    duvar kağıdı `usr/share/wallpapers/ShalaOS/` (Plasma duvar kağıdı paketi), dardania
    iskeleti `usr/share/plasma/look-and-feel/org.shalaos.dardania/`, sistem geneli varsayılan
    `etc/xdg/kdeglobals`. SDDM arkaplanı `usr/share/sddm/themes/breeze/theme.conf.user`.
    Kaynak görseller: `~/Masaüstü/Projelerim/ShalaOS/ShalaOS_{Logo,Wallpaper}.png`.
  - BIOS boot menüsünde Türkçe karakter KULLANMA (Abinti dersi, isolinux/syslinux UTF-8
    render edemez) — "ShalaOS canli ortami" gibi ASCII yaz.
  - `grub/`, `efiboot/`, `syslinux/` — boot menüleri (UEFI + BIOS).
- `Dockerfile` + `build.sh` — Abinti'deki düzenin aynısı, içerik mkarchiso'ya göre.
  mkarchiso work dizini kasten container içinde tutulur (volume değil).
- Calamares Arch resmi depolarında YOK — **EndeavourOS binary deposundan** geliyor
  (kullanıcı kararı; `pacman.conf`'ta SHALAOS-EOS-BASLA/BITIR işaretli blok, SigLevel Never).
  Kurulan sistemden Calamares'in `shellprocess@cleanup` adımı bu bloğu ve tüm canlı-ortam
  kalıntılarını (shala kullanıcısı, autologin, archiso mkinitcpio conf'u) siler.
- Calamares yapılandırması: `airootfs/usr/local/share/shalaos/calamares/` (settings.conf +
  modules/ + branding/shalaos/). `/etc/calamares`'e DOĞRUDAN KOYMA — EOS calamares paketi
  kendi modül conf'larını orada taşıyor, pacstrap "exists in filesystem" ile patlar
  (doğrulandı). shalaos-brand hook'u paketlerden sonra `/etc/calamares`'e kopyalar; EOS paketinde
  initcpio/initcpiocfg modülleri YOK (doğrulandı) — initramfs `shellprocess@initramfs`
  (`mkinitcpio -P`) ile üretilir. Plymouth
  filigranı da aynı yoldan gider (`usr/local/share/shalaos/watermark.png`).
  Kurulum sırası: unpackfs squashfs'i `/run/archiso/bootmnt/arch/x86_64/airootfs.sfs`'ten
  kopyalar (install_dir değişirse burayı da değiştir!). GRUB canlıda önceden kurulu
  (Abinti dersi: internetsiz kurulum bootloader'da patlamasın). Menü girişi:
  `usr/share/applications/shalaos-kur.desktop` (`sudo -E calamares`).

## İş akışı

**GÜNCEL (resmîleşme sonrası — CI tabanlı):**
1. Kaynağı düzenle → `git add -A && git commit && git push` (repo: `edizsale/shalaos`).
2. **Test derlemesi:** GitHub Actions → "ISO derle ve yayınla" → *Run workflow*
   (`workflow_dispatch`); ISO artefakt olarak iner. Veya VM'de `./build.sh`.
3. **Resmî sürüm:** `VERSION` + `CHANGELOG.md` güncelle → `git tag -a vX.Y.Z -m '...'`
   → `git push origin vX.Y.Z`. CI ISO'yu üretir, SHA-256 + GPG imzalar, Release'i oluşturur.
   Ayrıntı: `docs/BUILD.md`.

> **ESKİ akış EMEKLİ:** `tar czf shalaos-build.tar.gz` + `gh release upload v1 ... --clobber`
> artık kullanılmıyor. Kullanıcı VM'de eski tarball indirmeye gerek duymaz; `git pull` +
> CI/`build.sh` yeterli.

VM'de root sahipli dosya kalıntıları olabilir (Docker --privileged yüzünden);
kullanıcıya silme komutu verirken `sudo rm -rf` öner.

Sürümleme: **isimli major + SemVer** (ör. ShalaOS 1.0 "Dardania"). `profiledef.sh` sürümü
`SHALAOS_VERSION` env'inden alır (yoksa eski tarih bazlı davranış birebir korunur).

## Yol haritası (plan: ~/.claude/plans/pure-weaving-scone.md)

1. ~~Aşama 0: repo kurulumu~~ / ~~Aşama 1: build iskeleti (releng tabanı)~~
2. ~~Aşama 2: KDE Plasma canlı ortam + ShalaOS kimliği + TR yerel~~ (VM build testi bekliyor)
3. ~~Aşama 3: Calamares (EndeavourOS binary deposu)~~ — VM kurulum testi GEÇTİ (18 Tem 2026): kurulum uçtan uca, pacman -Syu dahil sorunsuz
4. Aşama 4 v1 TAMAM (18 Tem 2026): dardania ayrı repoda (private `edizsale/dardania`); DardaniaDark renk şeması + LNF + splash. Kaynak orası — ISO kopyasını elle düzenleme, `./sync-dardania.sh` çalıştır. v2 fikirleri: SDDM QML teması, ikon seti, dekorasyon
5. Aşama 5: VMware test + gerçek donanım (Acer'da Abinti var, ÜZERİNE YAZILMAZ)

### Resmîleşme yol haritası (plan: ~/.claude/plans/t-m-sistemi-incele-bu-majestic-brook.md)

Projeyi halka açık, resmî bir dağıtım standardına taşır. **profile/ işlevsel olarak
DEĞİŞMEZ** (yalnızca profiledef.sh'e geriye-uyumlu sürüm kancası eklendi).

- ~~**R1** Depo hijyeni & yasal: `gitcode.md` silindi; `LICENSE` (GPL-3.0), `TRADEMARK.md`
  (isim/kırmızı-kartal logo korumalı), `NOTICE.md`, `CONTRIBUTING`/`CODE_OF_CONDUCT`/
  `SECURITY`, `CHANGELOG`, `.editorconfig`/`.gitattributes`, `.github` şablonları.~~ TAMAM
- ~~**R2** Sürümleme: `VERSION` (1.0.0 "Dardania"), `profiledef.sh` `SHALAOS_VERSION`
  env-fallback, release-notes şablonu.~~ TAMAM
- ~~**R3** CI/CD: `.github/workflows/build-iso.yml` (tag → mkarchiso → SHA-256 + GPG imza →
  Release), `lint.yml` (shellcheck), `docs/BUILD.md`.~~ TAMAM
- ~~**R4** Tanıtım: zengin `README.md`(+`.en`), `docs/` GitHub Pages sitesi (koyu-kırmızı),
  `docs/kurulum.md`, `docs/TEST-CHECKLIST.md`, `pages.yml`.~~ TAMAM
- **R5** Public geçiş & ilk resmî sürüm — **kısmen TAMAM:**
  1. ~~Depo **public** yapıldı; Pages "GitHub Actions" kaynağıyla aktif — site canlı:
     https://edizsale.github.io/shalaos/~~ (22 Tem 2026)
  2. ~~CI kanıtlandı: `build-iso` `workflow_dispatch` ile imzasız ISO üretti; `lint` yeşil.~~
  3. **BEKLİYOR (kullanıcı):** GPG anahtarı üret + `SHALAOS_GPG_KEY`/`SHALAOS_GPG_PASSPHRASE`
     secret ekle, public key `KEYS`'e commit (`docs/BUILD.md` §3).
  4. **BEKLİYOR:** `v1.0.0` tag'i at → ilk imzalı Release. (dardania deposu private kalabilir;
     ISO self-contained.)

### v1.0.x sonrası fikirler (henüz UYGULANMADI — plan)

- **R6 — ShalaOS paket deposu — DETAYLI TASARIM: `docs/R6-paket-deposu.md`** (hedef v1.0.3).
  Uygulamadan önce o belgeyi oku; paket ayrımı, `/usr/local` yasağı, `backup=()` kararı,
  `[shalaos]` bloğunun EOS işaretlerinin dışında kalması ve migrasyon sırası orada.
  Özet (kullanıcı isteği 22 Tem 2026):
  Amaç: ShalaOS'a özgü güncellemeleri (tema/branding/varsayılanlar) kullanıcıya ISO indirtmeden
  ulaştırmak. İki katman: (1) Arch paketleri zaten `pacman -Syu` ile gelir; (2) airootfs'teki
  ShalaOS'a özgü dosyalar hiçbir pakete ait olmadığı için güncellenemiyor — bunları **PKGBUILD
  paketlerine** taşı: `shalaos-branding` (os-release, logo, wallpaper, plymouth, welcome),
  `shalaos-dardania` (tema; kaynak dardania reposu), `shalaos-settings` (kdeglobals, panel),
  meta `shalaos-desktop`. **İmzalı `[shalaos]` pacman deposu** (repo db + `.pkg.tar.zst`;
  barındırma GitHub Releases/Pages veya sunucu), CI ile build+imza+yayın. `/etc/pacman.conf`'a
  `[shalaos]` eklenir (ISO'da hazır). Sonuç: paketi güncelle+tag'le → herkes `pacman -Syu` ile
  otomatik alır. Model: EndeavourOS/Manjaro (Fedora point-release DEĞİL; Arch-rolling).

- **R7 — Kullanıcı-dostu güvenlik (kullanıcı ilkesi 22 Tem 2026: "güvenliği artır ama son
  kullanıcıya komplike gelmesin; uçak filosu check-list'i gibi olmasın").**
  - ~~İndirme doğrulaması **katmanlı/opsiyonel** yapıldı: varsayılan yol "indir→USB→başlat";
    `sha256` tek komut opsiyonel; GPG "ileri düzey" olarak `<details>` içinde (README, README.en,
    docs/index.html, docs/kurulum.md).~~ TAMAM (22 Tem 2026)
  - Plan: güvenlik çoğunlukla **arka planda/otomatik** olsun — imzalı `[shalaos]` deposu (R6)
    pacman'de sessizce doğrulanır; makul varsayılanlar (ör. `firewalld` kurulu+aktif,
    `fwupd` firmware güncellemeleri); ileri düzey: Secure Boot desteği. Kullanıcıya elle
    kripto ödevi verme.

## Kullanıcı hakkında

- Türkçe konuşur; komutları VM konsoluna elle yazmak istemez, kopyala-yapıştır
  dostu (heredoc/tek satır) komutlar ver. SSH üzerinden çalışır.
- Kendi ürünü: SHALA Browser (Electron, `edizsale/shala-browser`). Debian'da .deb kuruluyordu;
  Arch'a taşınması ayrıca konuşulacak (AppImage/tarball veya PKGBUILD).
