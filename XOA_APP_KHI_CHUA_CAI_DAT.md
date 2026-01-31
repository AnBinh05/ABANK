# 🗑️ Xóa app khi chưa cài đặt thành công

Khi app **chưa cài đặt thành công**, có thể vẫn còn package hoặc dữ liệu sót lại gây xung đột. Dưới đây là cách xóa hoàn toàn:

---

## ✅ Cách 1: Xóa qua ADB (Chắc chắn nhất - Khuyên dùng)

### Bước 1: Kết nối điện thoại với máy tính

1. **Bật USB Debugging** trên điện thoại:
   - Vào **Settings > About phone**
   - Nhấn **7 lần** vào **"Build number"** để bật Developer options
   - Vào **Settings > Developer options**
   - Bật **"USB debugging"**

2. **Kết nối điện thoại** với máy tính qua USB

3. **Chấp nhận** "Allow USB debugging" trên điện thoại

### Bước 2: Kiểm tra kết nối

Mở Command Prompt hoặc PowerShell và chạy:
```bash
adb devices
```

Nếu thấy thiết bị hiển thị (có dòng "device"), đã kết nối thành công.

### Bước 3: Kiểm tra app có tồn tại không

```bash
adb shell pm list packages | findstr banknotification
```

Nếu có kết quả → App vẫn còn tồn tại (dù chưa cài đặt thành công)

### Bước 4: Xóa app

```bash
# Xóa app
adb uninstall com.banknotification.reader

# Xóa dữ liệu app (nếu còn)
adb shell pm clear com.banknotification.reader
```

### Bước 5: Kiểm tra đã xóa chưa

```bash
adb shell pm list packages | findstr banknotification
```

Nếu **không có kết quả** → App đã được xóa hoàn toàn! ✅

---

## ✅ Cách 2: Xóa qua Settings (Nếu app còn hiển thị)

### Bước 1: Tìm app trong Settings

1. Vào **Settings > Apps** (hoặc **Application Manager**)
2. Tìm **"Bank Notification Reader"** trong danh sách
3. Nếu không thấy, thử:
   - **Settings > Apps > Show system apps** (Hiện app hệ thống)
   - **Settings > Apps > Menu (3 chấm) > Show disabled apps** (Hiện app đã tắt)

### Bước 2: Xóa app

1. Nhấn vào **"Bank Notification Reader"**
2. Nhấn **"Storage"** (Lưu trữ)
3. Nhấn **"Clear Data"** (Xóa dữ liệu)
4. Nhấn **"Clear Cache"** (Xóa bộ nhớ đệm)
5. Quay lại, nhấn **"Uninstall"** (Gỡ cài đặt)

---

## ✅ Cách 3: Dùng Script Tự Động (Dễ nhất)

### Chạy script xóa app:

```bash
.\xoa-app.bat
```

Script sẽ tự động:
- Kiểm tra kết nối ADB
- Xóa app
- Xóa dữ liệu app
- Kiểm tra kết quả

---

## ✅ Cách 4: Xóa thủ công qua File Manager (Cần quyền root)

⚠️ **CẢNH BÁO**: Chỉ dùng nếu có quyền root và biết rõ đang làm gì!

### Bước 1: Bật "Show hidden files" trong File Manager

### Bước 2: Xóa các thư mục sau (nếu có):

- `/data/data/com.banknotification.reader/`
- `/sdcard/Android/data/com.banknotification.reader/`
- `/sdcard/.banknotification/` (nếu có)

### Bước 3: Khởi động lại điện thoại

---

## ✅ Cách 5: Reset App Preferences

Nếu các cách trên không được, thử reset app preferences:

1. Vào **Settings > Apps**
2. Nhấn **Menu (3 chấm)** ở góc trên phải
3. Chọn **"Reset app preferences"** hoặc **"Reset application preferences"**
4. Xác nhận reset
5. **Khởi động lại điện thoại**

---

## 🔍 Kiểm tra app đã xóa hoàn toàn chưa

### Cách 1: Kiểm tra bằng ADB
```bash
adb shell pm list packages | findstr banknotification
```
- **Không có kết quả** → Đã xóa thành công ✅
- **Có kết quả** → App vẫn còn tồn tại ❌

### Cách 2: Kiểm tra trong Settings
1. Vào **Settings > Apps**
2. Tìm **"Bank Notification Reader"**
3. Nếu không thấy → Đã xóa thành công ✅

### Cách 3: Thử cài lại APK
1. Thử cài APK mới
2. Nếu không còn báo lỗi xung đột → Đã xóa thành công ✅

---

## 🛠️ Script Tự Động (Đã tạo sẵn)

Đã có script `xoa-app.bat` để xóa app tự động. Chỉ cần chạy:

```bash
.\xoa-app.bat
```

Script sẽ:
1. ✅ Kiểm tra kết nối ADB
2. ✅ Kiểm tra thiết bị đã kết nối
3. ✅ Xóa app
4. ✅ Xóa dữ liệu app
5. ✅ Kiểm tra kết quả

---

## ⚠️ Lưu ý quan trọng

1. **USB Debugging**: Phải bật USB Debugging để dùng ADB
2. **Quyền root**: Một số cách xóa thủ công cần quyền root
3. **Khởi động lại**: Sau khi xóa, nên khởi động lại điện thoại
4. **Backup**: Nếu app có dữ liệu quan trọng, hãy backup trước

---

## 📋 Checklist xóa app

- [ ] Đã bật USB Debugging trên điện thoại
- [ ] Đã kết nối điện thoại với máy tính qua USB
- [ ] Đã chạy `adb devices` và thấy thiết bị
- [ ] Đã chạy `adb uninstall com.banknotification.reader`
- [ ] Đã chạy `adb shell pm clear com.banknotification.reader`
- [ ] Đã kiểm tra app đã xóa: `adb shell pm list packages | findstr banknotification`
- [ ] Đã khởi động lại điện thoại
- [ ] Đã thử cài lại APK mới

---

## 🆘 Nếu vẫn không xóa được

### 1. Kiểm tra tên package chính xác:
```bash
adb shell pm list packages | findstr bank
```

### 2. Xem thông tin app:
```bash
adb shell pm dump com.banknotification.reader
```

### 3. Xóa bằng package name đầy đủ:
```bash
adb uninstall -k com.banknotification.reader
```
(Flag `-k` giữ lại data và cache, sau đó xóa data thủ công)

### 4. Thử trên thiết bị khác:
- Có thể là vấn đề của thiết bị
- Thử trên emulator hoặc điện thoại khác

---

## ✅ Sau khi xóa thành công

1. **Khởi động lại điện thoại**
2. **Thử cài lại APK mới**:
   - File: `app/build/outputs/apk/debug/app-debug.apk`
   - Hoặc: `app/build/outputs/apk/release/app-release.apk` (khuyên dùng)
3. **Nếu vẫn lỗi**, xem file `HUONG_DAN_KHAC_PHUC_LOI_CAI_DAT.md`

---

**Chúc bạn xóa app thành công! 🎉**

