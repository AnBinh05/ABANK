# 🔐 FIX LỖI "THIẾU CHỮ KÝ" - APK KHÔNG CÀI ĐƯỢC

## ✅ ĐÃ SỬA:

1. ✅ **Cấu hình signing trong build.gradle** - Đã thêm signing config đầy đủ
2. ✅ **Debug signing** - Tự động sử dụng debug keystore
3. ✅ **Release signing** - Có thể dùng keystore riêng hoặc debug keystore tạm thời

---

## 🚨 VẤN ĐỀ:

APK thiếu chữ ký (signing) nên không thể cài được trên thiết bị thật.

---

## ✅ GIẢI PHÁP:

### Cách 1: Build APK Debug (Đơn giản nhất)

Debug APK sẽ **TỰ ĐỘNG** được ký bằng debug keystore khi build.

**Các bước:**

1. **Mở Android Studio**
2. **Sync Gradle**: `File > Sync Project with Gradle Files` (đợi xong)
3. **Clean Project**: `Build > Clean Project` (đợi xong)
4. **Rebuild Project**: `Build > Rebuild Project` (đợi xong - 1-2 phút)
5. **Build APK**: `Build > Build Bundle(s) / APK(s) > Build APK(s)` (đợi xong)
6. **APK sẽ được ký tự động** và có thể cài trên thiết bị thật

**File APK**: `app\build\outputs\apk\debug\app-debug.apk`

### Cách 2: Tạo Release Keystore (Cho production)

Nếu muốn build APK release với keystore riêng:

#### Bước 1: Tạo keystore

**Dùng Android Studio:**
1. `Build > Generate Signed Bundle / APK`
2. Chọn `APK` > Next
3. Chọn `Create new...`
4. Điền thông tin:
   - **Key store path**: `D:\ABANK\bank-notification-reader.jks`
   - **Password**: Đặt mật khẩu (nhớ lưu lại!)
   - **Key alias**: `bank-notification-reader-key`
   - **Key password**: Có thể giống store password
   - **Validity**: 25 years
   - **Country Code**: VN
5. Nhấn `OK` > `Finish`

**Hoặc dùng Command Line:**
```cmd
cd D:\ABANK
keytool -genkey -v -keystore bank-notification-reader.jks -keyalg RSA -keysize 2048 -validity 10000 -alias bank-notification-reader-key
```

#### Bước 2: Tạo file keystore.properties

Tạo file `keystore.properties` ở thư mục gốc project (`D:\ABANK\keystore.properties`):

```properties
storeFile=bank-notification-reader.jks
storePassword=YOUR_PASSWORD_HERE
keyAlias=bank-notification-reader-key
keyPassword=YOUR_PASSWORD_HERE
```

**Lưu ý**: Thay `YOUR_PASSWORD_HERE` bằng password bạn đã đặt khi tạo keystore.

#### Bước 3: Build APK Release

```cmd
cd D:\ABANK
gradlew.bat assembleRelease
```

**File APK**: `app\build\outputs\apk\release\app-release.apk`

---

## 🔍 KIỂM TRA APK ĐÃ ĐƯỢC KÝ:

### Kiểm tra bằng jarsigner:

```cmd
jarsigner -verify -verbose -certs app\build\outputs\apk\debug\app-debug.apk
```

Nếu thấy **"jar verified"** → APK đã được ký đúng ✅

### Kiểm tra bằng apksigner (nếu có Android SDK):

```cmd
apksigner verify app\build\outputs\apk\debug\app-debug.apk
```

---

## ⚠️ LƯU Ý QUAN TRỌNG:

1. **Debug keystore tự động**: Android Studio tự động tạo debug keystore khi build lần đầu
2. **Debug APK có thể cài được**: Debug APK được ký bằng debug keystore, vẫn có thể cài trên thiết bị thật
3. **Release keystore**: Chỉ cần nếu muốn publish lên Google Play
4. **Giữ keystore cẩn thận**: Nếu mất keystore, không thể update app sau này

---

## 🚀 SAU KHI SỬA:

1. **Clean project**: `Build > Clean Project`
2. **Rebuild project**: `Build > Rebuild Project`
3. **Build APK**: `Build > Build Bundle(s) / APK(s) > Build APK(s)`
4. **APK mới sẽ được ký đúng** và có thể cài trên thiết bị thật ✅

---

## 📋 CHECKLIST:

- [ ] Đã mở Android Studio
- [ ] Đã Sync Gradle Files
- [ ] Đã Clean Project
- [ ] Đã Rebuild Project
- [ ] Đã Build APK mới
- [ ] APK đã được ký (kiểm tra bằng jarsigner)
- [ ] File APK ở: `app\build\outputs\apk\debug\app-debug.apk`
- [ ] Đã gỡ app cũ (nếu có)
- [ ] Đã thử cài APK mới trên điện thoại

---

**Sau khi rebuild APK, lỗi "thiếu chữ ký" sẽ được khắc phục! APK sẽ được ký tự động khi build.**

