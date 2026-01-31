# 🔧 Khắc phục lỗi "Ứng dụng chưa được cài đặt"

## ❌ Vấn đề:
Khi tải file `app-debug.apk` về điện thoại và mở, hiện lỗi: **"Ứng dụng chưa được cài đặt"**

## 🔍 Nguyên nhân có thể:

1. **APK chưa được build đầy đủ** - File APK có thể là file tạm trong thư mục `intermediates`
2. **APK bị lỗi trong quá trình build** - Build không hoàn tất
3. **APK không tương thích** - Version Android không đúng
4. **File APK bị hỏng** - File bị lỗi khi copy/tải

## ✅ Giải pháp:

### Cách 1: Rebuild APK đúng cách (Khuyên dùng)

#### Bước 1: Clean project
1. Mở Android Studio
2. Chọn menu: **`Build > Clean Project`**
3. Đợi quá trình clean hoàn tất (30 giây - 1 phút)

#### Bước 2: Rebuild APK
1. Chọn menu: **`Build > Rebuild Project`**
2. Đợi rebuild hoàn tất (1-2 phút)

#### Bước 3: Build APK mới
1. Chọn menu: **`Build > Build Bundle(s) / APK(s) > Build APK(s)`**
2. Đợi build hoàn tất
3. Khi build xong, nhấn **`locate`** trong popup

#### Bước 4: Kiểm tra file APK
- File APK phải ở: `app/build/outputs/apk/debug/app-debug.apk`
- **KHÔNG** dùng file ở: `app/build/intermediates/apk/debug/app-debug.apk` (đây là file tạm)

#### Bước 5: Tải lại APK
1. Copy file APK mới từ `app/build/outputs/apk/debug/app-debug.apk`
2. Tải lại lên điện thoại
3. Gỡ app cũ (nếu có) trước khi cài lại

---

### Cách 2: Build bằng Gradle (Command Line)

#### Bước 1: Mở Terminal trong Android Studio
- View > Tool Windows > Terminal
- Hoặc nhấn `Alt + F12`

#### Bước 2: Clean và Build
```bash
# Windows
.\gradlew.bat clean
.\gradlew.bat assembleDebug

# Linux/Mac
./gradlew clean
./gradlew assembleDebug
```

#### Bước 3: Tìm file APK
- File sẽ ở: `app/build/outputs/apk/debug/app-debug.apk`

---

### Cách 3: Build APK Release (Ổn định hơn)

APK Release thường ổn định hơn Debug APK:

#### Bước 1: Build Release APK
1. Trong Android Studio: **`Build > Generate Signed Bundle / APK`**
2. Chọn **`APK`** > Next
3. Chọn **`Create new...`** để tạo keystore (chỉ cần làm 1 lần)
4. Điền thông tin:
   - **Key store path**: `D:\ABANK\bank-notification-reader.jks`
   - **Password**: Đặt mật khẩu (nhớ lưu lại!)
   - **Key alias**: `bank-notification-reader-key`
   - **Key password**: Có thể giống store password
   - **Validity**: 25 years
   - **First and Last Name**: Tên của bạn
   - **Country Code**: VN
5. Nhấn **`OK`** > **`Next`**
6. Chọn build variant: **`release`**
7. Nhấn **`Finish`**

#### Bước 2: Tìm file APK Release
- File sẽ ở: `app/build/outputs/apk/release/app-release.apk`
- File này đã được ký và ổn định hơn

---

## 🔍 Kiểm tra APK có đúng không:

### 1. Kiểm tra vị trí file:
- ✅ **ĐÚNG**: `app/build/outputs/apk/debug/app-debug.apk`
- ❌ **SAI**: `app/build/intermediates/apk/debug/app-debug.apk` (file tạm)

### 2. Kiểm tra kích thước:
- APK thường có kích thước: **5-15 MB**
- Nếu file quá nhỏ (< 1 MB) → APK bị lỗi

### 3. Kiểm tra bằng ADB (nếu có):
```bash
adb install -r app/build/outputs/apk/debug/app-debug.apk
```
- Nếu lỗi, sẽ hiện thông báo lỗi cụ thể

---

## ⚠️ Các lưu ý khi cài đặt:

### 1. Gỡ app cũ (nếu có):
- Vào Settings > Apps > Bank Notification Reader > Uninstall
- Hoặc dùng ADB: `adb uninstall com.banknotification.reader`

### 2. Cho phép cài đặt từ nguồn không xác định:
- Settings > Security > Cho phép cài đặt từ nguồn không xác định
- Hoặc khi mở APK, chọn "Cho phép" khi được hỏi

### 3. Kiểm tra Android version:
- Đảm bảo điện thoại chạy Android 8.0 (API 26) trở lên

### 4. Kiểm tra dung lượng:
- Đảm bảo điện thoại còn đủ dung lượng (> 20 MB)

---

## 🐛 Nếu vẫn không được:

### Thử các bước sau:

1. **Invalidate Caches**:
   - File > Invalidate Caches / Restart
   - Chọn "Invalidate and Restart"

2. **Xóa thư mục build**:
   - Xóa thư mục `app/build`
   - Rebuild lại project

3. **Kiểm tra lỗi build**:
   - Xem tab "Build" ở dưới Android Studio
   - Kiểm tra có lỗi gì không

4. **Build bằng Android Studio thay vì file tạm**:
   - Luôn dùng menu "Build > Build APK(s)"
   - Không dùng file trong thư mục `intermediates`

5. **Thử cài bằng ADB**:
   ```bash
   adb install -r app/build/outputs/apk/debug/app-debug.apk
   ```
   - Nếu lỗi, sẽ hiện thông báo lỗi cụ thể

---

## ✅ Checklist trước khi tải APK:

- [ ] Đã Clean Project
- [ ] Đã Rebuild Project
- [ ] Đã Build APK từ menu Android Studio
- [ ] File APK ở đúng vị trí: `app/build/outputs/apk/debug/app-debug.apk`
- [ ] File APK có kích thước hợp lý (5-15 MB)
- [ ] Đã gỡ app cũ (nếu có)
- [ ] Đã cho phép cài đặt từ nguồn không xác định

---

## 📞 Nếu vẫn không được:

1. Kiểm tra log trong Android Studio (tab "Build")
2. Thử build APK Release thay vì Debug
3. Kiểm tra xem có lỗi compile không
4. Đảm bảo project đã sync Gradle thành công

---

**Chúc bạn khắc phục thành công! 🎉**



