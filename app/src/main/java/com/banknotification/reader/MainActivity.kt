package com.banknotification.reader

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat

/**
 * MainActivity - Màn hình chính để xin quyền Notification Access
 */
class MainActivity : AppCompatActivity() {

    private lateinit var btnEnablePermission: Button
    private lateinit var tvStatus: TextView
    private lateinit var tvInstructions: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initViews()
        checkPermissionStatus()
    }

    private fun initViews() {
        btnEnablePermission = findViewById(R.id.btnEnablePermission)
        tvStatus = findViewById(R.id.tvStatus)
        tvInstructions = findViewById(R.id.tvInstructions)

        btnEnablePermission.setOnClickListener {
            openNotificationSettings()
        }
    }

    /**
     * Kiểm tra xem đã cấp quyền Notification Access chưa
     */
    private fun checkPermissionStatus() {
        val enabledNotificationListeners = Settings.Secure.getString(
            contentResolver,
            "enabled_notification_listeners"
        )

        val packageName = packageName
        val isEnabled = enabledNotificationListeners != null &&
                enabledNotificationListeners.contains(packageName)

        if (isEnabled) {
            tvStatus.text = "✅ Đã bật quyền truy cập thông báo"
            tvStatus.setTextColor(ContextCompat.getColor(this, android.R.color.holo_green_dark))
            btnEnablePermission.text = "Kiểm tra lại quyền"
            tvInstructions.text = """
                Ứng dụng đã sẵn sàng!
                
                Khi có thông báo từ app ngân hàng (Momo, Vietcombank, MB Bank...), ứng dụng sẽ tự động đọc to số tiền.
                
                Hãy thử nhận một thông báo từ app ngân hàng để kiểm tra.
            """.trimIndent()
        } else {
            tvStatus.text = "❌ Chưa bật quyền truy cập thông báo"
            tvStatus.setTextColor(ContextCompat.getColor(this, android.R.color.holo_red_dark))
            btnEnablePermission.text = "Bật quyền ngay"
            tvInstructions.text = """
                Để sử dụng ứng dụng, bạn cần cấp quyền truy cập thông báo:
                
                1. Nhấn nút "Bật quyền ngay" bên dưới
                2. Tìm và chọn "Bank Notification Reader" trong danh sách
                3. Bật công tắc để cấp quyền
                4. Quay lại ứng dụng
            """.trimIndent()
        }
    }

    /**
     * Mở màn hình cài đặt để bật quyền Notification Access
     */
    private fun openNotificationSettings() {
        try {
            val intent = Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
            startActivity(intent)
            Toast.makeText(
                this,
                "Vui lòng bật quyền cho 'Bank Notification Reader'",
                Toast.LENGTH_LONG
            ).show()
        } catch (e: Exception) {
            Toast.makeText(
                this,
                "Không thể mở cài đặt: ${e.message}",
                Toast.LENGTH_SHORT
            ).show()
        }
    }

    override fun onResume() {
        super.onResume()
        // Kiểm tra lại quyền khi quay lại màn hình
        checkPermissionStatus()
    }
}

