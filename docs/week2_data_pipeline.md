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
