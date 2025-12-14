# Hafta 2 – Veri İşleme ve Pipeline

Bu haftada IoT cihazlarından gelen kirli sensör verisi,
Linux komut satırı araçları kullanılarak temizlenmiştir.

## Kullanılan Araçlar
- sed   : Alan ayırıcı dönüşümü (; → ,)
- grep  : Format doğrulama
- awk   : Sayısal kontrol ve filtreleme
- time  : İşlem süresi ölçümü

## Pipeline Akışı
```bash
sed → grep → awk → clean CSV
## Süreç ve Kaynak Kullanımı

Veri işleme betiği çalıştırılırken
`time` komutu ile işlem süresi ölçülmüştür.

Ayrıca `ps` komutu ile süreç gözlemlenmiş,
RSS bellek kullanımının birkaç MB seviyesinde
olduğu görülmüştür.

Bu durum, betiğin IoT gateway cihazlarında
düşük kaynak tüketimi ile çalışabileceğini
göstermektedir.
