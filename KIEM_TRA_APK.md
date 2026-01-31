# 🔍 Hướng dẫn kiểm tra và khắc phục lỗi cài đặt APK

## ❌ Lỗi: "Ứng dụng chưa được cài đặt"

Nếu bạn đã build lại nhưng vẫn gặp lỗi này, hãy thử các bước sau:

---

## ✅ Bước 1: Kiểm tra file APK

### 1.1. Kiểm tra vị trí file:
- ✅ **ĐÚNG**: `app/build/outputs/apk/debug/app-debug.apk`
- ❌ **SAI**: `app/build/intermediates/apk/debug/app-debug.apk` (file tạm, không dùng được)

### 1.2. Kiểm tra kích thước:
- APK hợp lệ thường có kích thước: **5-15 MB**
- Nếu file < 1 MB → APK bị lỗi, cần build lại

### 1.3. Kiểm tra bằng ADB (nếu có):
```bash
adb install -r app/build/outputs/apk/debug/app-debug.apk
```
- Nếu lỗi, sẽ hiện thông báo lỗi cụ thể (ví dụ: "INSTALL_PARSE_FAILED_NO_CERTIFICATES")

---

## ✅ Bước 2: Gỡ app cũ hoàn toàn

### Cách 1: Qua Settings
1. Vào **Settings > Apps > Bank Notification Reader**
2. Nhấn **Uninstall**
3. Xác nhận gỡ

### Cách 2: Qua ADB
```bash
adb uninstall com.banknotification.reader
```

### Cách 3: Xóa cache và data trước
1. Vào **Settings > Apps > Bank Notification Reader**
2. Nhấn **Storage > Clear Data**
3. Sau đó **Uninstall**

---

## ✅ Bước 3: Kiểm tra cài đặt điện thoại

### 3.1. Cho phép cài đặt từ nguồn không xác định:
- **Android 8.0+**: Settings > Apps > Special access > Install unknown apps
- Chọn ứng dụng bạn dùng để mở APK (Files, Chrome, Email...)
- Bật **"Allow from this source"**

### 3.2. Kiểm tra Android version:
- Đảm bảo điện thoại chạy **Android 8.0 (API 26)** trở lên
- Vào **Settings > About phone > Android version**

### 3.3. Kiểm tra dung lượng:
- Đảm bảo còn đủ dung lượng (> 50 MB)

---

## ✅ Bước 4: Build APK Release (Ổn định hơn Debug)

APK Release thường ổn định và ít lỗi hơn Debug APK:

### 4.1. Tạo keystore (chỉ cần làm 1 lần):
```bash
keytool -genkey -v -keystore bank-notification-reader.jks -keyalg RSA -keysize 2048 -validity 10000 -alias bank-notification-reader-key
```

### 4.2. Cấu hình signing trong `app/build.gradle`:
Thêm vào cuối file `app/build.gradle`:
```gradle
android {
    ...
    signingConfigs {
        release {
            storeFile file('../bank-notification-reader.jks')
            storePassword 'your_password_here'
            keyAlias 'bank-notification-reader-key'
            keyPassword 'your_password_here'
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled false
        }
    }
}
```

### 4.3. Build Release APK:
- Trong Android Studio: **Build > Generate Signed Bundle / APK**
- Hoặc command line: `gradlew assembleRelease`

### 4.4. File APK Release:
- Vị trí: `app/build/outputs/apk/release/app-release.apk`
- File này đã được ký và ổn định hơn

---

## ✅ Bước 5: Kiểm tra log lỗi chi tiết

### 5.1. Cài bằng ADB để xem lỗi cụ thể:
```bash
adb install app/build/outputs/apk/debug/app-debug.apk
```

### 5.2. Xem logcat khi cài đặt:
```bash
adb logcat | grep -i "package\|install\|error"
```

### 5.3. Các lỗi phổ biến và cách khắc phục:

| Lỗi | Nguyên nhân | Cách khắc phục |
|-----|-------------|----------------|
| `INSTALL_PARSE_FAILED_NO_CERTIFICATES` | APK chưa được ký | Build Release APK hoặc kiểm tra signing |
| `INSTALL_FAILED_UPDATE_INCOMPATIBLE` | Xung đột với app cũ | Gỡ app cũ hoàn toàn |
| `INSTALL_FAILED_INSUFFICIENT_STORAGE` | Thiếu dung lượng | Xóa bớt app/file |
| `INSTALL_FAILED_INVALID_APK` | APK bị hỏng | Build lại APK |
| `INSTALL_FAILED_VERSION_DOWNGRADE` | Version thấp hơn app cũ | Tăng versionCode trong build.gradle |

---

## ✅ Bước 6: Clean và Rebuild hoàn toàn

### 6.1. Xóa thư mục build:
```bash
# Windows
rmdir /s /q app\build

# Linux/Mac
rm -rf app/build
```

### 6.2. Clean project:
- Trong Android Studio: **Build > Clean Project**

### 6.3. Invalidate Caches:
- **File > Invalidate Caches / Restart**
- Chọn **"Invalidate and Restart"**

### 6.4. Rebuild:
- **Build > Rebuild Project**
- **Build > Build Bundle(s) / APK(s) > Build APK(s)**

---

## ✅ Bước 7: Kiểm tra AndroidManifest.xml

Đảm bảo manifest có:
- ✅ `package` attribute trong thẻ `<manifest>`
- ✅ `android:exported="true"` cho MainActivity
- ✅ `android:exported="false"` cho NotificationListenerService
- ✅ Icon launcher tồn tại (`@drawable/ic_launcher`)

---

## ✅ Bước 8: Thử cài trên thiết bị khác

Nếu vẫn không được:
1. Thử cài trên điện thoại/emulator khác
2. Kiểm tra xem có phải vấn đề của thiết bị không

---

## 📋 Checklist đầy đủ:

- [ ] File APK ở đúng vị trí: `app/build/outputs/apk/debug/app-debug.apk`
- [ ] File APK có kích thước hợp lý (5-15 MB)
- [ ] Đã gỡ app cũ hoàn toàn
- [ ] Đã bật "Cho phép cài đặt từ nguồn không xác định"
- [ ] Điện thoại chạy Android 8.0+ (API 26+)
- [ ] Còn đủ dung lượng (> 50 MB)
- [ ] Đã Clean và Rebuild project
- [ ] Đã kiểm tra log lỗi bằng ADB
- [ ] Đã thử build APK Release
- [ ] Đã kiểm tra AndroidManifest.xml

---

## 🆘 Nếu vẫn không được:

1. **Kiểm tra log chi tiết bằng ADB**:
   ```bash
   adb install -r -d app/build/outputs/apk/debug/app-debug.apk
   ```
   (Flag `-d` sẽ hiện lỗi chi tiết)

2. **Thử build APK Release** thay vì Debug

3. **Kiểm tra xem có lỗi compile không**:
   - Xem tab "Build" trong Android Studio
   - Kiểm tra có warning/error gì không

4. **Kiểm tra package name**:
   - Đảm bảo `applicationId` trong `build.gradle` khớp với `package` trong `AndroidManifest.xml`

5. **Liên hệ hỗ trợ** với thông tin:
   - Version Android của điện thoại
   - Log lỗi từ ADB
   - Kích thước file APK

---

**Chúc bạn khắc phục thành công! 🎉**

