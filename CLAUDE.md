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

Her değişiklikten sonra sırayla:
1. `git add -A && git commit && git push` (repo: private `edizsale/shalaos`)
2. `cd /home/edizshala && rm -f shalaos-build.tar.gz && tar czf shalaos-build.tar.gz shalaos-build`
   (DİKKAT: tar'ı home dizininden çalıştır, shalaos-build içinden değil)
3. `gh release upload v1 shalaos-build.tar.gz --repo edizsale/shalaos --clobber`

VM'de root sahipli dosya kalıntıları olabilir (Docker --privileged yüzünden);
kullanıcıya silme komutu verirken `sudo rm -rf` öner.

## Yol haritası (plan: ~/.claude/plans/pure-weaving-scone.md)

1. ~~Aşama 0: repo kurulumu~~ / ~~Aşama 1: build iskeleti (releng tabanı)~~
2. ~~Aşama 2: KDE Plasma canlı ortam + ShalaOS kimliği + TR yerel~~ (VM build testi bekliyor)
3. ~~Aşama 3: Calamares (EndeavourOS binary deposu)~~ — VM kurulum testi GEÇTİ (18 Tem 2026): kurulum uçtan uca, pacman -Syu dahil sorunsuz
4. Aşama 4 v1 TAMAM (18 Tem 2026): dardania ayrı repoda (private `edizsale/dardania`); DardaniaDark renk şeması + LNF + splash. Kaynak orası — ISO kopyasını elle düzenleme, `./sync-dardania.sh` çalıştır. v2 fikirleri: SDDM QML teması, ikon seti, dekorasyon
5. Aşama 5: VMware test + gerçek donanım (Acer'da Abinti var, ÜZERİNE YAZILMAZ)

## Kullanıcı hakkında

- Türkçe konuşur; komutları VM konsoluna elle yazmak istemez, kopyala-yapıştır
  dostu (heredoc/tek satır) komutlar ver. SSH üzerinden çalışır.
- Kendi ürünü: SHALA Browser (Electron, `edizsale/shala-browser`). Debian'da .deb kuruluyordu;
  Arch'a taşınması ayrıca konuşulacak (AppImage/tarball veya PKGBUILD).
