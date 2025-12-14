# Hafta 3 – Sistem Optimizasyonu ve Log Yönetimi

Bu haftada IoT gateway cihazlarının uzun süreli ve güvenli çalışması için
sistem servisleri ve log yapısı optimize edilmiştir.

## Boot Analizi
systemd-analyze blame çıktısı incelenmiş, açılışı yavaşlatan ve IoT
senaryosu için zorunlu olmayan servisler tespit edilmiştir.
Kanıt olarak boot_blame.txt dosyası eklenmiştir.

## Servis Maskeleme
Gereksiz servisler ve onları tetikleyen timer birimleri tamamen maskelenmiştir:
- man-db.service / man-db.timer
- apt-daily.service / apt-daily.timer
- apt-daily-upgrade.service / apt-daily-upgrade.timer
- cups.service

Bu sayede servislerin yeniden tetiklenmesi engellenmiş,
boot süresi ve arka plan yükü azaltılmıştır.

## RAM Disk (tmpfs)
Disk/SD kart ömrünü korumak amacıyla log dizini tmpfs (RAM disk) üzerine taşınmıştır.
Çalışma sırasında loglar RAM üzerinde tutulmakta,
disk yazımı minimize edilmektedir.

## Günlük ve Hata Analizi (RCA)
journalctl ile sistem ve Docker servis logları incelenmiş,
kritik hata (err..alert) bulunmadığı görülmüştür.

## Docker ve Operatör Rolü

Bu projede Docker imajları geliştirici kullanıcı tarafından oluşturulmuştur.
Ancak üretim (production) ortamında container çalıştırma sorumluluğu
`operator` kullanıcısına aittir.

Bu yaklaşım, IoT gateway sistemlerinde yaygın olarak kullanılan
"role separation" (rol ayrımı) prensibine uygundur.
Geliştirici sistem dosyalarına müdahale etmez, operatör ise yalnızca
uygulamayı çalıştırmakla yetkilidir.

## Root Cause Analysis (RCA)

Sistem ve uygulama logları incelendiğinde,
IoT gateway veri işleme pipeline’ını etkileyen
kritik bir hata tespit edilmemiştir.

Görülen kernel ve WSL kaynaklı uyarılar,
donanım soyutlama katmanına ait olup
uygulama seviyesinde veri kaybına veya
servis kesintisine yol açmamaktadır.

Veri temizleme betiği her çalıştırmada
hatasız şekilde tamamlanmış ve
kaynak kullanımı kabul edilebilir
seviyelerde kalmıştır.
