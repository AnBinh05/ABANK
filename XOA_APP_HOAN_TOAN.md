# 🗑️ Hướng dẫn xóa app hoàn toàn khi chưa cài đặt thành công

Khi app chưa cài đặt thành công, có thể vẫn còn dữ liệu hoặc package còn sót lại gây xung đột. Dưới đây là các cách xóa hoàn toàn:

---

## ✅ Cách 1: Xóa qua Settings (Nếu app còn hiển thị)

### Bước 1: Tìm app trong Settings
1. Vào **Settings** (Cài đặt)
2. Chọn **Apps** (Ứng dụng) hoặc **Application Manager**
3. Tìm **"Bank Notification Reader"** trong danh sách

### Bước 2: Xóa app
1. Nhấn vào **"Bank Notification Reader"**
2. Nhấn **"Uninstall"** (Gỡ cài đặt)
3. Xác nhận xóa

### Bước 3: Xóa cache và data (nếu có)
1. Vào **Settings > Apps > Bank Notification Reader**
2. Nhấn **"Storage"** (Lưu trữ)
3. Nhấn **"Clear Data"** (Xóa dữ liệu)
4. Nhấn **"Clear Cache"** (Xóa bộ nhớ đệm)
5. Sau đó mới **Uninstall**

---

## ✅ Cách 2: Xóa qua ADB (Khuyên dùng - Xóa hoàn toàn)

### Bước 1: Kết nối điện thoại với máy tính
1. Bật **USB Debugging** trên điện thoại:
   - Vào **Settings > About phone**
   - Nhấn 7 lần vào **"Build number"** để bật Developer options
   - Vào **Settings > Developer options**
   - Bật **"USB debugging"**
2. Kết nối điện thoại với máy tính qua USB
3. Chấp nhận **"Allow USB debugging"** trên điện thoại

### Bước 2: Kiểm tra kết nối
Mở Command Prompt hoặc PowerShell và chạy:
```bash
adb devices
```
Nếu thấy thiết bị hiển thị, đã kết nối thành công.

### Bước 3: Xóa app bằng ADB
```bash
adb uninstall com.banknotification.reader
```

### Bước 4: Xóa dữ liệu app (nếu còn sót)
```bash
adb shell pm clear com.banknotification.reader
```

### Bước 5: Kiểm tra đã xóa chưa
```bash
adb shell pm list packages | findstr banknotification
```
Nếu không có kết quả, app đã được xóa hoàn toàn.

---

## ✅ Cách 3: Xóa qua File Manager (Xóa thủ công)

### Bước 1: Bật "Show hidden files"
1. Mở File Manager
2. Vào Settings của File Manager
3. Bật **"Show hidden files"**

### Bước 2: Xóa thư mục app
Tìm và xóa các thư mục sau (nếu có):
- `/data/data/com.banknotification.reader/`
- `/sdcard/Android/data/com.banknotification.reader/`
- `/sdcard/.banknotification/` (nếu có)

**Lưu ý**: Cần quyền root để xóa thư mục `/data/data/`

---

## ✅ Cách 4: Reset App Preferences (Xóa cài đặt liên quan)

### Bước 1: Reset App Preferences
1. Vào **Settings > Apps**
2. Nhấn menu (3 chấm) ở góc trên phải
3. Chọn **"Reset app preferences"** hoặc **"Reset application preferences"**
4. Xác nhận reset

### Bước 2: Khởi động lại điện thoại
1. Tắt nguồn điện thoại
2. Bật lại

---

## ✅ Cách 5: Xóa qua Recovery Mode (Cực kỳ - Chỉ khi cần)

**⚠️ CẢNH BÁO**: Chỉ dùng khi các cách trên không được. Có thể xóa nhầm dữ liệu khác.

### Bước 1: Vào Recovery Mode
1. Tắt điện thoại
2. Nhấn giữ **Power + Volume Down** (hoặc **Power + Volume Up** tùy điện thoại)
3. Chọn **"Recovery Mode"**

### Bước 2: Wipe Cache Partition
1. Chọn **"Wipe cache partition"**
2. Xác nhận

### Bước 3: Reboot
1. Chọn **"Reboot system now"**

---

## 🔍 Kiểm tra app đã xóa hoàn toàn chưa

### Cách 1: Kiểm tra bằng ADB
```bash
adb shell pm list packages | findstr banknotification
```
Nếu không có kết quả → Đã xóa thành công

### Cách 2: Kiểm tra trong Settings
1. Vào **Settings > Apps**
2. Tìm **"Bank Notification Reader"**
3. Nếu không thấy → Đã xóa thành công

### Cách 3: Thử cài lại
1. Thử cài APK mới
2. Nếu không còn báo lỗi xung đột → Đã xóa thành công

---

## 🛠️ Script tự động xóa (Windows)

Tạo file `xoa-app.bat` và chạy:

```batch
@echo off
echo ========================================
echo   Xoa app Bank Notification Reader
echo ========================================
echo.

echo [1/3] Kiem tra ket noi ADB...
adb devices
if %errorlevel% neq 0 (
    echo [LOI] Khong tim thay ADB hoac thiet bi!
    echo     Vui long:
    echo     1. Cai dat Android SDK Platform Tools
    echo     2. Ket noi dien thoai qua USB
    echo     3. Bat USB Debugging
    pause
    exit /b 1
)

echo.
echo [2/3] Dang xoa app...
adb uninstall com.banknotification.reader
if %errorlevel% equ 0 (
    echo [OK] Da xoa app thanh cong!
) else (
    echo [THONG BAO] App co the da bi xoa hoac chua duoc cai dat.
)

echo.
echo [3/3] Dang xoa du lieu app (neu con)...
adb shell pm clear com.banknotification.reader
if %errorlevel% equ 0 (
    echo [OK] Da xoa du lieu app!
) else (
    echo [THONG BAO] Khong co du lieu de xoa.
)

echo.
echo [Kiem tra] Kiem tra app con ton tai khong...
adb shell pm list packages | findstr banknotification
if %errorlevel% neq 0 (
    echo [OK] App da duoc xoa hoan toan!
) else (
    echo [CANH BAO] App van con ton tai. Thu cach khac.
)

echo.
pause
```

---

## 📋 Checklist xóa app

- [ ] Đã thử xóa qua Settings
- [ ] Đã xóa cache và data trước khi uninstall
- [ ] Đã thử xóa qua ADB: `adb uninstall com.banknotification.reader`
- [ ] Đã xóa dữ liệu: `adb shell pm clear com.banknotification.reader`
- [ ] Đã kiểm tra app đã xóa: `adb shell pm list packages | findstr banknotification`
- [ ] Đã khởi động lại điện thoại
- [ ] Đã thử cài lại APK mới

---

## ⚠️ Lưu ý quan trọng

1. **Backup dữ liệu**: Nếu app có dữ liệu quan trọng, hãy backup trước khi xóa
2. **USB Debugging**: Cần bật USB Debugging để dùng ADB
3. **Quyền root**: Một số cách xóa thủ công cần quyền root
4. **Khởi động lại**: Sau khi xóa, nên khởi động lại điện thoại

---

## 🆘 Nếu vẫn không xóa được

1. **Kiểm tra tên package chính xác**:
   ```bash
   adb shell pm list packages | findstr bank
   ```

2. **Xem thông tin app**:
   ```bash
   adb shell pm dump com.banknotification.reader
   ```

3. **Xóa bằng package name đầy đủ**:
   ```bash
   adb uninstall -k com.banknotification.reader
   ```
   (Flag `-k` giữ lại data và cache)

4. **Liên hệ hỗ trợ** với:
   - Model điện thoại
   - Version Android
   - Thông báo lỗi khi xóa

---

**Chúc bạn xóa app thành công! 🎉**

