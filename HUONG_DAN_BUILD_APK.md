# 📦 Hướng dẫn Build APK để cài đặt trên điện thoại

## 🎯 Cách 1: Build APK Debug (Đơn giản nhất - Không cần signing)

### Bước 1: Mở project trong Android Studio

1. Mở Android Studio
2. Chọn `File > Open` và chọn thư mục `ABANK`
3. Đợi Gradle sync hoàn tất

### Bước 2: Build APK Debug

**Cách A: Dùng menu Android Studio**
1. Chọn menu `Build > Build Bundle(s) / APK(s) > Build APK(s)`
2. Đợi quá trình build hoàn tất (thường mất 1-2 phút)
3. Khi build xong, sẽ có thông báo popup
4. Nhấn `locate` để mở thư mục chứa APK

**Cách B: Dùng Gradle**
1. Mở tab `Gradle` ở bên phải Android Studio
2. Mở rộng: `ABANK > app > Tasks > build`
3. Double-click vào `assembleDebug`
4. Đợi build xong, APK sẽ ở: `app/build/outputs/apk/debug/app-debug.apk`

**Cách C: Dùng Terminal/Command Line**
```bash
# Windows PowerShell
cd D:\ABANK
.\gradlew.bat assembleDebug

# Hoặc nếu có Gradle global
gradlew assembleDebug
```

### Bước 3: Tìm file APK

File APK sẽ nằm tại:
```
ABANK/app/build/outputs/apk/debug/app-debug.apk
```

### Bước 4: Cài đặt APK lên điện thoại

**Cách A: Qua USB (ADB)**
1. Kết nối điện thoại qua USB
2. Bật USB Debugging trên điện thoại
3. Mở Terminal trong Android Studio hoặc Command Prompt
4. Chạy lệnh:
   ```bash
   adb install app/build/outputs/apk/debug/app-debug.apk
   ```

**Cách B: Copy file APK**
1. Copy file `app-debug.apk` vào điện thoại (qua USB, email, cloud...)
2. Mở file APK trên điện thoại
3. Cho phép "Cài đặt từ nguồn không xác định" (nếu được hỏi)
4. Nhấn "Cài đặt"

---

## 🔐 Cách 2: Build APK Release (Đã ký - Khuyên dùng cho production)

### Bước 1: Tạo keystore (chỉ cần làm 1 lần)

**Cách A: Dùng Android Studio**
1. `Build > Generate Signed Bundle / APK`
2. Chọn `APK` > Next
3. Chọn `Create new...` để tạo keystore mới
4. Điền thông tin:
   - **Key store path**: Chọn nơi lưu (ví dụ: `D:\ABANK\bank-notification-reader.jks`)
   - **Password**: Đặt mật khẩu (nhớ lưu lại!)
   - **Key alias**: `bank-notification-reader-key`
   - **Key password**: Có thể giống store password
   - **Validity**: 25 years (mặc định)
   - **First and Last Name**: Tên của bạn
   - **Organizational Unit**: Tùy chọn
   - **Organization**: Tùy chọn
   - **City**: Tùy chọn
   - **State**: Tùy chọn
   - **Country Code**: VN (hoặc mã nước của bạn)
5. Nhấn `OK` > `Next`

**Cách B: Dùng Command Line**
```bash
keytool -genkey -v -keystore bank-notification-reader.jks -keyalg RSA -keysize 2048 -validity 10000 -alias bank-notification-reader-key
```

### Bước 2: Cấu hình signing trong build.gradle

Tôi sẽ tạo file `keystore.properties` và cập nhật `app/build.gradle` để tự động load signing config.

### Bước 3: Build APK Release

**Cách A: Dùng Android Studio**
1. `Build > Generate Signed Bundle / APK`
2. Chọn `APK` > Next
3. Chọn keystore đã tạo (hoặc tạo mới)
4. Chọn build variant: `release`
5. Nhấn `Finish`
6. Đợi build xong

**Cách B: Dùng Gradle**
```bash
.\gradlew.bat assembleRelease
```

### Bước 4: Tìm file APK Release

File APK sẽ nằm tại:
```
ABANK/app/build/outputs/apk/release/app-release.apk
```

---

## ⚡ Cách 3: Build nhanh bằng script (Tự động)

Tôi sẽ tạo script để build tự động.

---

## 📱 Cài đặt APK lên điện thoại

### Yêu cầu:
- Android 8.0 (API 26) trở lên
- Cho phép "Cài đặt từ nguồn không xác định"

### Các bước:

1. **Copy APK vào điện thoại**:
   - Qua USB: Kéo thả file APK vào thư mục Download
   - Qua email: Gửi APK cho chính mình và mở trên điện thoại
   - Qua Google Drive/Dropbox: Upload và tải về trên điện thoại
   - Qua Bluetooth: Gửi file qua Bluetooth

2. **Mở file APK trên điện thoại**:
   - Dùng File Manager (Files, ES File Explorer...)
   - Tìm file APK và nhấn vào

3. **Cho phép cài đặt**:
   - Nếu được hỏi "Cài đặt từ nguồn không xác định", chọn "Cho phép"
   - Hoặc vào Settings > Security > Cho phép cài đặt từ nguồn không xác định

4. **Cài đặt**:
   - Nhấn "Cài đặt"
   - Đợi quá trình cài đặt hoàn tất
   - Nhấn "Mở" hoặc tìm app trong danh sách ứng dụng

---

## 🔍 Kiểm tra APK đã build

Sau khi build, bạn có thể kiểm tra:

1. **Kích thước file**: Thường khoảng 5-10 MB
2. **Tên file**: 
   - Debug: `app-debug.apk`
   - Release: `app-release.apk`
3. **Vị trí**: `app/build/outputs/apk/[debug|release]/`

---

## ⚠️ Lưu ý quan trọng

1. **APK Debug**: 
   - ✅ Dễ build, không cần signing
   - ❌ Không thể cập nhật qua Google Play
   - ✅ Phù hợp để test

2. **APK Release**:
   - ✅ Đã ký, có thể publish
   - ✅ Có thể cập nhật sau này (nếu giữ keystore)
   - ⚠️ Phải giữ keystore cẩn thận (nếu mất sẽ không update được)

3. **Keystore**:
   - 🔒 Giữ keystore và password cẩn thận
   - 📦 Backup keystore ở nhiều nơi
   - ❌ Không commit keystore lên Git

---

## 🐛 Troubleshooting

### Lỗi: "Gradle sync failed"
- Kiểm tra internet connection
- File > Invalidate Caches / Restart
- Xóa thư mục `.gradle` và sync lại

### Lỗi: "Build failed"
- Kiểm tra Logcat để xem lỗi cụ thể
- Đảm bảo đã sync Gradle thành công
- Thử Clean Project: `Build > Clean Project`

### APK không cài được trên điện thoại
- Kiểm tra Android version (phải >= 8.0)
- Cho phép "Cài đặt từ nguồn không xác định"
- Thử gỡ app cũ (nếu đã cài) rồi cài lại

### APK quá lớn
- Bật minify: `minifyEnabled true` trong build.gradle
- Sử dụng ProGuard/R8 để giảm kích thước

---

## 📞 Hỗ trợ

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra log trong Android Studio
2. Xem file [README.md](README.md) để biết thêm thông tin
3. Tạo issue trên GitHub (nếu có)

---

**Chúc bạn build APK thành công! 🎉**



