# ShalaOS Build Rehberi (VM'de adım adım)

Bu rehber, Windows bilgisayarındaki VMware içindeki **Debian VM**'de ShalaOS ISO'sunun
nasıl üretileceğini tek tek anlatır. Abinti'deki akışın aynısıdır, sadece araçlar farklı
(live-build yerine mkarchiso). Bütün komutlar kopyala-yapıştır içindir.

---

## 0) Gereksinimler (VM'de bir kere yapılır)

Abinti'yi build ettiğin VM'i kullanıyorsan **bunlar zaten hazır**, bu adımı atla.

- **Docker** kurulu ve çalışıyor olmalı:
  ```bash
  docker --version || (sudo apt update && sudo apt install -y docker.io && sudo usermod -aG docker $USER && echo "Cikip tekrar gir (grup icin)")
  ```
- **GitHub CLI** girişli olmalı (repo private olduğu için şart):
  ```bash
  gh auth status || gh auth login
  ```
- **Boş disk alanı**: en az **20 GB**. Arch build'i Debian'ınkinden daha çok yer yer
  (paket önbelleği + squashfs). Kontrol: `df -h ~`

---

## 1) Kaynağı indir ve aç

Eski kalıntıları silip son tarball'ı çeker (her yeni build öncesi bunu çalıştır,
çünkü ben her değişiklikte release'deki tarball'ı güncelliyorum):

```bash
cd ~ && sudo rm -rf shalaos-build && rm -f shalaos-build.tar.gz && gh release download v1 --repo edizsale/shalaos --pattern shalaos-build.tar.gz && tar xzf shalaos-build.tar.gz && cd shalaos-build
```

Not: `sudo rm` gerekiyor çünkü önceki build'lerden root sahipli dosyalar kalır
(Docker --privileged yüzünden). İlk seferde `sudo` istemese de zararı yok.

## 2) Build'i başlat

```bash
cd ~/shalaos-build && ./build.sh
```

Ne olacak, sırasıyla:
1. `shalaos-builder` Docker imajı kurulur (ilk seferde ~1 GB iner, sonraki
   build'lerde önbellekten gelir, saniyeler sürer).
2. Container içinde `mkarchiso` çalışır: Arch paketlerini internetten indirir
   (~3-4 GB, **ilk build'de en uzun kısım budur**), sistemi kurar, squashfs'e
   sıkıştırır, ISO'yu paketler.
3. Bittiğinde ekranda `Bitti. ISO dosyasi burada: ...` yazar.

ISO şurada olur: **`~/shalaos-build/out/shalaos-2026.MM.GG-x86_64.iso`**

Süre tahmini: internet hızına göre ilk build 30-60 dk; sonraki build'ler daha kısa
sürmez (mkarchiso her seferinde paketleri yeniden çeker — bu normal, Arch rolling).

## 3) ISO'yu VMware'de test et

1. ISO'yu Windows tarafına al (VMware paylaşılan klasör veya `python3 -m http.server`
   ile — Abinti'de nasıl yaptıysan aynısı).
2. VMware'de **yeni** bir VM aç (var olan Debian VM'e dokunma):
   - Guest OS: "Other Linux 6.x kernel 64-bit"
   - RAM: en az 4 GB (Plasma için), disk: 25+ GB
   - CD/DVD → ISO dosyasını göster
3. VM'i başlat.

### Test kontrol listesi

Açılışta ve masaüstünde şunları doğrula, sonucu bana getir:

- [ ] Boot menüsünde **ShalaOS** başlığı ve logo (splash) görünüyor
- [ ] "ShalaOS canli ortami" girdisi seçilince sistem açılıyor
- [ ] Giriş ekranı (SDDM) **ShalaOS duvar kağıdıyla** geliyor ve `shala`
      kullanıcısıyla **kendiliğinden** masaüstüne giriyor (şifre sormamalı)
- [ ] Masaüstü **koyu tema + kırmızı vurgu + ShalaOS duvar kağıdı** ile açılıyor
- [ ] Klavye Türkçe (konsolde `ğüşiöç` yazmayı dene), dil Türkçe
- [ ] Konsole'de `cat /etc/os-release` → `NAME="ShalaOS"` yazmalı
- [ ] Konsole'de `sudo pacman -Syu` şifresiz çalışıyor (kurmana gerek yok, sadece
      şifresiz sudo'yu doğrula, Ctrl+C ile kes)
- [ ] Ağ çalışıyor (Firefox ile bir site aç)

### Kurulum testi (Aşama 3 sonrası)

- [ ] Uygulama menüsünde **"ShalaOS'u Kur"** var ve açılıyor (koyu, ShalaOS logolu kurucu)
- [ ] Kurucu Türkçe; bölge/saat dilimi İstanbul, klavye tr geliyor
- [ ] "Diski sil" ile kurulum baştan sona hatasız bitiyor
- [ ] Yeniden başlatınca (ISO'yu çıkar!) GRUB menüsünde **ShalaOS** yazıyor
- [ ] Kurulan sistem SDDM'de **şifre soruyor** (otomatik giriş OLMAMALI) ve senin
      kurulumda verdiğin kullanıcıyla açılıyor
- [ ] Kurulan sistemde `shala` kullanıcısı YOK (`id shala` → "no such user" demeli)
- [ ] Koyu tema + duvar kağıdı kurulan sistemde de geliyor
- [ ] Panelin sol altındaki **başlat düğmesi ShalaOS logosu** (KDE simgesi değil)
- [ ] İlk girişte **"ShalaOS'e Hoş Geldiniz" sayfası** açılıyor (Chromium penceresi);
      "Başla" ile kapanıyor ve bir sonraki girişte BİR DAHA gelmiyor
- [ ] Chromium menüde var ve açılıyor (canlıda da olmalı)
- [ ] `cat /etc/os-release` → ShalaOS; uygulama menüsünde "ShalaOS'u Kur" artık YOK
- [ ] `sudo pacman -Syu` çalışıyor (EndeavourOS deposu silinmiş olmalı:
      `grep -c endeavouros /etc/pacman.conf` → 0)

## 4) Temizlik (istersen)

Build bittikten sonra yer açmak için:

```bash
docker system prune -f
```

`~/shalaos-build/out/` içindeki eski ISO'ları da elle silebilirsin.

---

## Sorun çıkarsa

- **`docker: permission denied`** → `sudo usermod -aG docker $USER` sonrası VM'den
  çıkıp tekrar gir.
- **Build ortasında "no space left on device"** → `df -h` ile bak; `docker system
  prune -af` + eski ISO'ları sil, tekrar dene.
- **pacman anahtar/imza hatası** (Arch'ta olur) → önce aynen bir kez daha dene
  (`./build.sh`); geçmezse hatanın **son 30-40 satırını** kopyala bana getir.
- **Başka herhangi bir hata** → çıktının son kısmını kopyala, bana yapıştır.
  Tahmin yürütme, çıktı bana yeter.

## Akış özeti (sonraki turlar için ezber)

Ben repoda değişiklik yapıp "tarball güncellendi" dedikçe VM'de sadece şu iki komut:

```bash
cd ~ && sudo rm -rf shalaos-build && rm -f shalaos-build.tar.gz && gh release download v1 --repo edizsale/shalaos --pattern shalaos-build.tar.gz && tar xzf shalaos-build.tar.gz
cd ~/shalaos-build && ./build.sh
```
