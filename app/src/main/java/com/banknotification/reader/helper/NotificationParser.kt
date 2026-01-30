package com.banknotification.reader.helper

import android.util.Log

/**
 * Helper class để parse số tiền từ nội dung thông báo
 * Sử dụng Regex để tìm các định dạng số tiền phổ biến
 */
object NotificationParser {

    /**
     * Extract số tiền từ text
     * Hỗ trợ các định dạng:
     * - 100.000 VNĐ
     * - 50,000 đồng
     * - 1000000
     * - 1,000,000 VND
     */
    fun extractAmount(text: String): Long {
        try {
            // Regex pattern để tìm số tiền
            // Pattern 1: Số có dấu chấm hoặc phẩy làm phân cách hàng nghìn (VD: 100.000, 1,000,000)
            val pattern1 = Regex("""(\d{1,3}(?:[.,]\d{3})*(?:[.,]\d+)?)""")
            
            // Pattern 2: Số liền không có dấu phân cách (VD: 100000, 50000)
            val pattern2 = Regex("""(\d{4,})""")
            
            // Tìm tất cả các số khớp với pattern
            val matches1 = pattern1.findAll(text)
            val matches2 = pattern2.findAll(text)
            
            // Kết hợp tất cả matches
            val allMatches = (matches1 + matches2).map { it.value }
            
            Log.d(TAG, "Tìm thấy các số: $allMatches")
            
            // Tìm số lớn nhất (thường là số tiền)
            var maxAmount = 0L
            
            for (match in allMatches) {
                // Loại bỏ dấu chấm và phẩy
                val cleanNumber = match.replace(".", "").replace(",", "")
                
                try {
                    val amount = cleanNumber.toLong()
                    // Chỉ lấy số >= 1000 (để tránh lấy nhầm số nhỏ như số điện thoại, năm, v.v.)
                    if (amount >= 1000 && amount > maxAmount) {
                        maxAmount = amount
                    }
                } catch (e: NumberFormatException) {
                    Log.w(TAG, "Không thể parse số: $match")
                }
            }
            
            // Nếu không tìm thấy số >= 1000, thử tìm số nhỏ hơn nhưng >= 100
            if (maxAmount == 0L) {
                for (match in allMatches) {
                    val cleanNumber = match.replace(".", "").replace(",", "")
                    try {
                        val amount = cleanNumber.toLong()
                        if (amount >= 100 && amount > maxAmount) {
                            maxAmount = amount
                        }
                    } catch (e: NumberFormatException) {
                        // Ignore
                    }
                }
            }
            
            Log.d(TAG, "Số tiền được extract: $maxAmount")
            return maxAmount
            
        } catch (e: Exception) {
            Log.e(TAG, "Lỗi khi parse số tiền: ${e.message}")
            return 0L
        }
    }

    companion object {
        private const val TAG = "NotificationParser"
    }
}

