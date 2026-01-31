# 🗑️ Hướng dẫn xóa app - Đơn giản nhất

Khi app **chưa cài đặt thành công**, vẫn có thể còn package sót lại. Đây là cách xóa đơn giản nhất:

---

## ✅ Cách 1: Dùng Script Tự Động (Dễ nhất)

### Bước 1: Kết nối điện thoại với máy tính

1. **Kết nối điện thoại với máy tính** qua USB
2. **Bật USB Debugging** trên điện thoại:
   - Vào **Settings > About phone**
   - Nhấn **7 lần** vào **"Build number"**
   - Vào **Settings > Developer options**
   - Bật **"USB debugging"**
3. **Chấp nhận** "Allow USB debugging" trên điện thoại

### Bước 2: Chạy script

Mở Command Prompt hoặc PowerShell trong thư mục dự án và chạy:

```bash
.\xoa-app.bat
```

Script sẽ tự động:
- ✅ Kiểm tra kết nối
- ✅ Kiểm tra app có tồn tại không
- ✅ Xóa app
- ✅ Xóa dữ liệu app
- ✅ Kiểm tra kết quả

**Xong!** Bây giờ bạn có thể cài lại APK mới.

---

## ✅ Cách 2: Xóa thủ công qua ADB

Nếu không dùng được script, làm thủ công:

### Bước 1: Kiểm tra kết nối
```bash
adb devices
```
Phải thấy thiết bị hiển thị.

### Bước 2: Kiểm tra app có tồn tại không
```bash
adb shell pm list packages | findstr banknotification
```

### Bước 3: Xóa app
```bash
adb uninstall com.banknotification.reader
```

### Bước 4: Xóa dữ liệu (nếu còn)
```bash
adb shell pm clear com.banknotification.reader
```

### Bước 5: Kiểm tra đã xóa chưa
```bash
adb shell pm list packages | findstr banknotification
```
Nếu **không có kết quả** → Đã xóa thành công! ✅

---

## ✅ Cách 3: Xóa qua Settings (Nếu không có ADB)

### Bước 1: Tìm app
1. Vào **Settings > Apps**
2. Tìm **"Bank Notification Reader"**
3. Nếu không thấy:
   - Thử **Settings > Apps > Show system apps**
   - Hoặc **Settings > Apps > Menu (3 chấm) > Show disabled apps**

### Bước 2: Xóa app
1. Nhấn vào app
2. **Storage > Clear Data**
3. **Uninstall**

---

## ⚠️ Lưu ý

1. **USB Debugging**: Phải bật để dùng ADB
2. **Khởi động lại**: Sau khi xóa, nên khởi động lại điện thoại
3. **Kiểm tra lại**: Sau khi xóa, thử cài lại APK mới

---

## ✅ Sau khi xóa

1. **Khởi động lại điện thoại** (khuyên dùng)
2. **Cài lại APK mới**:
   - File: `app/build/outputs/apk/debug/app-debug.apk`
   - Hoặc build APK Release (ổn định hơn)

---

## 🆘 Nếu vẫn không xóa được

1. **Kiểm tra USB Debugging** đã bật chưa
2. **Khởi động lại điện thoại** và thử lại
3. **Xem file `XOA_APP_KHI_CHUA_CAI_DAT.md`** để biết thêm cách

---

**Chúc bạn xóa app thành công! 🎉**

