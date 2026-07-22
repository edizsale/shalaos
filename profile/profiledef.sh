#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="shalaos"
iso_label="SHALAOS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="ShalaOS <https://github.com/edizsale/shalaos>"
iso_application="ShalaOS Canli Ortami"
# Sürüm: CI/kullanıcı SHALAOS_VERSION verirse onu kullan (ör. 1.0.0);
# verilmezse eski davranış — tarih bazlı (VM'de elle derleme birebir korunur).
iso_version="${SHALAOS_VERSION:-$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)}"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/shalaos-brand"]="0:0:755"
  ["/usr/local/bin/shalaos-hosgeldiniz"]="0:0:755"
  ["/usr/local/bin/shalaos-kur"]="0:0:755"
  ["/usr/local/bin/shalaos-kur-otomatik"]="0:0:755"
  ["/usr/local/bin/shalaos-initramfs-kur"]="0:0:755"
  ["/etc/sudoers.d"]="0:0:750"
  ["/etc/sudoers.d/g_wheel"]="0:0:440"
  ["/etc/gshadow"]="0:0:400"
)
