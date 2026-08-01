# Sürüm Notları

ShalaOS'ta her sürümde ne değiştiğini **sade bir dille** anlatır. Teknik ayrıntı arıyorsan
[CHANGELOG.md](../CHANGELOG.md) dosyasına bak.

---

## ShalaOS 1.0.2 "Dardania" — 28 Temmuz 2026

**Kısaca:** Kurulumdan sonra klavyenin Türkçe kalmaması düzeltildi. Yeni özellik yok.

### Ne düzeldi?

**Kurulumda Türkçe klavye seçiyordun ama sistem açılınca klavye İngilizce oluyordu.**

`ğüşiöç` harfleri yazılmıyor, noktalama tuşları yanlış yere düşüyordu. Düzeltmek için
Sistem Ayarları'na girip klavyeyi elle eklemek gerekiyordu — ilk açılışta karşılaşılacak
en sinir bozucu şeylerden biri.

Sebep teknikti: ShalaOS'un masaüstü ortamı klavye ayarını bir dosyadan okuyor, kurulum
programı ise başka bir dosyaya yazıyordu. İkisi birbirini görmüyordu. Artık kurulum,
seçtiğin düzeni doğru yere de yazıyor.

**Artık:** Kurulumda hangi klavyeyi seçtiysen, sistem o klavyeyle açılır. Ayarlara girmene
gerek yok.

> Not: Bu yalnızca Türkçe için değil — Almanca, Fransızca, hangi düzeni seçersen o gelir.

### Bu bende de oluyor, ne yapmalıyım?

**Yeniden kurmana gerek yok.** Zaten elle düzelttiysen bir şey yapmana gerek yok; ayarın
korunur.

Henüz düzeltmediysen iki seçenek:

**Seçenek 1 — Ayarlardan (hızlı):**
1. Sistem Ayarları → **Klavye** → **Düzenler**
2. **Düzenleri yapılandır**'ı işaretle, **Ekle** ile *Türkçe*'yi ekle
3. Uygula

**Seçenek 2 — Yeni sürümü kur:** 1.0.2 ISO'sunda bu ayar kurulumdan itibaren doğru gelir.

---

## ShalaOS 1.0.1 "Dardania" — 27 Temmuz 2026

**Kısaca:** Küçük ama can sıkıcı bir sorun düzeltildi. Yeni özellik yok; kurulum, tema ve
programlar 1.0.0 ile aynı.

### Ne düzeldi?

**Kapatıp açınca programlar kendiliğinden geri geliyordu.**

ShalaOS'u kurup ilk kez açtığında her şey normaldi. Ama bilgisayarı kapatıp tekrar
açtığında, önceki oturumda açık bıraktığın programlar (örneğin tarayıcı penceresi ya da
terminal) kendiliğinden yeniden açılıyordu. Kullanıcı bunu "izinsiz açılan programlar" gibi
algılıyordu.

Sebebi bir arıza değildi: KDE Plasma masaüstü, varsayılan olarak "kapatırken açık olan
programları bir dahaki sefere geri getir" şeklinde ayarlıdır. Biz bunu ShalaOS'ta
**kapalı** hale getirdik.

**Artık:** Her açılışta masaüstün tertemiz başlar. Sadece senin başlattığın programlar açılır.

### Bu bende de oluyor, ne yapmalıyım?

**Yeniden kurmana gerek yok.** İki seçeneğin var:

**Seçenek 1 — Ayarlardan düzelt (30 saniye, en kolay):**
1. Sistem Ayarları'nı aç
2. **Başlangıç ve Kapanış** → **Masaüstü Oturumu**
3. *Oturum Açıldığında* kısmında **"Boş oturumla başla"** seç
4. Uygula

**Seçenek 2 — Yeni sürümü kur:** 1.0.1 ISO'sunu indirip temiz kurulum yaparsan bu ayar
zaten hazır gelir.

> Not: Bu ayar senin tercihindir. İleride "kaldığım yerden devam etsin" istersen aynı
> menüden geri açabilirsin — ShalaOS sadece varsayılanı değiştirdi, seçeneği kaldırmadı.

---

## ShalaOS 1.0.0 "Dardania" — 22 Temmuz 2026

**İlk resmî sürüm.** ShalaOS bu sürümle birlikte herkese açık, indirilebilir bir dağıtım
oldu.

### Neler var?

- **Kırmızı kartal kimliği her yerde** — açılış ekranı, giriş ekranı, duvar kağıdı, başlat
  düğmesi ve karşılama sayfası ShalaOS'a özel.
- **Dardania teması** — koyu zemin, kırmızı vurgu. Göz yormayan, toparlı bir masaüstü.
- **Türkçe hazır gelir** — dil, klavye ve saat dilimi (İstanbul) kurulumdan önce ayarlı.
- **Önce dene, sonra kur** — USB'den açıp sistemi hiç kurmadan deneyebilirsin. Beğenirsen
  masaüstündeki kurulum aracıyla diske kurarsın. Kurulum **internet gerektirmez**.
- **Sürekli güncel kalır** — Arch Linux tabanlı olduğu için sürüm atlamaya gerek yok;
  `sudo pacman -Syu` komutu sistemi güncel tutar.
- **İndirdiğini doğrulayabilirsin** — her sürüm imzalıdır; isteyen tek komutla dosyanın
  bozulmadığını kontrol edebilir (zorunlu değil).

### Bilinen sorun

Kapatıp açınca programların geri gelmesi (yukarıda anlatılan sorun) bu sürümde vardı;
**1.0.1'de düzeltildi**.

---

## Nereden indirilir?

ISO dosyası boyutu nedeniyle **SourceForge**'da barındırılıyor:
👉 https://sourceforge.net/projects/shalaos/files/

Sağlama ve imza dosyaları [GitHub Releases](https://github.com/edizsale/shalaos/releases)
sayfasındadır. Kurulum adımları: [kurulum.md](kurulum.md).
