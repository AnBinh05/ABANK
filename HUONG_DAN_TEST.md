# Hướng dẫn Test App Bank Notification Reader

## 📱 Cài đặt và Chạy App

### Bước 1: Build và Cài đặt
1. Mở project trong Android Studio
2. Kết nối điện thoại Android (API 26+) qua USB
3. Bật USB Debugging trên điện thoại
4. Chạy app: `Run > Run 'app'` hoặc nhấn `Shift + F10`

### Bước 2: Cấp quyền Notification Access
1. Khi mở app lần đầu, bạn sẽ thấy nút "Bật quyền ngay"
2. Nhấn nút này để mở màn hình cài đặt hệ thống
3. Tìm và chọn **"Bank Notification Reader"** trong danh sách
4. **Bật công tắc** để cấp quyền
5. Quay lại app, bạn sẽ thấy trạng thái "✅ Đã bật quyền"

## 🧪 Cách Test

### Test 1: Test với App Ngân Hàng Thật
1. Mở app ngân hàng (Momo, Vietcombank, MB Bank, v.v.)
2. Thực hiện giao dịch nhận tiền (hoặc nhờ người khác chuyển tiền cho bạn)
3. Khi có thông báo, app sẽ tự động đọc to: **"Bạn vừa nhận [số tiền bằng chữ] đồng"**

### Test 2: Test với Notification Giả (Developer Mode)
Bạn có thể tạo một app test đơn giản để gửi notification giả:

```kotlin
// Code mẫu để test (tạo trong app khác)
val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
val channel = NotificationChannel("test", "Test", NotificationManager.IMPORTANCE_HIGH)
notificationManager.createNotificationChannel(channel)

val notification = NotificationCompat.Builder(this, "test")
    .setContentTitle("Bạn vừa nhận 100.000 VNĐ")
    .setContentText("Chuyển khoản từ số tài khoản 1234567890")
    .setSmallIcon(android.R.drawable.ic_dialog_info)
    .build()

notificationManager.notify(1, notification)
```

### Test 3: Kiểm tra Log
1. Mở **Logcat** trong Android Studio
2. Filter theo tag: `BankNotificationService` hoặc `NotificationParser`
3. Xem log để debug nếu có vấn đề

## 🔍 Các Trường Hợp Test

### ✅ Test Cases Cần Kiểm Tra:

1. **Notification từ app ngân hàng có package name trong danh sách**
   - Momo: `com.mservice.momotransfer`
   - Vietcombank: `com.vietcombank.vcb`
   - MB Bank: `com.mbmobile`

2. **Notification chứa từ khóa:**
   - "nhận", "vừa nhận", "đã nhận"
   - "VNĐ", "VND", "đồng"
   - "credit", "chuyển khoản"

3. **Các định dạng số tiền:**
   - `100.000 VNĐ` → "một trăm nghìn đồng"
   - `50,000 đồng` → "năm mươi nghìn đồng"
   - `1000000` → "một triệu đồng"
   - `1,000,000 VND` → "một triệu đồng"

4. **Tránh đọc trùng:**
   - Gửi cùng một notification 2 lần → chỉ đọc 1 lần

## ⚠️ Lưu Ý Quan Trọng

1. **Quyền Notification Access:**
   - Phải bật quyền này thì app mới hoạt động
   - Nếu tắt quyền, app sẽ không nhận được notification

2. **Text-to-Speech:**
   - Lần đầu sử dụng, Android có thể tải dữ liệu TTS tiếng Việt
   - Đảm bảo điện thoại có kết nối internet lần đầu
   - Nếu không hỗ trợ tiếng Việt, app sẽ fallback về tiếng Anh

3. **Battery Optimization:**
   - Một số điện thoại có thể kill app khi tắt màn hình
   - Vào Settings > Battery > App > Bank Notification Reader
   - Tắt "Battery Optimization" để app chạy nền tốt hơn

4. **Test trên máy thật:**
   - NotificationListenerService **KHÔNG hoạt động** trên emulator
   - **BẮT BUỘC** phải test trên máy thật

## 🐛 Troubleshooting

### App không đọc notification?
1. Kiểm tra quyền Notification Access đã bật chưa
2. Kiểm tra Logcat xem có log từ `BankNotificationService` không
3. Đảm bảo notification có chứa số tiền >= 1000

### TTS không đọc tiếng Việt?
1. Vào Settings > Language & Input > Text-to-Speech
2. Cài đặt engine TTS hỗ trợ tiếng Việt (Google TTS)
3. Download Vietnamese language pack

### App bị kill khi tắt màn hình?
1. Tắt Battery Optimization cho app
2. Thêm app vào whitelist của các app quản lý battery (nếu có)

## 📝 Log Tags để Debug

- `BankNotificationService`: Log từ NotificationListenerService
- `NotificationParser`: Log từ việc parse số tiền
- `TextToSpeechHelper`: Log từ TTS engine

