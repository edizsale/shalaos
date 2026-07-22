# Güvenlik Politikası

## Desteklenen sürümler

ShalaOS aktif geliştirme aşamasındadır. Güvenlik düzeltmeleri **en son yayımlanan sürüme**
uygulanır. Eski ISO'ları kullanan kullanıcıların en güncel sürüme geçmesi önerilir.

## Açık bildirmek

Bir güvenlik açığı bulursan, lütfen **herkese açık bir issue AÇMA.** Bunun yerine:

- E-posta: **edizsale810@gmail.com** (konu satırına `[GÜVENLİK]` yaz)
- Mümkünse: etkilenen sürüm, yeniden üretme adımları ve olası etki.

Makul bir süre içinde yanıt verilmeye çalışılır. Düzeltme yayımlanana kadar detayı gizli
tutmanı rica ederiz (sorumlu açıklama).

## Sürüm bütünlüğü — indirmeni doğrula

Resmî ShalaOS ISO'ları GitHub Releases üzerinden yayımlanır ve şunlarla birlikte gelir:

- `*.iso.sha256` — SHA-256 sağlaması
- `*.iso.sig` / `*.sha256.sig` — projenin GPG anahtarıyla **detached imza** (imza anahtarı
  yapılandırıldığında)

Doğrulama:

```bash
# sağlama
sha256sum -c ShalaOS-*.iso.sha256

# GPG imzası (public key: repo kökündeki KEYS dosyası)
gpg --import KEYS
gpg --verify ShalaOS-*.iso.sig ShalaOS-*.iso
```

Resmî ShalaOS imza anahtarının parmak izi:

```
980F CB0E EA82 B116 E177  C01C 39C1 82E9 731E 2ABF
```

`gpg --verify` çıktısındaki parmak izi bununla aynı olmalı. Yalnızca GitHub
`edizsale/shalaos` **Releases** sayfasından indirilen ve imzası/sağlaması doğrulanan ISO'lar
resmî kabul edilmelidir.
