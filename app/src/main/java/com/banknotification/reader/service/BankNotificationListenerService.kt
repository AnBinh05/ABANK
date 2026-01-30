package com.banknotification.reader.service

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log
import com.banknotification.reader.helper.TextToSpeechHelper
import com.banknotification.reader.helper.NotificationParser

/**
 * Service lắng nghe tất cả thông báo từ hệ thống
 * Lọc và xử lý thông báo từ các app ngân hàng
 */
class BankNotificationListenerService : NotificationListenerService() {

    private var ttsHelper: TextToSpeechHelper? = null
    
    // Danh sách package name của các app ngân hàng phổ biến
    private val bankPackages = setOf(
        "com.mbmobile",                    // MB Bank
        "com.vietcombank.vcb",             // Vietcombank
        "com.techcombank.tcb",             // Techcombank
        "com.mservice.momotransfer",       // Momo
        "com.vnpay.wallet",                // VNPay
        "com.vietinbank.mobile",           // VietinBank
        "com.bidv.smartbanking",           // BIDV
        "com.acb.mobilebanking",           // ACB
        "com.tpbank.mobilebanking",        // TPBank
        "com.vpbank.mobilebanking"         // VPBank
    )
    
    // Từ khóa để nhận diện thông báo nhận tiền
    private val moneyKeywords = setOf(
        "nhận", "vừa nhận", "đã nhận", "nhận được",
        "credit", "VNĐ", "VND", "đồng",
        "chuyển khoản", "chuyển tiền", "tiền vào"
    )

    // Set để lưu các notification đã xử lý (tránh đọc trùng)
    private val processedNotifications = mutableSetOf<String>()

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "BankNotificationListenerService được tạo")
        ttsHelper = TextToSpeechHelper(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "BankNotificationListenerService bị hủy")
        ttsHelper?.shutdown()
        ttsHelper = null
    }

    /**
     * Callback khi có thông báo mới được đăng
     */
    override fun onNotificationPosted(sbn: StatusBarNotification) {
        super.onNotificationPosted(sbn)
        
        val packageName = sbn.packageName
        val notification = sbn.notification
        
        Log.d(TAG, "Nhận thông báo từ: $packageName")
        
        // Tạo key duy nhất cho notification (package + title + text + time)
        val notificationKey = "${packageName}_${notification.extras?.getCharSequence("android.title")}_${notification.extras?.getCharSequence("android.text")}_${sbn.postTime}"
        
        // Kiểm tra xem đã xử lý notification này chưa
        if (processedNotifications.contains(notificationKey)) {
            Log.d(TAG, "Notification đã được xử lý, bỏ qua")
            return
        }
        
        // Lấy nội dung thông báo
        val title = notification.extras?.getCharSequence("android.title")?.toString() ?: ""
        val text = notification.extras?.getCharSequence("android.text")?.toString() ?: ""
        val bigText = notification.extras?.getCharSequence("android.bigText")?.toString() ?: ""
        
        val fullText = "$title $text $bigText".lowercase()
        
        Log.d(TAG, "Title: $title")
        Log.d(TAG, "Text: $text")
        Log.d(TAG, "Full text: $fullText")
        
        // Kiểm tra xem có phải thông báo từ app ngân hàng không
        val isBankApp = bankPackages.contains(packageName)
        
        // Kiểm tra xem có chứa từ khóa liên quan đến tiền không
        val containsKeyword = moneyKeywords.any { keyword ->
            fullText.contains(keyword.lowercase())
        }
        
        if (isBankApp || containsKeyword) {
            Log.d(TAG, "Phát hiện thông báo từ app ngân hàng hoặc chứa từ khóa tiền")
            
            // Parse số tiền từ nội dung
            val amount = NotificationParser.extractAmount(fullText)
            
            if (amount > 0) {
                Log.d(TAG, "Tìm thấy số tiền: $amount")
                
                // Đánh dấu đã xử lý
                processedNotifications.add(notificationKey)
                
                // Giới hạn size của set để tránh memory leak (giữ tối đa 100 notification)
                if (processedNotifications.size > 100) {
                    processedNotifications.clear()
                }
                
                // Đọc số tiền
                ttsHelper?.speakAmount(amount)
            } else {
                Log.d(TAG, "Không tìm thấy số tiền trong thông báo")
            }
        } else {
            Log.d(TAG, "Không phải thông báo ngân hàng, bỏ qua")
        }
    }

    /**
     * Callback khi thông báo bị xóa
     */
    override fun onNotificationRemoved(sbn: StatusBarNotification) {
        super.onNotificationRemoved(sbn)
        // Không cần xử lý gì ở đây
    }

    companion object {
        private const val TAG = "BankNotificationService"
    }
}

