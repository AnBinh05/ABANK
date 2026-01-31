# 🔧 FIX DỨT ĐIỂM LỖI "ỨNG DỤNG CHƯA ĐƯỢC CÀI ĐẶT"

## ✅ CÁC LỖI ĐÃ ĐƯỢC SỬA:

### 1. ✅ AndroidManifest.xml đã được sửa đầy đủ
- Đã thêm tất cả permissions cần thiết
- Đã thêm MainActivity và Service
- Đã thêm `android:installLocation="auto"`
- Đã thêm `android:extractNativeLibs="true"` (quan trọng!)
- Đã thêm `android:usesCleartextTraffic="true"`

### 2. ✅ build.gradle đã được cấu hình đúng
- Đã tắt ABI splits (tạo universal APK)
- Đã cấu hình packaging đúng
- Đã đảm bảo signing config

---

## ⚠️ QUAN TRỌNG: BẠN PHẢI REBUILD APK SAU KHI SỬA!

**Nếu bạn vẫn dùng APK cũ (trước khi sửa), lỗi sẽ vẫn còn!**

---

## 🚀 CÁCH REBUILD APK ĐÚNG CÁCH:

### Cách 1: Dùng Script (Khuyên dùng - Đơn giản nhất)

1. **Mở Command Prompt hoặc PowerShell**
2. **Vào thư mục project**:
   ```cmd
   cd D:\ABANK
   ```
3. **Chạy script build**:
   ```cmd
   build-apk.bat
   ```
4. **Đợi build xong** (1-2 phút)
5. **File APK sẽ ở**: `app\build\outputs\apk\debug\app-debug.apk`

### Cách 2: Dùng Android Studio

1. **Mở Android Studio**
2. **Sync Gradle**: `File > Sync Project with Gradle Files` (đợi xong)
3. **Clean Project**: `Build > Clean Project` (đợi xong)
4. **Rebuild Project**: `Build > Rebuild Project` (đợi xong - 1-2 phút)
5. **Build APK**: `Build > Build Bundle(s) / APK(s) > Build APK(s)` (đợi xong)
6. **Nhấn "locate"** trong popup để mở thư mục chứa APK
7. **File APK sẽ ở**: `app/build/outputs/apk/debug/app-debug.apk`

### Cách 3: Dùng Gradle Command Line

1. **Mở Command Prompt hoặc PowerShell**
2. **Vào thư mục project**:
   ```cmd
   cd D:\ABANK
   ```
3. **Clean và Build**:
   ```cmd
   gradlew.bat clean
   gradlew.bat assembleDebug
   ```
4. **File APK sẽ ở**: `app\build\outputs\apk\debug\app-debug.apk`

---

## ✅ KIỂM TRA APK MỚI:

### 1. Kiểm tra vị trí file:
- ✅ **ĐÚNG**: `app\build\outputs\apk\debug\app-debug.apk`
- ❌ **SAI**: `app\build\intermediates\apk\debug\app-debug.apk` (file tạm - KHÔNG dùng!)

### 2. Kiểm tra kích thước:
- APK thường có kích thước: **5-15 MB**
- Nếu file quá nhỏ (< 1 MB) → APK bị lỗi, cần rebuild lại

### 3. Kiểm tra thời gian tạo file:
- File APK phải có thời gian tạo MỚI NHẤT (vừa build xong)
- Nếu file cũ → Bạn đang dùng APK cũ, cần rebuild!

---

## 📱 CÁCH CÀI ĐẶT TRÊN ĐIỆN THOẠI:

### Bước 1: Gỡ app cũ (NẾU CÓ)
- Vào **Settings > Apps > Bank Notification Reader > Uninstall**
- Hoặc dùng ADB: `adb uninstall com.banknotification.reader`

### Bước 2: Copy APK mới vào điện thoại
- Qua USB: Kéo thả file `app-debug.apk` vào thư mục Download
- Qua email: Gửi APK cho chính mình và mở trên điện thoại
- Qua Google Drive: Upload và tải về

### Bước 3: Cho phép cài đặt từ nguồn không xác định
- Khi mở APK, chọn **"Cho phép"** khi được hỏi
- Hoặc vào **Settings > Security > Cho phép cài đặt từ nguồn không xác định**

### Bước 4: Cài đặt
- Nhấn **"Cài đặt"**
- Đợi quá trình cài đặt hoàn tất
- Nhấn **"Mở"** hoặc tìm app trong danh sách ứng dụng

---

## 🔍 NẾU VẪN KHÔNG ĐƯỢC - KIỂM TRA CHI TIẾT:

### 1. Đảm bảo đã rebuild APK:
- ✅ File APK có thời gian tạo MỚI NHẤT
- ✅ File APK ở đúng vị trí: `app\build\outputs\apk\debug\app-debug.apk`
- ✅ File APK có kích thước hợp lý (5-15 MB)

### 2. Kiểm tra Android version:
- Đảm bảo điện thoại chạy **Android 8.0 (API 26) trở lên**
- Vào **Settings > About phone > Android version**

### 3. Kiểm tra dung lượng:
- Đảm bảo điện thoại còn đủ dung lượng (**> 20 MB**)

### 4. Thử cài bằng ADB (nếu có):
```cmd
adb install -r app\build\outputs\apk\debug\app-debug.apk
```
- Nếu lỗi, sẽ hiện thông báo lỗi cụ thể
- Copy thông báo lỗi và gửi lại

### 5. Kiểm tra log build:
- Mở Android Studio
- Xem tab **"Build"** ở dưới
- Kiểm tra có lỗi gì không (màu đỏ)

---

## 🐛 CÁC LỖI THƯỜNG GẶP VÀ CÁCH SỬA:

### Lỗi: "Gradle sync failed"
**Cách sửa:**
1. `File > Invalidate Caches / Restart`
2. Chọn "Invalidate and Restart"
3. Đợi Android Studio khởi động lại
4. Sync lại: `File > Sync Project with Gradle Files`

### Lỗi: "Build failed"
**Cách sửa:**
1. Xem tab "Build" để xem lỗi cụ thể
2. Thử Clean Project: `Build > Clean Project`
3. Thử Rebuild Project: `Build > Rebuild Project`

### Lỗi: "APK không cài được - Package installer has stopped"
**Cách sửa:**
1. Gỡ app cũ hoàn toàn
2. Khởi động lại điện thoại
3. Thử cài lại APK mới

### Lỗi: "APK không cài được - App not installed"
**Cách sửa:**
1. ✅ Đảm bảo đã rebuild APK mới (không dùng APK cũ!)
2. ✅ Gỡ app cũ trước khi cài
3. ✅ Cho phép cài đặt từ nguồn không xác định
4. ✅ Kiểm tra Android version (>= 8.0)
5. ✅ Kiểm tra dung lượng còn trống

---

## 📋 CHECKLIST TRƯỚC KHI CÀI APK:

- [ ] Đã Clean Project
- [ ] Đã Rebuild Project  
- [ ] Đã Build APK mới (không dùng APK cũ!)
- [ ] File APK ở đúng vị trí: `app\build\outputs\apk\debug\app-debug.apk`
- [ ] File APK có kích thước hợp lý (5-15 MB)
- [ ] File APK có thời gian tạo MỚI NHẤT
- [ ] Đã gỡ app cũ (nếu có)
- [ ] Đã cho phép cài đặt từ nguồn không xác định
- [ ] Điện thoại chạy Android 8.0 trở lên
- [ ] Điện thoại còn đủ dung lượng (> 20 MB)

---

## 🎯 TÓM TẮT:

1. **QUAN TRỌNG NHẤT**: Phải rebuild APK sau khi sửa code/manifest!
2. **Dùng APK mới**: File ở `app\build\outputs\apk\debug\app-debug.apk`
3. **Gỡ app cũ**: Trước khi cài APK mới
4. **Cho phép cài đặt**: Từ nguồn không xác định

---

**Nếu vẫn không được sau khi làm đúng các bước trên, vui lòng:**
1. Chụp màn hình lỗi khi cài APK
2. Gửi thông báo lỗi cụ thể (nếu có)
3. Cho biết Android version của điện thoại
4. Cho biết đã rebuild APK chưa

**Chúc bạn khắc phục thành công! 🎉**

