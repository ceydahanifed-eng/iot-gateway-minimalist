# Week 3 – System Optimization & Log Management (IoT Gateway)

Bu haftada IoT gateway cihazlarının uzun süreli, kararlı ve düşük kaynak tüketimiyle
çalışabilmesi için işletim sistemi seviyesinde optimizasyonlar yapılmıştır.

Çalışmalar uygulama (script) seviyesinde değil, doğrudan **Linux sistem servisleri,
log altyapısı ve boot süreci** üzerinde gerçekleştirilmiştir.

---

## Amaç

- IoT gateway cihazlarında gereksiz servisleri tespit etmek
- Sistem açılış süresini (boot time) azaltmak
- Arka planda çalışan servislerin CPU ve disk yükünü minimize etmek
- Disk / SD kart ömrünü korumak
- Log davranışlarını analiz edilebilir ve güvenli hale getirmek

---

## Boot Analizi

Sistem açılış süresi aşağıdaki komut ile analiz edilmiştir:

bash
systemd-analyze blame

Servis Maskeleme (Service Masking)
IoT gateway kullanımında gereksiz olan servisler ve onları tetikleyen timer birimleri tamamen maskelenmiştir.
Maskelenen servisler:
man-db.service / man-db.timer
apt-daily.service / apt-daily.timer
apt-daily-upgrade.service / apt-daily-upgrade.timer
cups.service
Maskeleme işlemi ile:
Servislerin manuel veya otomatik olarak yeniden başlaması engellenmiştir
Boot süresi kısalmıştır
Arka plan CPU ve disk kullanımı azaltılmıştır
RAM Disk (tmpfs) Kullanımı
IoT cihazlarında disk veya SD kart ömrünü korumak amacıyla, log dizini RAM disk (tmpfs) üzerine taşınmıştır.
Log dizini:
Kodu kopyala
Text
/var/log/iot-gateway
Bu dizin aşağıdaki şekilde tmpfs olarak mount edilmiştir:
Kodu kopyala
Bash
mount | grep iot-gateway
df -h | grep iot-gateway
Bu yapı sayesinde:
Log yazımları fiziksel diske yapılmaz
Disk aşınması minimize edilir
Sistem performansı korunur
Cihaz yeniden başlatıldığında loglar temiz bir şekilde başlar
Günlük (Log) ve Hata Analizi – RCA
Sistem ve servis logları journalctl kullanılarak incelenmiştir:
Kodu kopyala
Bash
journalctl -p err..alert
Yapılan incelemede:
IoT gateway veri işleme pipeline’ını etkileyen kritik bir hata tespit edilmemiştir
Görülen uyarıların çoğunun WSL ve kernel soyutlama katmanına ait olduğu belirlenmiştir
Bu uyarıların uygulama seviyesinde veri kaybına veya servis kesintisine yol açmadığı görülmüştür
Bu süreç bir Root Cause Analysis (RCA) çalışması olarak değerlendirilmiştir.
