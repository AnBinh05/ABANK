# ⚡ Hướng dẫn Build APK NHANH (3 bước)

## 🎯 Cách đơn giản nhất - Dùng Android Studio

### Bước 1: Mở project
1. Mở Android Studio
2. `File > Open` > Chọn thư mục `ABANK`

### Bước 2: Build APK
1. Chọn menu: **`Build > Build Bundle(s) / APK(s) > Build APK(s)`**
2. Đợi 1-2 phút

### Bước 3: Lấy file APK
- Khi build xong, nhấn **`locate`** trong popup
- Hoặc tìm file tại: `app/build/outputs/apk/debug/app-debug.apk`

## 📱 Cài đặt lên điện thoại

### Cách 1: Copy file APK
1. Copy file `app-debug.apk` vào điện thoại (USB, email, cloud...)
2. Mở file APK trên điện thoại
3. Cho phép "Cài đặt từ nguồn không xác định"
4. Nhấn "Cài đặt"

### Cách 2: Dùng ADB (nếu điện thoại đang kết nối USB)
```bash
adb install app/build/outputs/apk/debug/app-debug.apk
```

## ✅ Xong!

Bây giờ bạn có thể mở app trên điện thoại và cấp quyền Notification Access.

---

**Xem thêm**: [HUONG_DAN_BUILD_APK.md](HUONG_DAN_BUILD_APK.md) để biết cách build APK Release đã ký.



