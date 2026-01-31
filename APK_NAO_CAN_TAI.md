# 📱 APK NÀO CẦN TẢI?

## ✅ APK BẠN CẦN TẢI:

**`app-debug.apk`** (hoặc `app-release.apk` nếu build Release)

---

## 📍 VỊ TRÍ FILE APK ĐÚNG:

### ✅ ĐÚNG - File APK có thể cài đặt:
```
D:\ABANK\app\build\outputs\apk\debug\app-debug.apk
```

### ❌ SAI - File tạm (KHÔNG dùng):
```
D:\ABANK\app\build\intermediates\apk\debug\app-debug.apk
```
⚠️ **File này KHÔNG thể cài đặt!** Đây chỉ là file tạm trong quá trình build.

---

## 🎯 CÁCH LẤY FILE APK ĐÚNG:

### Cách 1: Build trong Android Studio (Khuyên dùng)

1. **Mở Android Studio**
2. **Clean Project**: `Build > Clean Project`
3. **Build APK**: `Build > Build Bundle(s) / APK(s) > Build APK(s)`
4. **Đợi build xong** (1-2 phút)
5. **Nhấn `locate`** trong popup → File Explorer sẽ mở đúng thư mục
6. **File APK sẽ ở**: `app/build/outputs/apk/debug/app-debug.apk`

### Cách 2: Tìm thủ công

1. Mở File Explorer
2. Vào: `D:\ABANK\app\build\outputs\apk\debug\`
3. Tìm file: **`app-debug.apk`**
4. Copy file này

---

## 🔍 PHÂN BIỆT FILE ĐÚNG VÀ SAI:

| Tiêu chí | ✅ File ĐÚNG | ❌ File SAI |
|----------|-------------|------------|
| **Vị trí** | `outputs/apk/debug/` | `intermediates/apk/debug/` |
| **Kích thước** | 5-15 MB | Có thể nhỏ hơn |
| **Có thể cài** | ✅ Có | ❌ Không |
| **Khi nào có** | Sau khi build xong | Trong quá trình build |

---

## 📦 CÁC LOẠI APK:

### 1. **Debug APK** (Khuyên dùng để test)
- **Tên**: `app-debug.apk`
- **Vị trí**: `app/build/outputs/apk/debug/app-debug.apk`
- **Đặc điểm**: 
  - ✅ Dễ build, không cần signing
  - ✅ Phù hợp để test
  - ✅ Có thể cài đặt trực tiếp

### 2. **Release APK** (Cho production)
- **Tên**: `app-release.apk`
- **Vị trí**: `app/build/outputs/apk/release/app-release.apk`
- **Đặc điểm**:
  - ✅ Ổn định hơn
  - ✅ Đã được ký (nếu có keystore)
  - ⚠️ Cần tạo keystore trước

---

## 🚀 HƯỚNG DẪN NHANH:

### Bước 1: Build APK
```
Android Studio > Build > Build Bundle(s) / APK(s) > Build APK(s)
```

### Bước 2: Tìm file
```
Nhấn "locate" trong popup
Hoặc vào: D:\ABANK\app\build\outputs\apk\debug\
```

### Bước 3: Copy file
```
Copy file: app-debug.apk
```

### Bước 4: Tải lên điện thoại
```
Qua USB, Email, Google Drive, hoặc Bluetooth
```

---

## ⚠️ LƯU Ý QUAN TRỌNG:

1. **KHÔNG dùng file trong thư mục `intermediates`**
   - Đây là file tạm, không thể cài đặt

2. **Luôn build APK từ menu Android Studio**
   - Đảm bảo APK được build đầy đủ

3. **Kiểm tra kích thước file**
   - APK thường có kích thước: 5-15 MB
   - Nếu quá nhỏ (< 1 MB) → APK bị lỗi

4. **Gỡ app cũ trước khi cài lại**
   - Settings > Apps > Bank Notification Reader > Uninstall

---

## ✅ CHECKLIST:

Trước khi tải APK, đảm bảo:

- [ ] Đã Clean Project
- [ ] Đã Build APK từ menu Android Studio
- [ ] File APK ở đúng vị trí: `outputs/apk/debug/`
- [ ] File APK có kích thước hợp lý (5-15 MB)
- [ ] KHÔNG dùng file trong thư mục `intermediates`

---

## 🎯 TÓM TẮT:

**File cần tải**: `app-debug.apk`  
**Vị trí đúng**: `D:\ABANK\app\build\outputs\apk\debug\app-debug.apk`  
**Cách lấy**: Build trong Android Studio > Nhấn "locate"  
**KHÔNG dùng**: File trong thư mục `intermediates`

---

**Chúc bạn tải và cài đặt thành công! 🎉**



