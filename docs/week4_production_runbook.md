# Hafta 4 – Ağ İletişimi, Hata Yönetimi ve Otomasyon

Bu haftada IoT gateway sisteminin üretim (production) senaryosuna uygun hale getirilmesi
amaçlanmıştır. Güvenli veri aktarımı, hata toleransı, otomasyon ve bakım süreçleri
uygulanmıştır.

---

## Amaçlar

- Parola yerine SSH anahtar tabanlı güvenli erişim sağlamak
- Ağ kopmaları durumunda betiğin çökmesini engellemek
- Veri aktarımını otomatik ve güvenilir hale getirmek
- Disk doluluğu ve eski veriler için bakım mekanizması kurmak

---

## 4.1 SSH ve Güvenli Bağlantı

IoT gateway üzerinde parola tabanlı erişim yerine **SSH key-based authentication**
kullanılmıştır.

Kullanılan komutlar:

bash
ssh-keygen -t ed25519 -f ~/.ssh/iot_gateway_key -C "iot-gateway"
cat ~/.ssh/iot_gateway_key.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys



Bağlantı testi:
Kodu kopyala
Bash
ssh -i ~/.ssh/iot_gateway_key -C operator@localhost "echo BAGLANTI_OK"
-C parametresi SSH trafiğini sıkıştırarak bant genişliği kullanımını azaltır.

Güvenli Veri Transferi ve Exponential Backoff
Veri transferi için scp kullanılmıştır. Ağ hataları için Exponential Backoff (bekle–iki katına çıkar–tekrar dene) stratejisi uygulanmıştır.
Betiğin temel davranışı:
Transfer başarısız olursa çıkmaz
Her denemede bekleme süresi artar
Maksimum deneme sayısından sonra kontrollü şekilde hata verir
Örnek log çıktısı:
Kodu kopyala
Text
[INFO] Transfer attempt 1
[WARN] Transfer failed, retrying in 2 seconds...
[INFO] Transfer attempt 2
[WARN] Transfer failed, retrying in 4 seconds...
[SUCCESS] Data transfer completed
Bu yaklaşım IoT sistemlerinde kararlılık (resilience) sağlar.
4.3 Bakım (Maintenance) Betiği
Bakım betiği aşağıdaki görevleri yerine getirir:
Eski sensör verilerini temizler
Disk doluluğunu kontrol eder
%85 üzeri dolulukta acil durum moduna geçer
Gereksiz log yazımını durdurur
Betiğin özellikleri:
Idempotent: Aynı betik defalarca çalıştırılsa bile sistem bozulmaz
Otomatik çalışmaya uygundur
Manuel müdahale gerektirmez
4.4 Zamanlayıcı (Cron)
Otomasyon için operator kullanıcısına cron görevleri eklenmiştir.
Kodu kopyala
Bash
*/10 * * * * /home/ceydahanifed/iot-gateway-minimalist/scripts/week4_transfer.sh >> /var/log/iot-gateway/cron.log 2>&1
0 * * * * /home/ceydahanifed/iot-gateway-minimalist/scripts/week4_maintenance.sh
Bu yapı sayesinde:
Veri transferi düzenli yapılır
Bakım işlemleri otomatik gerçekleşir
İnsan hatası minimize edilir
