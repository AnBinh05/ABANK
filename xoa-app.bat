@echo off
chcp 65001 >nul
echo ========================================
echo   Xóa app Bank Notification Reader
echo ========================================
echo.

echo [1/4] Kiểm tra kết nối ADB...
adb devices >nul 2>&1
if %errorlevel% neq 0 (
    echo [LỖI] Không tìm thấy ADB hoặc thiết bị!
    echo.
    echo Vui lòng:
    echo   1. Cài đặt Android SDK Platform Tools
    echo   2. Kết nối điện thoại qua USB
    echo   3. Bật USB Debugging trên điện thoại
    echo   4. Chấp nhận "Allow USB debugging" trên điện thoại
    echo.
    pause
    exit /b 1
)

echo [OK] Tìm thấy ADB
echo.

echo [2/4] Kiểm tra thiết bị đã kết nối...
adb devices | find "device" >nul 2>&1
if %errorlevel% neq 0 (
    echo [LỖI] Không có thiết bị nào kết nối!
    echo.
    echo Vui lòng:
    echo   1. Kết nối điện thoại qua USB
    echo   2. Bật USB Debugging: Settings ^> Developer options ^> USB debugging
    echo   3. Chấp nhận "Allow USB debugging" trên điện thoại
    echo.
    pause
    exit /b 1
)

echo [OK] Thiết bị đã kết nối
echo.

echo [3/5] Kiểm tra app có tồn tại không...
adb shell pm list packages | findstr banknotification >nul 2>&1
if %errorlevel% equ 0 (
    echo [THÔNG BÁO] Tìm thấy app, đang xóa...
) else (
    echo [THÔNG BÁO] Không tìm thấy app trong danh sách.
    echo     Có thể app chưa được cài đặt hoặc đã bị xóa.
    echo     Vẫn sẽ thử xóa để đảm bảo.
)
echo.

echo [4/5] Đang xóa app...
adb uninstall com.banknotification.reader
if %errorlevel% equ 0 (
    echo [OK] Đã xóa app thành công!
) else (
    echo [THÔNG BÁO] App có thể đã bị xóa hoặc chưa được cài đặt.
)
echo.

echo [5/5] Đang xóa dữ liệu app (nếu còn)...
adb shell pm clear com.banknotification.reader 2>nul
if %errorlevel% equ 0 (
    echo [OK] Đã xóa dữ liệu app!
) else (
    echo [THÔNG BÁO] Không có dữ liệu để xóa.
)
echo.

echo ========================================
echo   Kiểm tra kết quả
echo ========================================
echo.
echo Đang kiểm tra app còn tồn tại không...
adb shell pm list packages | findstr banknotification >nul 2>&1
if %errorlevel% neq 0 (
    echo [OK] App đã được xóa hoàn toàn!
    echo.
    echo Bây giờ bạn có thể cài đặt lại APK mới.
) else (
    echo [CẢNH BÁO] App vẫn còn tồn tại.
    echo.
    echo Thử các cách sau:
    echo   1. Xóa thủ công qua Settings ^> Apps
    echo   2. Khởi động lại điện thoại
    echo   3. Xem file XOA_APP_HOAN_TOAN.md để biết thêm
)
echo.

pause

