# IoT Gateway – Minimalist

Bu proje, Linux tabanlı (Ubuntu/WSL) bir IoT ortamında
kirli sensör verisinin komut satırı araçları (grep, sed, awk)
kullanılarak temizlenmesini simüle eden
minimal bir IoT Gateway çalışmasıdır.

## Proje Amacı
- Açık kaynak proje yapısının doğru kurulması
- Least Privilege prensibine uygun kullanıcı modeli
- Kirli verinin boru hattı (pipeline) mantığıyla temizlenmesi
- Temiz verinin standart formatlarda (CSV) üretilmesi
- İşlem süresi ve kaynak kullanımının ölçülmesi

## Klasör Yapısı
- `data/raw`   : Ham (kirli) sensör verileri
- `data/clean` : Temizlenmiş çıktı dosyaları
- `scripts`    : Veri işleme betikleri
- `docs`       : Raporlar ve açıklamalar
- `logs`       : Çalışma logları
- `src`        : (İleri aşamalar için) uygulama bileşenleri

## Gereksinimler
- Ubuntu Linux (WSL kabul edilir)
- bash
- coreutils
- grep, sed, awk

## Çalıştırma
```bash
bash scripts/process_data.sh
