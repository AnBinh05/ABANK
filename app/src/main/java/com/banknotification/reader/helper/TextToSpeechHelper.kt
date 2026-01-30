package com.banknotification.reader.helper

import android.content.Context
import android.speech.tts.TextToSpeech
import android.util.Log
import java.util.*

/**
 * Helper class để xử lý Text-to-Speech
 * Chuyển đổi số tiền sang chữ và đọc bằng tiếng Việt
 */
class TextToSpeechHelper(private val context: Context) : TextToSpeech.OnInitListener {

    private var tts: TextToSpeech? = null
    private var isInitialized = false

    init {
        // Khởi tạo TTS với locale tiếng Việt
        tts = TextToSpeech(context, this)
    }

    /**
     * Callback khi TTS được khởi tạo
     */
    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            val result = tts?.setLanguage(Locale("vi", "VN"))
            if (result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                Log.e(TAG, "Tiếng Việt không được hỗ trợ")
                // Fallback về tiếng Anh nếu không hỗ trợ tiếng Việt
                tts?.setLanguage(Locale.US)
            } else {
                isInitialized = true
                Log.d(TAG, "TTS đã được khởi tạo thành công")
            }
        } else {
            Log.e(TAG, "Không thể khởi tạo TTS")
        }
    }

    /**
     * Đọc một đoạn text
     */
    fun speak(text: String) {
        if (isInitialized && tts != null) {
            // Sử dụng QUEUE_FLUSH để không đọc nhiều câu cùng lúc
            tts?.speak(text, TextToSpeech.QUEUE_FLUSH, null, "utteranceId")
            Log.d(TAG, "Đang đọc: $text")
        } else {
            Log.w(TAG, "TTS chưa sẵn sàng, đang chờ khởi tạo...")
            // Retry sau 500ms
            android.os.Handler(android.os.Looper.getMainLooper()).postDelayed({
                if (isInitialized && tts != null) {
                    tts?.speak(text, TextToSpeech.QUEUE_FLUSH, null, "utteranceId")
                }
            }, 500)
        }
    }

    /**
     * Đọc số tiền đã được chuyển sang chữ
     */
    fun speakAmount(amount: Long) {
        val amountText = convertNumberToVietnamese(amount)
        val message = "Bạn vừa nhận $amountText"
        speak(message)
    }

    /**
     * Chuyển số tiền sang chữ tiếng Việt
     * Hỗ trợ từ 0 đến 999 tỷ
     */
    fun convertNumberToVietnamese(number: Long): String {
        if (number == 0L) return "không đồng"

        val units = arrayOf("", "nghìn", "triệu", "tỷ")
        val digits = arrayOf(
            "không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"
        )
        val tens = arrayOf(
            "", "mười", "hai mươi", "ba mươi", "bốn mươi", "năm mươi",
            "sáu mươi", "bảy mươi", "tám mươi", "chín mươi"
        )

        fun readThreeDigits(n: Int): String {
            if (n == 0) return ""
            
            val hundred = n / 100
            val remainder = n % 100
            val ten = remainder / 10
            val digit = remainder % 10

            val result = StringBuilder()

            // Hàng trăm
            if (hundred > 0) {
                result.append(digits[hundred]).append(" trăm ")
            }

            // Hàng chục và đơn vị
            when {
                remainder == 0 -> {
                    // Không có gì
                }
                remainder < 10 -> {
                    if (hundred > 0) result.append("lẻ ")
                    result.append(digits[digit])
                }
                remainder == 10 -> {
                    result.append("mười")
                }
                remainder < 20 -> {
                    result.append("mười ")
                    if (digit == 5) {
                        result.append("lăm")
                    } else {
                        result.append(digits[digit])
                    }
                }
                else -> {
                    result.append(tens[ten])
                    if (digit > 0) {
                        result.append(" ")
                        if (digit == 5) {
                            result.append("lăm")
                        } else if (digit == 1 && ten > 1) {
                            result.append("mốt")
                        } else {
                            result.append(digits[digit])
                        }
                    }
                }
            }

            return result.toString().trim()
        }

        // Chia số thành các nhóm 3 chữ số
        val groups = mutableListOf<Int>()
        var num = number
        while (num > 0) {
            groups.add((num % 1000).toInt())
            num /= 1000
        }

        val result = StringBuilder()
        for (i in groups.indices.reversed()) {
            val groupValue = groups[i]
            if (groupValue > 0) {
                if (result.isNotEmpty()) result.append(" ")
                result.append(readThreeDigits(groupValue))
                if (i > 0 && units[i].isNotEmpty()) {
                    result.append(" ").append(units[i])
                }
            }
        }

        return result.toString().trim() + " đồng"
    }

    /**
     * Dừng đọc
     */
    fun stop() {
        tts?.stop()
    }

    /**
     * Giải phóng tài nguyên
     */
    fun shutdown() {
        tts?.stop()
        tts?.shutdown()
        tts = null
        isInitialized = false
    }

    companion object {
        private const val TAG = "TextToSpeechHelper"
    }
}

