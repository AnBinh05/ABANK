# 🔐 FIX XUNG ĐỘT SIGNING KEY - DEBUG VÀ RELEASE

## ⚠️ VẤN ĐỀ:

**"Để bảo vệ Android khỏi phần mềm độc hại, hệ thống không cho phép cập nhật một ứng dụng có khóa ký (signing-key) khác."**

- App **debug** và **release** ký bằng **2 key khác nhau**
- Android coi đó là **2 ứng dụng không tương thích** để cập nhật
- **Không thể update** từ debug sang release (hoặc ngược lại) mà không gỡ app cũ

---

## ✅ GIẢI PHÁP ĐÃ ÁP DỤNG:

### 1. Cấu hình Debug và Release dùng CÙNG signing key

Đã sửa `app/build.gradle` để:
- **Debug** và **Release** dùng **CÙNG một signing key** (debug keystore mặc định)
- Có thể update từ debug sang release (và ngược lại) mà **KHÔNG cần gỡ app cũ**
- Nếu muốn dùng keystore riêng cho production, tạo file `keystore.properties`

---

## 🚀 CÁCH SỬ DỤNG:

### Cách 1: Dùng Cùng Key (Mặc định - Khuyên dùng)

**Không cần làm gì thêm!** Debug và release đã được cấu hình để dùng cùng key.

1. **Build Debug APK**: `Build > Build Bundle(s) / APK(s) > Build APK(s)`
2. **Cài Debug APK** trên điện thoại
3. **Build Release APK**: `Build > Generate Signed Bundle / APK > APK > release`
4. **Cài Release APK** - Có thể **UPDATE trực tiếp** mà không cần gỡ app cũ! ✅

### Cách 2: Dùng Keystore Riêng cho Production

Nếu muốn dùng keystore riêng cho release (ví dụ: để publish lên Google Play):

#### Bước 1: Tạo keystore

**Dùng Android Studio:**
1. `Build > Generate Signed Bundle / APK`
2. Chọn `APK` > Next
3. Chọn `Create new...`
4. Điền thông tin và tạo keystore

**Hoặc dùng Command Line:**
```cmd
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

**Lưu ý**: 
- Thay `YOUR_PASSWORD_HERE` bằng password bạn đã đặt
- **KHÔNG commit** file này lên Git (thêm vào `.gitignore`)

#### Bước 3: Build APK

- **Debug**: Vẫn dùng debug keystore (cùng key)
- **Release**: Sẽ dùng keystore riêng từ `keystore.properties`

**⚠️ Lưu ý**: Nếu dùng keystore riêng cho release, bạn sẽ **KHÔNG thể update** từ debug sang release mà không gỡ app cũ.

---

## 🔍 KIỂM TRA SIGNING KEY:

### Kiểm tra APK đã được ký:

```cmd
jarsigner -verify -verbose -certs app\build\outputs\apk\debug\app-debug.apk
jarsigner -verify -verbose -certs app\build\outputs\apk\release\app-release.apk
```

### So sánh signing key của 2 APK:

Nếu thấy **cùng certificate** → Có thể update trực tiếp ✅
Nếu thấy **khác certificate** → Phải gỡ app cũ trước khi cài mới ⚠️

---

## 📋 CÁC TÌNH HUỐNG:

### Tình huống 1: Debug và Release dùng CÙNG key (Mặc định)

✅ **Có thể update trực tiếp**:
- Cài Debug APK → Cài Release APK (update trực tiếp, không cần gỡ)
- Cài Release APK → Cài Debug APK (update trực tiếp, không cần gỡ)

### Tình huống 2: Debug và Release dùng KHÁC key

⚠️ **Phải gỡ app cũ trước**:
- Cài Debug APK → **Gỡ app** → Cài Release APK
- Cài Release APK → **Gỡ app** → Cài Debug APK

---

## 🛠️ CÁCH GỠ APP CŨ (Nếu cần):

### Cách 1: Trên điện thoại

1. **Settings > Apps > Bank Notification Reader**
2. **Uninstall**
3. Xác nhận gỡ

### Cách 2: Dùng ADB

```cmd
adb uninstall com.banknotification.reader
```

### Cách 3: Script tự động

Tạo script `uninstall-app.bat`:

```batch
@echo off
echo Gỡ app cũ...
adb uninstall com.banknotification.reader
if %errorlevel% equ 0 (
    echo Đã gỡ app cũ thành công!
) else (
    echo Không tìm thấy app hoặc lỗi khi gỡ.
)
pause
```

---

## ✅ CHECKLIST:

- [ ] Đã cấu hình debug và release dùng cùng key (mặc định)
- [ ] Đã build APK mới sau khi sửa
- [ ] Đã kiểm tra signing key của APK
- [ ] Nếu dùng keystore riêng, đã tạo `keystore.properties`
- [ ] Đã gỡ app cũ (nếu debug và release dùng khác key)

---

## 🎯 TÓM TẮT:

1. **Mặc định**: Debug và Release dùng **CÙNG key** → Có thể update trực tiếp ✅
2. **Nếu dùng keystore riêng**: Phải **gỡ app cũ** trước khi cài mới ⚠️
3. **Khuyên dùng**: Giữ cùng key cho debug và release để dễ test và update

---

**Sau khi sửa, debug và release sẽ dùng CÙNG signing key, có thể update trực tiếp mà không cần gỡ app cũ!** ✅

