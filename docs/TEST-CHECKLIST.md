# ShalaOS Test / QA Kontrol Listesi

Yeni bir ISO üretildikten sonra (CI veya VM), bir sanal makinede aşağıdakileri doğrula.
Mevcut Debian VM'ine dokunma; kurulum testi için **ayrı** bir VM aç
(Guest OS: "Other Linux 6.x kernel 64-bit", RAM ≥ 4 GB, disk ≥ 25 GB).

## Canlı ortam

- [ ] Önyükleme menüsünde **ShalaOS** başlığı ve splash görünüyor.
- [ ] "ShalaOS canli ortami" seçilince sistem açılıyor.
- [ ] SDDM **ShalaOS duvar kağıdıyla** geliyor ve `shala` kullanıcısıyla **otomatik**
      giriş yapıyor (şifre sormadan).
- [ ] Masaüstü **koyu tema + kırmızı vurgu + ShalaOS duvar kağıdı** ile açılıyor.
- [ ] Klavye/dil Türkçe (`ğüşiöç` yazmayı dene).
- [ ] `cat /etc/os-release` → `NAME="ShalaOS"`.
- [ ] `sudo pacman -Syu` şifresiz çalışıyor (Ctrl+C ile kes; kurmana gerek yok).
- [ ] Ağ çalışıyor (Chromium ile bir site aç).

## Kurulum (Calamares)

- [ ] Önyükleme menüsünde **"ShalaOS'u kur"** girdisi var; seçilince masaüstü açılıp
      kurucu **kendiliğinden** başlıyor.
- [ ] Uygulama menüsünde **tek** kurucu girdisi: "ShalaOS'u Kur" (paketin kendi "Calamares"
      girdisi görünmemeli), yönetici uyarısı VERMEDEN açılıyor.
- [ ] Kurucu Türkçe; bölge/saat dilimi İstanbul, klavye tr.
- [ ] "Diski sil" ile kurulum baştan sona hatasız bitiyor (test VM diski ≥ 25 GB).

## Kurulan sistem

- [ ] Yeniden başlatınca (ISO çıkarılmış) GRUB menüsünde **ShalaOS** yazıyor.
- [ ] SDDM **şifre soruyor** (otomatik giriş OLMAMALI); kurulumdaki kullanıcıyla açılıyor.
- [ ] `id shala` → "no such user" (canlı kullanıcı temizlenmiş).
- [ ] Koyu tema + duvar kağıdı geliyor; panelde başlat düğmesi **ShalaOS logosu**.
- [ ] **Klavye düzeni korunuyor (regresyon — v1.0.1'de hata vardı):** kurulumda seçilen
      düzenle açılıyor; `ğüşiöç` yazılabiliyor. Ayarlara girmeye gerek YOK.
      Doğrulama: `cat /etc/xdg/kxkbrc` → `LayoutList=tr` (ya da kurulumda ne seçildiyse).
- [ ] Açılışta **Plymouth**: dönen çember + ShalaOS logosu (UEFI'de üretici logosu üstte;
      kaydırmalı metin GÖRÜNMEMELİ).
- [ ] İlk girişte **"ShalaOS'e Hoş Geldiniz"** sayfası açılıyor; kapanınca bir daha gelmiyor.
- [ ] **Oturum temiz başlıyor (regresyon — v1.0.0'da hata vardı):** birkaç pencere (Konsole,
      Chromium) açıkken kapat/yeniden başlat → ikinci girişte **hiçbiri kendiliğinden
      açılmamalı**. (`/etc/xdg/ksmserverrc` → `loginMode=emptySession`)
- [ ] Chromium menüde var ve açılıyor (varsayılan ve tek tarayıcı).
- [ ] `cat /etc/os-release` → ShalaOS; menüde "ShalaOS'u Kur" artık YOK.
- [ ] `grep -c endeavouros /etc/pacman.conf` → `0` (EOS deposu silinmiş).
- [ ] `sudo pacman -Syu` çalışıyor.
