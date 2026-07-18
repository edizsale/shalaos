# ShalaOS

Arch Linux tabanlı, GNOME masaüstülü, macOS esintili özel Linux dağıtımı.

## Build (Debian VM içinde)

Gereksinim: Docker.

```bash
./build.sh
```

ISO `out/` dizinine düşer. Build, `archlinux:latest` imajından türetilen privileged bir
container içinde `mkarchiso` ile yapılır; host'a Arch araçları kurulmaz.

## Yapı

- `profile/` — archiso profili (paket listesi, airootfs, boot menüleri)
- `Dockerfile` + `build.sh` — container'da ISO üretimi
