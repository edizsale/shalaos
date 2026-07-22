# ShalaOS Kurulum Kılavuzu

Bu kılavuz, indirilen ShalaOS ISO'sunu bir bilgisayara nasıl kuracağını anlatır.
ISO'yu üretmek (derlemek) istiyorsan bkz. [BUILD.md](BUILD.md).

> ⚠️ Kurulum diski **siler**. Önemli verilerini yedekle. Denemek için önce bir sanal
> makine (VMware/VirtualBox/QEMU) kullanman önerilir.

## Sistem gereksinimleri

ShalaOS hafiftir; eski/düşük güçlü bilgisayarlar da çalıştırabilir.

| Bileşen | En az | Önerilen |
|---------|-------|----------|
| İşlemci | 64-bit (x86_64), çift çekirdek | 2+ çekirdek, ~2 GHz |
| RAM | 2 GB (canlı ortam) | 4 GB |
| Disk | 20 GB boş (kurulum) | 30 GB+ (SSD) |
| Ekran kartı | OpenGL destekli (entegre yeter) | — |
| Önyükleme | UEFI veya BIOS | UEFI |

Kurucu 15 GB'ın altındaki diskleri reddeder. Kurulum internet gerektirmez.

## 1. ISO'yu indir

En güncel ISO'yu [Releases](https://github.com/edizsale/shalaos/releases) sayfasından indir.
İndirmeye başlamak için bu kadarı yeterli — sonraki adıma geçebilirsin.

<details>
<summary><b>İndirmeni doğrulamak istersen (opsiyonel)</b></summary>

Zorunlu değil. İndirmenin bozulmadığından emin olmak için `.sha256` dosyasını da indir:

```bash
sha256sum -c ShalaOS-*-Dardania-x86_64.iso.sha256   # "OK" görmelisin
```

İleri düzey — ISO'nun gerçekten ShalaOS tarafından yayımlandığını GPG ile doğrula
(public key depo kökündeki `KEYS` dosyasında):

```bash
gpg --import KEYS
gpg --verify ShalaOS-*-Dardania-x86_64.iso.sig ShalaOS-*-Dardania-x86_64.iso
```

`Good signature` görmelisin.

</details>

## 2. Önyüklenebilir USB hazırla

**Linux/macOS** (aygıt adını `lsblk` ile doğrula — yanlış disk veri kaybettirir):

```bash
sudo dd if=ShalaOS-*-Dardania-x86_64.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

**Windows:** [balenaEtcher](https://etcher.balena.io/) veya [Rufus](https://rufus.ie/) ile
ISO'yu USB'ye yaz (Rufus'ta "DD image" modu).

## 3. Canlı ortamdan başlat

1. USB'den önyükle (BIOS/UEFI menüsünden USB'yi seç).
2. Önyükleme menüsünde **"ShalaOS canli ortami"** girdisini seç.
3. Sistem otomatik olarak `shala` kullanıcısıyla masaüstüne girer (şifre sormaz).
   Burada ShalaOS'u kurmadan deneyebilirsin.

## 4. Kur (Calamares)

- Önyükleme menüsünden **"ShalaOS'u kur"** girdisini seçersen kurucu masaüstü açılınca
  kendiliğinden başlar. Alternatif olarak canlı masaüstünde **"ShalaOS'u Kur"** simgesine
  tıkla.
- Kurulum sihirbazı Türkçedir. Adımlar:
  1. **Dil / bölge** — İstanbul saat dilimi, Türkçe klavye varsayılan gelir.
  2. **Disk** — "Diski sil" (tüm disk) en basit seçenektir; ileri kullanıcılar elle
     bölümleme yapabilir.
  3. **Kullanıcı** — kendi kullanıcı adını ve şifreni belirle.
  4. **Özet** ve kurulum. İnternet gerektirmez.
- Bitince ISO'yu/USB'yi çıkarıp yeniden başlat.

## 5. Kurulum sonrası

- Giriş ekranı (SDDM) artık **şifre sorar** (canlı ortamdaki otomatik giriş kapanmıştır);
  kurulumda belirlediğin kullanıcıyla gir.
- Canlı ortama özgü `shala` kullanıcısı ve EndeavourOS deposu kurulan sistemde **bulunmaz**
  (Calamares temizler). Güncelleme normal Arch akışıyla: `sudo pacman -Syu`.
- İlk girişte "ShalaOS'e Hoş Geldiniz" sayfası açılır; kapatınca bir daha gelmez.

## Sorun giderme

- **USB'den açılmıyor:** UEFI'de Secure Boot'u kapat; USB'yi yeniden yaz.
- **Kurucu diski reddediyor:** hedef disk en az **25 GB** olmalı (kurucu 15 GB altını
  reddeder).
- **Ağ:** kurulum internet gerektirmez; kurulum sonrası ağ için Plasma'nın ağ
  yöneticisini (NetworkManager) kullan.
- Diğer sorunlar için [issue aç](https://github.com/edizsale/shalaos/issues).
