# 📦 Hướng dẫn Build APK Release (Ổn định hơn Debug)

APK Release thường **ổn định và ít lỗi hơn** APK Debug khi cài đặt. Đây là cách build:

---

## ✅ Cách 1: Build qua Android Studio (Khuyên dùng)

### Bước 1: Tạo Keystore (chỉ cần làm 1 lần)

1. Trong Android Studio, chọn **Build > Generate Signed Bundle / APK**
2. Chọn **APK** > Nhấn **Next**
3. Nhấn **Create new...** để tạo keystore mới
4. Điền thông tin:
   - **Key store path**: `D:\ABANK\bank-notification-reader.jks`
   - **Password**: Đặt mật khẩu (nhớ lưu lại!)
   - **Key alias**: `bank-notification-reader-key`
   - **Key password**: Có thể giống store password
   - **Validity**: 25 years
   - **First and Last Name**: Tên của bạn
   - **Organizational Unit**: (có thể để trống)
   - **Organization**: (có thể để trống)
   - **City**: (có thể để trống)
   - **State**: (có thể để trống)
   - **Country Code**: VN
5. Nhấn **OK**

### Bước 2: Build APK Release

1. Chọn keystore vừa tạo
2. Nhập password
3. Chọn **release** build variant
4. Nhấn **Next**
5. Chọn **release** flavor
6. Nhấn **Finish**
7. Đợi build hoàn tất (1-2 phút)

### Bước 3: Tìm file APK Release

- File sẽ ở: `app/build/outputs/apk/release/app-release.apk`
- File này đã được ký và sẵn sàng cài đặt

---

## ✅ Cách 2: Build qua Command Line

### Bước 1: Tạo Keystore bằng keytool

```bash
keytool -genkey -v -keystore bank-notification-reader.jks -keyalg RSA -keysize 2048 -validity 10000 -alias bank-notification-reader-key
```

Khi được hỏi, nhập:
- **Password**: Đặt mật khẩu (nhớ lưu lại!)
- **First and Last Name**: Tên của bạn
- **Organizational Unit**: (có thể để trống, nhấn Enter)
- **Organization**: (có thể để trống, nhấn Enter)
- **City**: (có thể để trống, nhấn Enter)
- **State**: (có thể để trống, nhấn Enter)
- **Country Code**: VN
- Xác nhận thông tin: **yes**

### Bước 2: Cấu hình signing trong build.gradle

Thêm vào file `app/build.gradle` (sau dòng `android {`):

```gradle
android {
    ...
    
    signingConfigs {
        release {
            storeFile file('../bank-notification-reader.jks')
            storePassword 'your_password_here'  // Thay bằng password của bạn
            keyAlias 'bank-notification-reader-key'
            keyPassword 'your_password_here'     // Thay bằng password của bạn
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled false
        }
    }
}
```

### Bước 3: Build APK Release

```bash
# Windows
gradlew.bat assembleRelease

# Linux/Mac
./gradlew assembleRelease
```

### Bước 4: Tìm file APK

- File sẽ ở: `app/build/outputs/apk/release/app-release.apk`

---

## ✅ Cách 3: Build Release không cần keystore (Tự động ký)

Nếu bạn chỉ muốn test nhanh, có thể dùng debug keystore:

### Cấu hình trong build.gradle:

```gradle
android {
    ...
    
    buildTypes {
        release {
            minifyEnabled false
            // Dùng debug keystore để test (không khuyên dùng cho production)
            signingConfig signingConfigs.debug
        }
    }
}
```

Sau đó build: `gradlew assembleRelease`

---

## 🔒 Bảo mật Keystore

⚠️ **QUAN TRỌNG**: Giữ keystore và password cẩn thận!

1. **Backup keystore** ở nhiều nơi:
   - USB drive
   - Cloud storage (Google Drive, Dropbox...)
   - Email cho chính mình

2. **Lưu password** ở nơi an toàn:
   - Password manager
   - File text được mã hóa

3. **KHÔNG commit keystore lên Git**:
   - Thêm vào `.gitignore`: `*.jks`
   - Thêm vào `.gitignore`: `bank-notification-reader.jks`

4. **Nếu mất keystore**:
   - ❌ Không thể update app trên Google Play
   - ❌ Phải tạo app mới với package name khác
   - ✅ Vẫn có thể cài đặt APK thủ công

---

## 📋 So sánh APK Debug vs Release

| Tính năng | Debug APK | Release APK |
|----------|-----------|-------------|
| **Ký** | Tự động (debug keystore) | Phải ký thủ công |
| **Ổn định** | ⚠️ Có thể lỗi khi cài | ✅ Ổn định hơn |
| **Kích thước** | Lớn hơn (có debug info) | Nhỏ hơn |
| **Tốc độ** | Chậm hơn | Nhanh hơn |
| **Dùng cho** | Test, development | Production, publish |
| **Cài đặt** | Dễ lỗi trên một số thiết bị | Ít lỗi hơn |

---

## ✅ Checklist Build APK Release

- [ ] Đã tạo keystore
- [ ] Đã lưu password keystore
- [ ] Đã backup keystore
- [ ] Đã cấu hình signing trong build.gradle
- [ ] Đã build APK Release thành công
- [ ] File APK ở: `app/build/outputs/apk/release/app-release.apk`
- [ ] Đã test cài đặt APK Release

---

## 🐛 Troubleshooting

### Lỗi: "Keystore file not found"
- Đảm bảo đường dẫn keystore đúng
- Đường dẫn tương đối: `file('../bank-notification-reader.jks')`
- Đường dẫn tuyệt đối: `file('D:/ABANK/bank-notification-reader.jks')`

### Lỗi: "Password incorrect"
- Kiểm tra lại password
- Đảm bảo không có khoảng trắng thừa

### Lỗi: "Key alias not found"
- Kiểm tra alias name: `bank-notification-reader-key`
- Xem alias trong keystore: `keytool -list -v -keystore bank-notification-reader.jks`

### APK Release vẫn không cài được
1. Gỡ app cũ hoàn toàn
2. Kiểm tra log lỗi bằng ADB: `adb install -r -d app-release.apk`
3. Xem file `KIEM_TRA_APK.md` để biết thêm

---

## 📞 Nếu vẫn không được

1. **Kiểm tra log lỗi chi tiết**:
   ```bash
   adb install -r -d app/build/outputs/apk/release/app-release.apk
   ```

2. **Thử cài trên thiết bị khác**

3. **Kiểm tra AndroidManifest.xml** có đúng không

4. **Xem file `KIEM_TRA_APK.md`** để biết thêm chi tiết

---

**Chúc bạn build APK Release thành công! 🎉**

