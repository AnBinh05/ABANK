# 🔧 Hướng dẫn khắc phục lỗi cài đặt APK - Tổng hợp

## ❌ Vấn đề: APK đã build nhưng không cài đặt được

Nếu bạn đã xuất APK nhưng vẫn không cài đặt được, làm theo các bước sau:

---

## ✅ Bước 1: Kiểm tra APK đã build

### 1.1. Chạy script kiểm tra:
```powershell
.\kiem-tra-apk-chi-tiet.ps1
```

Hoặc kiểm tra thủ công:
- File phải ở: `app/build/outputs/apk/debug/app-debug.apk`
- Kích thước: 5-15 MB (nếu < 1 MB → APK bị lỗi)

### 1.2. Kiểm tra bằng ADB (nếu có):
```bash
adb install -r -d app/build/outputs/apk/debug/app-debug.apk
```
Lệnh này sẽ hiện **lỗi cụ thể** nếu có vấn đề.

---

## ✅ Bước 2: Gỡ app cũ hoàn toàn

**QUAN TRỌNG**: Phải gỡ app cũ trước khi cài lại!

### Cách 1: Dùng script tự động
```bash
.\xoa-app.bat
```

### Cách 2: Qua Settings
1. Settings > Apps
2. Tìm "Bank Notification Reader"
3. Uninstall

### Cách 3: Qua ADB
```bash
adb uninstall com.banknotification.reader
adb shell pm clear com.banknotification.reader
```

**Xem chi tiết**: File `XOA_APP_HOAN_TOAN.md`

---

## ✅ Bước 3: Kiểm tra cài đặt điện thoại

### 3.1. Cho phép cài đặt từ nguồn không xác định:
- **Android 8.0+**: Settings > Apps > Special access > Install unknown apps
- Chọn app bạn dùng để mở APK (Files, Chrome, Email...)
- Bật **"Allow from this source"**

### 3.2. Kiểm tra Android version:
- Phải chạy **Android 8.0 (API 26)** trở lên
- Settings > About phone > Android version

### 3.3. Kiểm tra dung lượng:
- Còn đủ dung lượng (> 50 MB)

---

## ✅ Bước 4: Build APK Release (Khuyên dùng)

**APK Release thường ổn định hơn Debug APK!**

### Cách nhanh nhất:
1. Trong Android Studio: **Build > Generate Signed Bundle / APK**
2. Chọn **APK** > **Create new keystore**
3. Điền thông tin và build
4. File sẽ ở: `app/build/outputs/apk/release/app-release.apk`

**Xem chi tiết**: File `BUILD_APK_RELEASE.md`

---

## ✅ Bước 5: Kiểm tra lỗi cụ thể

### 5.1. Các lỗi phổ biến và cách khắc phục:

| Lỗi | Nguyên nhân | Cách khắc phục |
|-----|-------------|----------------|
| **"Ứng dụng chưa được cài đặt"** | APK bị lỗi hoặc xung đột | Gỡ app cũ, build APK Release |
| **"INSTALL_PARSE_FAILED_NO_CERTIFICATES"** | APK chưa được ký | Build APK Release (đã ký) |
| **"INSTALL_FAILED_UPDATE_INCOMPATIBLE"** | Xung đột với app cũ | Gỡ app cũ hoàn toàn |
| **"INSTALL_FAILED_INSUFFICIENT_STORAGE"** | Thiếu dung lượng | Xóa bớt app/file |
| **"INSTALL_FAILED_INVALID_APK"** | APK bị hỏng | Build lại APK |
| **"INSTALL_FAILED_VERSION_DOWNGRADE"** | Version thấp hơn app cũ | Tăng versionCode trong build.gradle |

### 5.2. Xem log lỗi chi tiết:
```bash
adb install -r -d app/build/outputs/apk/debug/app-debug.apk
```
Flag `-d` sẽ hiện lỗi chi tiết.

---

## ✅ Bước 6: Clean và Rebuild

Nếu vẫn không được, thử clean và rebuild:

### 6.1. Xóa thư mục build:
```bash
# Windows PowerShell
Remove-Item -Recurse -Force app\build

# Hoặc trong Android Studio
# Build > Clean Project
```

### 6.2. Invalidate Caches:
- **File > Invalidate Caches / Restart**
- Chọn **"Invalidate and Restart"**

### 6.3. Rebuild:
- **Build > Rebuild Project**
- **Build > Build Bundle(s) / APK(s) > Build APK(s)**

---

## ✅ Bước 7: Kiểm tra AndroidManifest.xml

Đảm bảo manifest có:
- ✅ `package="com.banknotification.reader"` trong thẻ `<manifest>`
- ✅ `android:exported="true"` cho MainActivity
- ✅ `android:exported="false"` cho NotificationListenerService
- ✅ Icon launcher tồn tại

**Đã được sửa tự động** trong các lần chỉnh sửa trước.

---

## 📋 Checklist đầy đủ

- [ ] Đã kiểm tra file APK tồn tại và có kích thước hợp lý (5-15 MB)
- [ ] Đã gỡ app cũ hoàn toàn (chạy `.\xoa-app.bat`)
- [ ] Đã bật "Cho phép cài đặt từ nguồn không xác định"
- [ ] Điện thoại chạy Android 8.0+ (API 26+)
- [ ] Còn đủ dung lượng (> 50 MB)
- [ ] Đã thử build APK Release (ổn định hơn)
- [ ] Đã kiểm tra log lỗi bằng ADB (`adb install -r -d`)
- [ ] Đã Clean và Rebuild project
- [ ] Đã kiểm tra AndroidManifest.xml

---

## 🎯 Giải pháp nhanh nhất

**Nếu bạn muốn giải quyết nhanh:**

1. **Gỡ app cũ**:
   ```bash
   .\xoa-app.bat
   ```

2. **Build APK Release** (ổn định hơn):
   - Xem file: `BUILD_APK_RELEASE.md`
   - Hoặc: Build > Generate Signed Bundle / APK

3. **Cài APK Release**:
   - File: `app/build/outputs/apk/release/app-release.apk`
   - Copy vào điện thoại và cài đặt

---

## 🆘 Nếu vẫn không được

### 1. Kiểm tra log chi tiết:
```bash
adb install -r -d app/build/outputs/apk/debug/app-debug.apk
```
Gửi thông báo lỗi cụ thể để được hỗ trợ.

### 2. Thử trên thiết bị khác:
- Có thể là vấn đề của thiết bị
- Thử trên emulator hoặc điện thoại khác

### 3. Kiểm tra các file hướng dẫn:
- `KIEM_TRA_APK.md` - Kiểm tra APK chi tiết
- `BUILD_APK_RELEASE.md` - Build APK Release
- `XOA_APP_HOAN_TOAN.md` - Xóa app hoàn toàn
- `KHAC_PHUC_LOI_CAI_DAT.md` - Khắc phục lỗi cài đặt

### 4. Thông tin cần cung cấp khi hỏi:
- Model điện thoại
- Version Android
- Thông báo lỗi cụ thể (từ ADB)
- Kích thước file APK
- Đã thử những cách nào

---

## 📞 Tóm tắt các file hỗ trợ

| File | Mục đích |
|------|----------|
| `kiem-tra-apk-chi-tiet.ps1` | Script kiểm tra APK tự động |
| `xoa-app.bat` | Script xóa app tự động |
| `BUILD_APK_RELEASE.md` | Hướng dẫn build APK Release |
| `KIEM_TRA_APK.md` | Kiểm tra APK chi tiết |
| `XOA_APP_HOAN_TOAN.md` | Xóa app hoàn toàn |
| `KHAC_PHUC_LOI_CAI_DAT.md` | Khắc phục lỗi cài đặt |

---

**Chúc bạn khắc phục thành công! 🎉**

