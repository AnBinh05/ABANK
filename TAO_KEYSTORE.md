# 🔐 HƯỚNG DẪN TẠO KEYSTORE ĐỂ KÝ APK

## ⚠️ VẤN ĐỀ:

APK thiếu chữ ký (signing) nên không thể cài được trên thiết bị thật.

## ✅ GIẢI PHÁP:

### Cách 1: Dùng Debug Keystore (Đơn giản nhất - Cho test)

Debug APK sẽ tự động được ký bằng debug keystore. Android Studio tự động tạo debug keystore.

**Chỉ cần build APK debug:**
1. Mở Android Studio
2. `Build > Build Bundle(s) / APK(s) > Build APK(s)`
3. APK sẽ được ký tự động

### Cách 2: Tạo Release Keystore (Khuyên dùng cho production)

#### Bước 1: Tạo keystore bằng Android Studio

1. Mở Android Studio
2. `Build > Generate Signed Bundle / APK`
3. Chọn `APK` > Next
4. Chọn `Create new...` để tạo keystore mới
5. Điền thông tin:
   - **Key store path**: `D:\ABANK\bank-notification-reader.jks`
   - **Password**: Đặt mật khẩu (ví dụ: `android123`)
   - **Key alias**: `bank-notification-reader-key`
   - **Key password**: Có thể giống store password
   - **Validity**: 25 years (mặc định)
   - **First and Last Name**: Tên của bạn
   - **Organizational Unit**: (tùy chọn)
   - **Organization**: (tùy chọn)
   - **City**: (tùy chọn)
   - **State**: (tùy chọn)
   - **Country Code**: VN
6. Nhấn `OK` > `Next`
7. Chọn build variant: `release`
8. Nhấn `Finish`

#### Bước 2: Tạo file keystore.properties (Tự động load)

Sau khi tạo keystore, tạo file `keystore.properties` ở thư mục gốc project:

```properties
storeFile=bank-notification-reader.jks
storePassword=android123
keyAlias=bank-notification-reader-key
keyPassword=android123
```

**Lưu ý**: Thay `android123` bằng password bạn đã đặt khi tạo keystore.

#### Bước 3: Build APK Release

```cmd
cd D:\ABANK
gradlew.bat assembleRelease
```

File APK sẽ ở: `app\build\outputs\apk\release\app-release.apk`

### Cách 3: Tạo keystore bằng Command Line

```cmd
cd D:\ABANK
keytool -genkey -v -keystore bank-notification-reader.jks -keyalg RSA -keysize 2048 -validity 10000 -alias bank-notification-reader-key
```

Sau đó tạo file `keystore.properties` như trên.

---

## 🔍 KIỂM TRA APK ĐÃ ĐƯỢC KÝ:

### Dùng jarsigner:

```cmd
jarsigner -verify -verbose -certs app\build\outputs\apk\debug\app-debug.apk
```

Nếu thấy "jar verified" → APK đã được ký đúng.

### Dùng apksigner (Android SDK):

```cmd
apksigner verify app\build\outputs\apk\debug\app-debug.apk
```

---

## ⚠️ LƯU Ý QUAN TRỌNG:

1. **Giữ keystore cẩn thận**: Nếu mất keystore, bạn sẽ không thể update app sau này
2. **Backup keystore**: Copy keystore và password ra nhiều nơi an toàn
3. **Không commit keystore lên Git**: Thêm vào `.gitignore`

---

## 🚀 SAU KHI TẠO KEYSTORE:

1. **Clean project**: `Build > Clean Project`
2. **Rebuild project**: `Build > Rebuild Project`
3. **Build APK**: `Build > Build Bundle(s) / APK(s) > Build APK(s)`
4. **APK mới sẽ được ký đúng** và có thể cài trên thiết bị thật

---

**Sau khi tạo keystore và rebuild APK, lỗi "thiếu chữ ký" sẽ được khắc phục!**

