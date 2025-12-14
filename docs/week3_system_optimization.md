# Hafta 3 – Sistem Optimizasyonu ve Log Yönetimi

Bu haftada IoT gateway cihazlarının
uzun süreli ve güvenli çalışması için
sistem servisleri ve log yapısı
optimize edilmiştir.

## Servis Maskeleme
systemd-analyze blame çıktısı
incelenmiş, açılışı yavaşlatan ve
IoT senaryosu için gereksiz olan
servisler tamamen maskelenmiştir.

Maskelenen servisler:
- man-db.service
- apt-daily.service
- apt-daily-upgrade.service
- cups.service

Bu sayede boot süresi azaltılmıştır.

## RAM Disk (tmpfs) Kullanımı
SD kart / disk ömrünü korumak amacıyla
/var/log dizini tmpfs üzerine taşınmıştır.

Loglar çalışma sırasında RAM üzerinde
tutulmakta, disk yazımı minimize edilmektedir.

## Günlük ve Hata Analizi
journalctl kullanılarak sistem ve
Docker servis logları incelenmiş,
kritik hata bulunmadığı görülmüştür.

Bu yaklaşım, IoT cihazlarında
kararlı ve sürdürülebilir bir
çalışma ortamı sağlar.
