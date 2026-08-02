# R6 — ShalaOS Paket Deposu (tasarım belgesi)

> **Durum:** Plan. Henüz uygulanmadı. Hedef sürüm: **v1.0.5**.
> Bu bir geliştirici belgesidir; son kullanıcıyı ilgilendirmez.

## 1. Problem

ShalaOS'a özgü ~60 dosya (tema, logo, duvar kağıdı, varsayılan ayarlar, karşılama sayfası)
`profile/airootfs/` üzerinden ISO'ya **kopyalanıyor**. Kurulan sistemde bunlar hiçbir pakete
ait olmadığı için `pacman -Syu` onlara **asla dokunmaz**.

Sonuç: Arch'tan gelen her şey (çekirdek, KDE, Chromium, güvenlik yamaları) otomatik
güncellenirken, **ShalaOS'un kendi değişiklikleri kullanıcıya hiç ulaşamıyor.**

Canlı örnek: v1.0.1'de oturum hatasını tek satırlık bir `ksmserverrc` ile düzelttik.
v1.0.0 kullanıcısı bu düzeltmeyi güncellemeyle alamadı — ya yeni ISO kuracak ya elle ayar
değiştirecek.

**Hedef:** ShalaOS'a özgü dosyaları pacman paketlerine taşımak ve imzalı bir `[shalaos]`
deposundan yayınlamak. Böylece tema/ayar güncellemeleri de `pacman -Syu` ile akar.
Model: Ubuntu'nun `ubuntu-settings`/`ubuntu-wallpapers` paketleri; Arch tarafında
EndeavourOS/Manjaro.

## 2. Paket ayrımı

Dört paket. Hepsi `arch=('any')` (mimariden bağımsız veri/betik).

### `shalaos-branding`
Kimlik ve markalama. Sürümden sürüme en sık değişecek paket.

| Kaynak (bugünkü yol) | Paket içindeki yol |
|---|---|
| `usr/share/pixmaps/shalaos-logo.png` | aynı |
| `usr/share/icons/hicolor/*/apps/shalaos.png` | aynı |
| `usr/share/wallpapers/ShalaOS/` | aynı |
| `usr/share/shalaos/hosgeldiniz/index.html` | aynı |
| `usr/local/bin/shalaos-hosgeldiniz` | **`usr/bin/shalaos-hosgeldiniz`** |
| `usr/local/bin/shalaos-brand` | **`usr/bin/shalaos-brand`** |
| `usr/local/share/shalaos/watermark.png` | **`usr/share/shalaos/watermark.png`** |
| `etc/xdg/autostart/shalaos-hosgeldiniz.desktop` | aynı |
| `etc/pacman.d/hooks/zz01-shalaos-branding.hook` | aynı |
| `etc/mkinitcpio.conf.d/10-shalaos-plymouth.conf` | aynı |

> **`/usr/local` kuralı:** Arch paketleme standardı, paketlerin `/usr/local` altına dosya
> koymasını **yasaklar** — orası yerel yöneticinin alanıdır. Paketlenen her betik
> `/usr/bin`'e, veri `/usr/share`'e taşınmalı. Hook ve `shalaos-brand` içindeki yollar da
> güncellenmeli.

**`os-release` neden pakete girmiyor:** `/usr/lib/os-release` dosyasının sahibi `filesystem`
paketidir; iki paket aynı dosyaya sahip olamaz. Mevcut çözüm (pacman hook'u ile
`filesystem`/`glibc` güncellemelerinden sonra yeniden yazmak) **doğru yaklaşımdır ve aynen
korunur** — sadece hook artık `shalaos-branding` paketinin bir parçası olur.

### `shalaos-dardania`
Tema. Kaynağı ayrı `dardania` deposu.

- `usr/share/plasma/look-and-feel/org.shalaos.dardania/`
- `usr/share/color-schemes/DardaniaDark.colors`
- `usr/share/aurorae/themes/dardania/`

**Karar gerekiyor:** `dardania` deposu şu an private. PKGBUILD kaynağı olarak ya (a) depoyu
public yapıp doğrudan oradan çekmek, ya da (b) zaten public `shalaos` deposuna senkronlanmış
kopyayı kaynak almak. **(b) önerilir** — CI'da token gerektirmez, `sync-dardania.sh` akışı
değişmez.

### `shalaos-settings`
Sistem geneli varsayılanlar.

- `etc/xdg/kdeglobals`
- `etc/xdg/ksmserverrc`

**Kritik:** Bu dosyalar PKGBUILD'de `backup=()` dizisine konmalı:

```bash
backup=('etc/xdg/kdeglobals' 'etc/xdg/ksmserverrc')
```

Böylece kullanıcı bir ayarı elle değiştirdiyse, güncelleme onu **ezmez** — pacman `.pacnew`
dosyası bırakır. Ödünleşim: elle değiştirilmiş dosyalarda düzeltme otomatik uygulanmaz.
Varsayılanlar için doğru davranış budur (kullanıcının tercihine saygı).

### `shalaos-desktop` (meta)
Dosya içermez, yalnızca bağımlılık toplar:

```bash
depends=('shalaos-branding' 'shalaos-dardania' 'shalaos-settings'
         'plasma-desktop' 'sddm' 'plymouth' ...)
```

v2.0'da bu ikiye ayrılır: `shalaos-desktop-individual` (KDE + Dardania) ve
`shalaos-desktop-pro` (DE'siz + geliştirici araçları). **R6, v2.0'ın önkoşuludur.**

### `shalaos-keyring`
Depo imza anahtarını pacman'in anahtarlığına ekler.

**Tavuk-yumurta sorunu:** `[shalaos]` deposundan paket kurabilmek için anahtarın önceden
güvenilir olması gerekir. Çözüm — EndeavourOS/Manjaro'nun yaptığı:
1. ISO derlenirken `shalaos-keyring` zaten kurulu gelir (anahtarlık ISO'da hazır).
2. Sonraki güncellemelerde anahtarlık kendini paket olarak günceller.

## 3. Pakete GİRMEYECEKLER (ISO'ya özel kalır)

Bunlar yalnızca canlı ortamda anlamlı; Calamares'in temizlik adımı kurulan sistemden zaten
siliyor. Paketlemek yanlış olur:

- `usr/local/share/shalaos/calamares/**` — kurucu yapılandırması ve markalaması
- `usr/local/bin/shalaos-kur`, `shalaos-kur-otomatik`, `shalaos-initramfs-kur`
- `usr/share/applications/shalaos-kur.desktop`
- `etc/sddm.conf.d/shalaos.conf` — canlı ortam otomatik girişi
- `etc/xdg/autostart/shalaos-kur-otomatik.desktop`

## 4. Depo altyapısı

### Üretim
```bash
# Her paket icin
makepkg --sign                    # .pkg.tar.zst + .pkg.tar.zst.sig
# Depo veritabani
repo-add --sign shalaos.db.tar.gz *.pkg.tar.zst
```
Üretilen dosyalar: `shalaos.db`, `shalaos.db.sig`, `shalaos.files`, paketler ve `.sig`'leri.

İmzalama, **release'lerde kullandığımız mevcut GPG anahtarıyla** yapılır
(`SHALAOS_GPG_KEY` secret'ı zaten kurulu, parmak izi `SECURITY.md`'de).

### Barındırma — seçenekler

| Seçenek | Artı | Eksi |
|---|---|---|
| **GitHub Pages** (ayrı `shalaos-repo` deposu) ⭐ | Temiz, sabit URL'ler (`/repo/x86_64/`); ücretsiz; kurulumu kolay | ~1 GB depo sınırı (paketler küçük, sorun değil) |
| SourceForge | Sınırsız bant genişliği; hesap zaten var | Dizin yapısı/URL'ler pacman için daha zahmetli |
| GitHub Releases (sabit `repo` tag'i) | Boyut derdi yok | Varlık güncellemek için sil-yeniden yükle gerekir |

**Öneri: GitHub Pages, ayrı bir `edizsale/shalaos-repo` deposunda.** Ana sitenin (`docs/`)
dağıtımıyla karışmaz. Paketler küçük (branding ~5 MB, tema ~2 MB). Depo büyürse SourceForge
ayna olarak eklenir.

### `pacman.conf` girdisi
```ini
[shalaos]
SigLevel = Required DatabaseRequired
Server = https://edizsale.github.io/shalaos-repo/$arch
```

> **DİKKAT:** Bu blok, `profile/pacman.conf`'ta **`# SHALAOS-EOS-BASLA/BITIR` işaretlerinin
> DIŞINA** yazılmalı. Calamares temizlik adımı o iki işaret arasını `sed` ile siliyor —
> `[shalaos]` bloğu oraya düşerse kurulan sistemde depo kaybolur ve tüm R6 boşa gider.

## 5. CI

Yeni workflow: `.github/workflows/build-packages.yml`

- **Tetik:** `pkg-v*` biçimli tag (ISO tag'lerinden ayrı) + `workflow_dispatch`
- Arch container içinde `makepkg` (mevcut `Dockerfile` tabanı kullanılabilir)
- Paketleri imzala → `repo-add --sign` → `shalaos-repo` deposuna deploy
- ISO workflow'u (`build-iso.yml`) değişmez; sadece ISO derlenirken paketler `[shalaos]`
  deposundan çekilir

## 6. Migrasyon — en riskli kısım

Sıra önemli. Her adım ayrı commit/PR olmalı.

1. **PKGBUILD'leri yaz**, yerelde `makepkg` ile derle, `namcap` ile denetle.
2. **Depoyu yayına al** (henüz ISO'ya bağlamadan). Boş bir sistemde
   `pacman -S shalaos-branding` çalışıyor mu, imza doğrulanıyor mu — test et.
3. **ISO'yu depoya bağla:**
   - `profile/pacman.conf`'a `[shalaos]` bloğu (EOS işaretlerinin dışına!)
   - `profile/packages.x86_64`'e `shalaos-desktop` + `shalaos-keyring`
   - Paketlenen dosyaları **`profile/airootfs/`'ten SİL** — ⚠️ yoksa pacstrap
     **`"exists in filesystem"`** ile patlar. Bu tuzağa `/etc/calamares` ile daha önce
     çarptık (`CLAUDE.md`'de kayıtlı).
   - `profile/profiledef.sh` → `file_permissions`'tan paketlenen `/usr/local/bin/shalaos-*`
     girdilerini kaldır (izinleri artık paket belirliyor). ISO'ya özel kalanlar
     (`shalaos-kur*`) yerinde kalır.
4. **Test ISO'su derle**, VM'de kur, `docs/TEST-CHECKLIST.md`'nin tamamını geç.
5. **v1.0.2 tag'i** → imzalı release.

### Doğrulama ölçütleri
```bash
# Dosyalarin sahibi artik paket mi?
pacman -Qo /usr/share/pixmaps/shalaos-logo.png     # -> shalaos-branding
pacman -Qo /etc/xdg/ksmserverrc                    # -> shalaos-settings

# Depo tanimli ve imza dogrulaniyor mu?
grep -A3 '\[shalaos\]' /etc/pacman.conf
sudo pacman -Sy && sudo pacman -Syu                # imza hatasi VERMEMELI

# Gercek test: paketi bump'la, kullanici tarafinda guncelleme gelsin
sudo pacman -Syu                                   # yeni shalaos-branding gelmeli
```

## 7. Risk notu ve önerilen aşamalandırma

Depo + anahtarlık geçişi, yanlış yapılırsa kullanıcının `pacman -Syu` akışını bozabilecek
türden bir değişiklik. Bu yüzden **tek seferde v1.0.2'ye sıkıştırmak yerine** şu bölünme
önerilir:

- **v1.0.5** — Adım 1–2: paketler üretilir, depo yayına alınır ve *bağımsız olarak* test
  edilir. ISO henüz depoya bağlanmaz (davranış değişmez, risk sıfır).
- **v1.0.6** — Adım 3–5: ISO depoya bağlanır, airootfs temizlenir. Asıl kazanç burada.

Böylece depo altyapısı gerçek kullanımdan önce kanıtlanmış olur. Karar kullanıcıya ait;
tek sürümde de yapılabilir, sadece VM testi daha kapsamlı olmalı.

## 8. Sonrasında açılan kapılar

- **v2.0 Bireysel/Pro** — meta paketlerle temiz ayrım (bu belgenin §2 sonu).
- **"Shala araçları"** (Welcome/Settings/Update/Software Center) — dağıtım kanalı olmadan
  anlamsızdı; R6 sonrası mümkün.
- **`SigLevel = Never` sorununun kalkması** — bugün Calamares imzasız EOS deposundan
  geliyor. İleride Calamares'i kendi imzalı depomuzda paketlersek o zafiyet de kapanır.
