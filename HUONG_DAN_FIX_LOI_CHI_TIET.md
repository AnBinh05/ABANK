# 🔧 HƯỚNG DẪN FIX LỖI "ỨNG DỤNG CHƯA ĐƯỢC CÀI ĐẶT" - CHI TIẾT

## ✅ ĐÃ SỬA CÁC LỖI SAU:

1. ✅ **AndroidManifest.xml** - Đã thêm đầy đủ manifest
2. ✅ **extractNativeLibs** - Đã set thành `true`
3. ✅ **versionCode** - Đã tăng lên 2 để tránh xung đột
4. ✅ **Universal APK** - Đã tắt ABI splits
5. ✅ **Packaging** - Đã cấu hình đúng

---

## 🚨 VẤN ĐỀ QUAN TRỌNG NHẤT:

**BẠN PHẢI REBUILD APK MỚI SAU KHI ĐÃ SỬA CODE!**

APK cũ (build trước khi sửa) sẽ KHÔNG hoạt động. Bạn PHẢI build APK mới.

---

## 📋 CÁC CÁCH BUILD APK:

### Cách 1: Dùng Android Studio (KHUYÊN DÙNG)

1. **Mở Android Studio**
2. **Sync Gradle**: 
   - `File > Sync Project with Gradle Files`
   - Đợi sync xong (có thể mất 1-2 phút)
3. **Clean Project**:
   - `Build > Clean Project`
   - Đợi clean xong
4. **Rebuild Project**:
   - `Build > Rebuild Project`
   - Đợi rebuild xong (1-2 phút)
5. **Build APK**:
   - `Build > Build Bundle(s) / APK(s) > Build APK(s)`
   - Đợi build xong
6. **Lấy APK**:
   - Khi build xong, nhấn **"locate"** trong popup
   - Hoặc vào: `app\build\outputs\apk\debug\app-debug.apk`

### Cách 2: Dùng Command Line (Nếu có Gradle)

```cmd
cd D:\ABANK
gradlew.bat clean
gradlew.bat assembleDebug
```

### Cách 3: Dùng Script build-apk.bat

```cmd
cd D:\ABANK
build-apk.bat
```

---

## 🔍 KIỂM TRA APK MỚI ĐÃ ĐƯỢC BUILD:

### 1. Kiểm tra thời gian file:
- File APK phải có thời gian tạo **MỚI NHẤT** (vừa build xong)
- Nếu file cũ → Bạn đang dùng APK cũ!

### 2. Kiểm tra vị trí:
- ✅ **ĐÚNG**: `app\build\outputs\apk\debug\app-debug.apk`
- ❌ **SAI**: `app\build\intermediates\apk\debug\app-debug.apk`

### 3. Kiểm tra kích thước:
- APK thường: **5-15 MB**
- Nếu < 1 MB → APK bị lỗi

---

## 🐛 NẾU VẪN KHÔNG CÀI ĐƯỢC SAU KHI REBUILD:

### Bước 1: Gỡ app cũ HOÀN TOÀN

**Cách 1: Trên điện thoại**
- Settings > Apps > Bank Notification Reader > Uninstall
- Đảm bảo đã gỡ HOÀN TOÀN

**Cách 2: Dùng ADB (nếu có)**
```cmd
adb uninstall com.banknotification.reader
```

### Bước 2: Xóa cache Package Installer

**Trên điện thoại:**
- Settings > Apps > Package Installer > Storage > Clear Cache
- Settings > Apps > Package Installer > Storage > Clear Data

### Bước 3: Khởi động lại điện thoại

- Tắt nguồn và bật lại điện thoại

### Bước 4: Thử cài lại APK mới

- Dùng APK vừa rebuild (không dùng APK cũ!)

---

## 🔧 CÁC VẤN ĐỀ KHÁC CÓ THỂ GÂY LỖI:

### 1. Android Version không đủ
- **Yêu cầu**: Android 8.0 (API 26) trở lên
- **Kiểm tra**: Settings > About phone > Android version

### 2. Dung lượng không đủ
- **Yêu cầu**: Ít nhất 20 MB trống
- **Kiểm tra**: Settings > Storage

### 3. Chưa cho phép cài đặt từ nguồn không xác định
- **Cách**: Settings > Security > Cho phép cài đặt từ nguồn không xác định
- Hoặc khi mở APK, chọn "Cho phép"

### 4. APK bị hỏng khi copy
- **Cách**: Copy lại APK từ máy tính
- Hoặc dùng ADB: `adb install app-debug.apk`

### 5. Xung đột với app khác
- **Cách**: Gỡ tất cả app có cùng package name
- Kiểm tra: `adb shell pm list packages | findstr banknotification`

---

## 🧪 TEST APK BẰNG ADB (Nếu có):

```cmd
cd D:\ABANK
adb install -r app\build\outputs\apk\debug\app-debug.apk
```

Nếu lỗi, ADB sẽ hiển thị thông báo lỗi cụ thể. Copy thông báo lỗi và gửi lại.

---

## 📝 CHECKLIST ĐẦY ĐỦ:

- [ ] Đã mở Android Studio
- [ ] Đã Sync Gradle Files
- [ ] Đã Clean Project
- [ ] Đã Rebuild Project
- [ ] Đã Build APK mới
- [ ] File APK có thời gian tạo MỚI NHẤT
- [ ] File APK ở đúng vị trí: `app\build\outputs\apk\debug\app-debug.apk`
- [ ] File APK có kích thước hợp lý (5-15 MB)
- [ ] Đã gỡ app cũ HOÀN TOÀN
- [ ] Đã xóa cache Package Installer
- [ ] Đã khởi động lại điện thoại
- [ ] Đã cho phép cài đặt từ nguồn không xác định
- [ ] Điện thoại chạy Android 8.0 trở lên
- [ ] Điện thoại còn đủ dung lượng (> 20 MB)

---

## 🆘 NẾU VẪN KHÔNG ĐƯỢC:

Vui lòng cung cấp thông tin sau:

1. **Thông báo lỗi cụ thể** khi cài APK (chụp màn hình)
2. **Android version** của điện thoại
3. **Đã rebuild APK chưa?** (thời gian file APK)
4. **Đã gỡ app cũ chưa?**
5. **Thông báo lỗi từ ADB** (nếu dùng ADB install)

---

**Lưu ý quan trọng**: Nếu bạn vẫn dùng APK cũ (build trước khi sửa), lỗi sẽ VẪN CÒN. Bạn PHẢI rebuild APK mới!

