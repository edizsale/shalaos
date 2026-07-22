# ShalaOS Derleme Rehberi

ShalaOS ISO'su iki yolla üretilebilir: **otomatik CI** (önerilen, resmî release'ler) ve
**elle VM derlemesi** (yerel test).

---

## 1. Otomatik CI (GitHub Actions)

`.github/workflows/build-iso.yml` şunu yapar:

- **Tetik:** `vX.Y.Z` biçiminde bir tag push'lanınca — veya **Actions** sekmesinden
  "ISO derle ve yayınla" → **Run workflow** (elle test).
- Ubuntu runner'da, depodaki `Dockerfile`'dan (`archlinux:latest` + `archiso`) türetilen
  **privileged** bir container içinde `mkarchiso` çalıştırır.
- Sürümü tag'ten alır (`SHALAOS_VERSION`), `SOURCE_DATE_EPOCH`'u commit tarihinden verir
  (deterministik etiket).
- ISO'yu `ShalaOS-<sürüm>-Dardania-x86_64.iso` olarak adlandırır, `.sha256` sağlaması ve
  (secret varsa) `.sig` GPG imzası üretir.
- **Tag'te** GitHub Release oluşturup dosyaları yükler. **Elle çalıştırmada** dosyalar
  yalnızca Actions artefaktı olarak sunulur (release oluşturulmaz).

### Yeni resmî sürüm yayımlama

```bash
# 1) VERSION ve CHANGELOG.md'yi güncelle (sürüm + kod adı)
# 2) tag at ve push et
git tag -a v1.0.0 -m 'ShalaOS 1.0 "Dardania"'
git push origin v1.0.0
# 3) Actions ISO'yu derler, imzalar ve Release'i oluşturur.
```

---

## 2. Elle VM derlemesi (yerel test)

Gereksinim: Docker. (Geçmişte: Windows → VMware → Debian VM.)

```bash
# Sürümü CI ile aynı damgalamak istersen VERSION'ı kaynak al (opsiyonel):
set -a; . ./VERSION; set +a

./build.sh
# ISO out/ dizinine düşer.
```

`SHALAOS_VERSION` tanımlı değilse `profiledef.sh` eski davranışla **tarih bazlı** sürüm
(ör. `2026.07.22`) kullanır — yani env vermezsen hiçbir şey değişmez.

---

## 3. GPG imzalama kurulumu (bir kez)

Resmî ISO'ların imzalanması için depo sahibi bir GPG anahtarı üretip **secret** olarak
ekler. Anahtar üretilene kadar CI ISO'yu imzasız üretir (uyarı verir), süreç bozulmaz.

### 3.1 Anahtar üret (yerel makinende)

```bash
# İnteraktif olmadan bir imzalama anahtarı üret:
cat >/tmp/shalaos-key <<'EOF'
%no-protection
Key-Type: eddsa
Key-Curve: ed25519
Key-Usage: sign
Name-Real: ShalaOS Release Signing
Name-Email: edizsale810@gmail.com
Expire-Date: 0
%commit
EOF
gpg --batch --generate-key /tmp/shalaos-key
rm -f /tmp/shalaos-key

# Parmak izini ve anahtar kimliğini gör:
gpg --list-secret-keys --keyid-format long "edizsale810@gmail.com"
```

> Not: yukarıdaki örnek parolasız (`%no-protection`) anahtar üretir; CI için parola
> yönetimini basitleştirir. Parolalı istersen `%no-protection` satırını kaldır ve parolayı
> `SHALAOS_GPG_PASSPHRASE` secret'ına koy.

### 3.2 Public key'i depoya ekle (`KEYS`)

```bash
gpg --armor --export "edizsale810@gmail.com" > KEYS
git add KEYS && git commit -m "GPG public imza anahtari eklendi" && git push
```

### 3.3 Private key'i GitHub secret olarak ekle

```bash
# ASCII-armored private key'i panoya/dosyaya çıkar:
gpg --armor --export-secret-keys "edizsale810@gmail.com" > /tmp/shalaos-private.asc
```

GitHub → repo → **Settings → Secrets and variables → Actions → New repository secret**:

- `SHALAOS_GPG_KEY` = `/tmp/shalaos-private.asc` dosyasının **tüm içeriği**
- `SHALAOS_GPG_PASSPHRASE` = anahtarın parolası (parolasız ürettiysen bu secret'ı ekleme)

Ardından:

```bash
rm -f /tmp/shalaos-private.asc   # private key'i diskten sil
```

Bundan sonraki her release imzalanır ve `.iso.sig` / `.iso.sha256.sig` dosyaları eklenir.
Kullanıcılar `docs`/`SECURITY.md`'deki adımlarla doğrular.
