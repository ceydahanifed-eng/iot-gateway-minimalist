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
