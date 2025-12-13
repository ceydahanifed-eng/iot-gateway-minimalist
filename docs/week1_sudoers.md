# Hafta 1 – Sudoers ile En Az Yetki Uygulaması

Bu projede operator kullanıcısı,
yalnızca cihaz yönetimi için gerekli
olan işlemleri yapabilmektedir.

## Uygulanan Sudoers Kuralı
```bash
operator ALL=(root) NOPASSWD: /bin/systemctl restart iot-gateway.service
