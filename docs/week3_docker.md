# Hafta 3 – Docker ile Tekrarlanabilirlik

Bu haftada veri işleme pipeline’ı Docker container
içine alınarak ortamdan bağımsız hale getirilmiştir.

## Amaç
- Aynı pipeline’ın farklı sistemlerde
  aynı çıktıyı üretmesini sağlamak
- IoT gateway senaryoları için
  hafif ve sade bir container yapısı kurmak

## Dockerfile Özeti
- Ubuntu 22.04 tabanlı
- Sadece gerekli Linux araçları (sed, grep, awk)
- Pipeline betiği container içinde çalıştırılıyor

## Çalıştırma
```bash
docker build -t iot-gateway-pipeline .
docker run --rm iot-gateway-pipeline
