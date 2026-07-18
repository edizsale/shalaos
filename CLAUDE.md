# ShalaOS

Arch Linux tabanlı, GNOME masaüstülü özel Linux dağıtımı. Abinti'nin (Debian/XFCE alpha,
saf haliyle korunuyor — o repoya DOKUNMA) devamı olan proje. Hedef görünüm: macOS esintisi —
GNOME + GDM + dash-to-dock + özel "dardania" GTK teması (WhiteSur-gtk-theme fork'u, ayrı repo).

## Mimari

- **Build bu makinede YAPILMAZ.** Kaynak burada düzenlenir, tarball GitHub release'ine
  yüklenir, kullanıcı Windows'taki VMware içindeki Debian VM'ine indirir ve orada
  `./build.sh` ile (Docker + archlinux imajı + mkarchiso) ISO üretir.
- `profile/` — archiso profili; archiso master'ın **releng** profilinden kopyalandı
  (live-build'deki auto/ + config/ karşılığı). Önemli parçalar:
  - `profiledef.sh` — ISO adı/etiketi, sıkıştırma, `file_permissions` (airootfs'e eklenen
    her özel izinli dosya buraya da işlenmeli, yoksa izinler kaybolur).
  - `packages.x86_64` — canlı sisteme kurulan paketler (tek sütun, alfabetik).
  - `airootfs/` — canlı sisteme kopyalanan dosyalar (includes.chroot karşılığı).
    Hook/chroot-script mekanizması YOK; özel işler systemd unit veya pacman hook ile yapılır.
  - `grub/`, `efiboot/`, `syslinux/` — boot menüleri (UEFI + BIOS).
- `Dockerfile` + `build.sh` — Abinti'deki düzenin aynısı, içerik mkarchiso'ya göre.
  mkarchiso work dizini kasten container içinde tutulur (volume değil).
- Calamares Arch resmi depolarında YOK (AUR'da var) — Aşama 3'te çözülecek.

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
2. Aşama 2: GNOME canlı ortam (packages.x86_64 + GDM autologin + TR yerel + ShalaOS kimliği)
3. Aşama 3: Calamares (AUR'dan derleme veya EndeavourOS binary deposu — kullanıcıya sorulacak)
4. Aşama 4: dardania teması + macOS düzeni (dconf varsayılanları `airootfs/etc/dconf/db/local.d/`)
5. Aşama 5: VMware test + gerçek donanım (Acer'da Abinti var, ÜZERİNE YAZILMAZ)

## Kullanıcı hakkında

- Türkçe konuşur; komutları VM konsoluna elle yazmak istemez, kopyala-yapıştır
  dostu (heredoc/tek satır) komutlar ver. SSH üzerinden çalışır.
- Kendi ürünü: SHALA Browser (Electron, `edizsale/shala-browser`). Debian'da .deb kuruluyordu;
  Arch'a taşınması ayrıca konuşulacak (AppImage/tarball veya PKGBUILD).
