# 🏦 Bank Notification Reader

Ứng dụng Android tự động đọc to số tiền khi nhận thông báo từ các app ngân hàng.

## 📱 Giới thiệu

**Bank Notification Reader** là ứng dụng Android giúp bạn theo dõi các giao dịch nhận tiền một cách tiện lợi. Khi có thông báo từ các app ngân hàng (Momo, Vietcombank, MB Bank, Techcombank...), ứng dụng sẽ tự động đọc to số tiền bằng tiếng Việt qua loa điện thoại.

### ✨ Tính năng chính

- 🔔 **Lắng nghe thông báo tự động**: Theo dõi tất cả thông báo từ các app ngân hàng phổ biến
- 💰 **Nhận diện số tiền thông minh**: Tự động parse số tiền từ nội dung thông báo (hỗ trợ nhiều định dạng: 100.000, 50,000, 1000000...)
- 🔊 **Đọc to bằng tiếng Việt**: Chuyển số tiền sang chữ và đọc bằng Text-to-Speech tiếng Việt
- 🎯 **Lọc thông minh**: Chỉ xử lý thông báo liên quan đến việc nhận tiền
- 🚫 **Tránh đọc trùng**: Không đọc lại thông báo đã xử lý

## 🛠️ Công nghệ sử dụng

- **Ngôn ngữ**: Kotlin 100%
- **Min SDK**: Android 8.0 (API 26)
- **Target SDK**: Android 14 (API 34)
- **Kiến trúc**: 
  - NotificationListenerService để lắng nghe thông báo
  - TextToSpeech để đọc tiếng Việt
  - Regex để parse số tiền

## 📋 Yêu cầu hệ thống

- Android 8.0 (API 26) trở lên
- Quyền truy cập thông báo (Notification Access)
- Text-to-Speech engine hỗ trợ tiếng Việt (Google TTS)

## 🚀 Cài đặt

### Cách 1: Build từ source code

1. **Clone repository**:
   ```bash
   git clone <repository-url>
   cd ABANK
   ```

2. **Mở project trong Android Studio**:
   - Mở Android Studio
   - Chọn `File > Open` và chọn thư mục `ABANK`
   - Đợi Gradle sync hoàn tất

3. **Build và cài đặt**:
   - Kết nối điện thoại Android qua USB
   - Bật USB Debugging
   - Chạy app: `Run > Run 'app'` hoặc nhấn `Shift + F10`

### Cách 2: Cài đặt APK

1. Tải file APK từ [releases](../../releases)
2. Cài đặt APK trên điện thoại Android
3. Cho phép cài đặt từ nguồn không xác định (nếu cần)

## ⚙️ Cấu hình

### Bước 1: Cấp quyền Notification Access

1. Mở ứng dụng **Bank Notification Reader**
2. Nhấn nút **"Bật quyền ngay"**
3. Trong màn hình cài đặt hệ thống:
   - Tìm và chọn **"Bank Notification Reader"**
   - **Bật công tắc** để cấp quyền
4. Quay lại ứng dụng, bạn sẽ thấy trạng thái **"✅ Đã bật quyền"**

### Bước 2: Cài đặt Text-to-Speech tiếng Việt (nếu cần)

1. Vào **Settings > Language & Input > Text-to-Speech**
2. Chọn **Google Text-to-Speech** (hoặc engine TTS khác)
3. Download **Vietnamese language pack** nếu chưa có

### Bước 3: Tối ưu pin (tùy chọn)

Để app chạy nền tốt hơn:

1. Vào **Settings > Battery > App > Bank Notification Reader**
2. Tắt **"Battery Optimization"**
3. Thêm app vào whitelist của các app quản lý pin (nếu có)

## 📖 Cách sử dụng

1. **Cấp quyền** như hướng dẫn ở trên
2. **Sử dụng bình thường**: App sẽ tự động chạy nền
3. **Nhận thông báo**: Khi có thông báo từ app ngân hàng về việc nhận tiền, app sẽ tự động đọc to:
   - Ví dụ: "Bạn vừa nhận một trăm nghìn đồng"

## 🏦 Hỗ trợ các app ngân hàng

App tự động nhận diện thông báo từ các app sau:

- ✅ **Momo** (`com.mservice.momotransfer`)
- ✅ **Vietcombank** (`com.vietcombank.vcb`)
- ✅ **MB Bank** (`com.mbmobile`)
- ✅ **Techcombank** (`com.techcombank.tcb`)
- ✅ **VNPay** (`com.vnpay.wallet`)
- ✅ **VietinBank** (`com.vietinbank.mobile`)
- ✅ **BIDV** (`com.bidv.smartbanking`)
- ✅ **ACB** (`com.acb.mobilebanking`)
- ✅ **TPBank** (`com.tpbank.mobilebanking`)
- ✅ **VPBank** (`com.vpbank.mobilebanking`)

> **Lưu ý**: App cũng sẽ xử lý thông báo từ bất kỳ app nào có chứa từ khóa: "nhận", "vừa nhận", "credit", "VNĐ", "VND", "đồng"

## 🔍 Định dạng số tiền được hỗ trợ

App có thể nhận diện các định dạng số tiền sau:

- `100.000 VNĐ` → "một trăm nghìn đồng"
- `50,000 đồng` → "năm mươi nghìn đồng"
- `1000000` → "một triệu đồng"
- `1,000,000 VND` → "một triệu đồng"
- `500.000` → "năm trăm nghìn đồng"

## 🧪 Testing

Xem file [HUONG_DAN_TEST.md](HUONG_DAN_TEST.md) để biết cách test chi tiết.

### Test nhanh:

1. Cấp quyền Notification Access
2. Mở app ngân hàng và thực hiện giao dịch nhận tiền
3. Hoặc nhờ người khác chuyển tiền cho bạn
4. Lắng nghe app đọc to số tiền

## 📁 Cấu trúc dự án

```
ABANK/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── java/com/banknotification/reader/
│   │       │   ├── MainActivity.kt              # Màn hình chính
│   │       │   ├── helper/
│   │       │   │   ├── NotificationParser.kt    # Parse số tiền
│   │       │   │   └── TextToSpeechHelper.kt    # TTS và chuyển số sang chữ
│   │       │   └── service/
│   │       │       └── BankNotificationListenerService.kt  # Lắng nghe thông báo
│   │       ├── res/                              # Resources
│   │       └── AndroidManifest.xml
│   └── build.gradle
├── build.gradle
├── settings.gradle
└── README.md
```

## 🔧 Phát triển

### Yêu cầu

- Android Studio Hedgehog | 2023.1.1 trở lên
- JDK 21
- Gradle 8.5+

### Build

```bash
./gradlew build
```

### Chạy tests

```bash
./gradlew test
```

## ⚠️ Lưu ý quan trọng

1. **Phải test trên máy thật**: NotificationListenerService không hoạt động trên emulator
2. **Quyền Notification Access**: Bắt buộc phải bật quyền này thì app mới hoạt động
3. **Battery Optimization**: Tắt để app chạy nền tốt hơn
4. **Text-to-Speech**: Lần đầu sử dụng có thể cần tải dữ liệu tiếng Việt

## 🐛 Troubleshooting

### App không đọc notification?

- ✅ Kiểm tra quyền Notification Access đã bật chưa
- ✅ Kiểm tra Logcat (tag: `BankNotificationService`)
- ✅ Đảm bảo notification có chứa số tiền >= 1000

### TTS không đọc tiếng Việt?

- ✅ Vào Settings > Text-to-Speech
- ✅ Cài đặt Google TTS
- ✅ Download Vietnamese language pack

### App bị kill khi tắt màn hình?

- ✅ Tắt Battery Optimization cho app
- ✅ Thêm app vào whitelist của các app quản lý pin

## 📝 License

Dự án này được phát hành dưới giấy phép MIT. Xem file [LICENSE](LICENSE) để biết thêm chi tiết.

## 👨‍💻 Tác giả

Được phát triển bởi Senior Android Developer (Kotlin)

## 🤝 Đóng góp

Mọi đóng góp đều được chào đón! Vui lòng:

1. Fork project
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Mở Pull Request

## 📞 Liên hệ

Nếu có vấn đề hoặc câu hỏi, vui lòng tạo [Issue](../../issues) trên GitHub.

---

⭐ **Nếu project này hữu ích, hãy cho một star!** ⭐





