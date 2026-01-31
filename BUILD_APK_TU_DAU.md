# 🔨 Hướng dẫn Build APK từ đầu (Khi chưa có file APK)

## ❌ Vấn đề:
Trong thư mục `D:\ABANK\app\build\outputs` chỉ có thư mục `logs`, **KHÔNG có** thư mục `apk`.

➡️ **Điều này có nghĩa là APK chưa được build!**

---

## ✅ Giải pháp: Build APK trong Android Studio

### Bước 1: Mở project trong Android Studio

1. **Mở Android Studio**
2. **File > Open**
3. Chọn thư mục: `D:\ABANK`
4. Đợi Gradle sync hoàn tất (có thể mất 1-2 phút lần đầu)

### Bước 2: Đảm bảo project đã sync thành công

- Kiểm tra ở góc dưới bên phải Android Studio
- Phải thấy: **"Gradle sync finished"** hoặc **"Gradle build finished"**
- Nếu có lỗi, sửa lỗi trước khi build

### Bước 3: Clean Project (Quan trọng!)

1. Chọn menu: **`Build > Clean Project`**
2. Đợi quá trình clean hoàn tất (30 giây - 1 phút)
3. Sẽ thấy thông báo: **"BUILD SUCCESSFUL"** ở tab Build

### Bước 4: Build APK

1. Chọn menu: **`Build > Build Bundle(s) / APK(s) > Build APK(s)`**
2. Đợi quá trình build (1-3 phút)
3. Sẽ thấy thông báo ở góc dưới bên phải: **"APK(s) generated successfully"**
4. Nhấn **`locate`** trong popup

### Bước 5: Kiểm tra file APK

Sau khi build xong, bạn sẽ thấy:

```
D:\ABANK\app\build\outputs\apk\debug\app-debug.apk
```

Thư mục `apk` sẽ xuất hiện trong `outputs`!

---

## 🔍 Cách kiểm tra Build có thành công không:

### Trong Android Studio:

1. **Xem tab "Build"** ở dưới cùng
2. Phải thấy: **"BUILD SUCCESSFUL"**
3. Nếu thấy **"BUILD FAILED"** → Xem lỗi và sửa

### Kiểm tra file:

1. Mở File Explorer
2. Vào: `D:\ABANK\app\build\outputs\`
3. Bây giờ sẽ thấy thư mục **`apk`**
4. Vào trong `apk\debug\` → Sẽ thấy file **`app-debug.apk`**

---

## 🐛 Nếu Build bị lỗi:

### Lỗi thường gặp:

1. **"Gradle sync failed"**
   - **Giải pháp**: 
     - File > Invalidate Caches / Restart
     - Chọn "Invalidate and Restart"
     - Đợi Android Studio khởi động lại

2. **"Build failed"**
   - **Giải pháp**:
     - Xem tab "Build" để biết lỗi cụ thể
     - Thường là lỗi compile hoặc dependency
     - Sửa lỗi và build lại

3. **"SDK not found"**
   - **Giải pháp**:
     - File > Project Structure > SDK Location
     - Kiểm tra Android SDK đã cài đặt chưa

---

## 🚀 Cách nhanh nhất (Nếu đã mở Android Studio):

1. **Clean**: `Build > Clean Project` (Ctrl+Shift+F9)
2. **Build APK**: `Build > Build Bundle(s) / APK(s) > Build APK(s)` (Shift+F10)
3. **Đợi build xong**
4. **Nhấn "locate"** trong popup

---

## 📋 Checklist:

Trước khi build, đảm bảo:

- [ ] Android Studio đã mở project `ABANK`
- [ ] Gradle sync đã hoàn tất (không có lỗi)
- [ ] Đã Clean Project
- [ ] Không có lỗi compile trong code
- [ ] Android SDK đã được cài đặt

---

## ✅ Sau khi build thành công:

1. **File APK sẽ ở**: `D:\ABANK\app\build\outputs\apk\debug\app-debug.apk`
2. **Kích thước**: Khoảng 5-15 MB
3. **Có thể cài đặt**: ✅ Có

---

## 🎯 Tóm tắt các bước:

```
1. Mở Android Studio
2. File > Open > Chọn D:\ABANK
3. Đợi Gradle sync
4. Build > Clean Project
5. Build > Build Bundle(s) / APK(s) > Build APK(s)
6. Đợi build xong
7. Nhấn "locate"
8. Copy file app-debug.apk
```

---

**Làm theo các bước trên, bạn sẽ có file APK! 🎉**



