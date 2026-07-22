# ShalaOS <SÜRÜM> "<KOD ADI>"

<!-- Örn: ShalaOS 1.0 "Dardania" — bu şablonu her release'te doldur. -->

Arch Linux tabanlı, KDE Plasma masaüstülü, koyu-kırmızı "dardania" temalı ShalaOS'un
**<SÜRÜM>** sürümü.

## Öne çıkanlar

- ...
- ...

## Değişiklikler

<!-- CHANGELOG.md'nin bu sürüme ait bölümünü buraya özetle. -->

## İndirme

| Dosya | Açıklama |
|-------|----------|
| `ShalaOS-<SÜRÜM>-Dardania-x86_64.iso` | Canlı + kurulum ISO'su (x86_64, UEFI + BIOS) |
| `ShalaOS-<SÜRÜM>-Dardania-x86_64.iso.sha256` | SHA-256 sağlaması |
| `ShalaOS-<SÜRÜM>-Dardania-x86_64.iso.sig` | GPG detached imza |

## Doğrulama

```bash
sha256sum -c ShalaOS-<SÜRÜM>-Dardania-x86_64.iso.sha256
gpg --import KEYS
gpg --verify ShalaOS-<SÜRÜM>-Dardania-x86_64.iso.sig ShalaOS-<SÜRÜM>-Dardania-x86_64.iso
```

## Kurulum

Kurulum kılavuzu: [docs/kurulum.md](kurulum.md).

## Bilinen sorunlar

- ...
