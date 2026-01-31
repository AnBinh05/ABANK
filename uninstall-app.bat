@echo off
echo ========================================
echo   Gỡ App Bank Notification Reader
echo ========================================
echo.

echo Đang kiểm tra kết nối ADB...
adb devices
if %errorlevel% neq 0 (
    echo Lỗi: Không tìm thấy ADB hoặc thiết bị chưa kết nối!
    echo.
    echo Vui lòng:
    echo 1. Cài đặt Android SDK Platform Tools
    echo 2. Kết nối điện thoại qua USB
    echo 3. Bật USB Debugging trên điện thoại
    pause
    exit /b 1
)

echo.
echo Đang gỡ app com.banknotification.reader...
adb uninstall com.banknotification.reader

if %errorlevel% equ 0 (
    echo.
    echo ✅ Đã gỡ app cũ thành công!
    echo.
    echo Bây giờ bạn có thể cài APK mới.
) else (
    echo.
    echo ⚠️ Không tìm thấy app hoặc app đã được gỡ trước đó.
    echo.
    echo Bạn vẫn có thể cài APK mới.
)

echo.
pause

