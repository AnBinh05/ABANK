# Script kiểm tra APK chi tiết
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Kiểm tra APK chi tiết" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$apkPath = "app\build\outputs\apk\debug\app-debug.apk"
$apkReleasePath = "app\build\outputs\apk\release\app-release.apk"

# Kiểm tra file APK Debug
Write-Host "[1/6] Kiểm tra file APK Debug..." -ForegroundColor Yellow
if (Test-Path $apkPath) {
    $fileInfo = Get-Item $apkPath
    $sizeMB = [math]::Round($fileInfo.Length / 1MB, 2)
    Write-Host "  [OK] Tìm thấy file: $apkPath" -ForegroundColor Green
    Write-Host "  Kích thước: $sizeMB MB" -ForegroundColor White
    
    if ($sizeMB -lt 1) {
        Write-Host "  [LỖI] File quá nhỏ! APK có thể bị lỗi." -ForegroundColor Red
    } elseif ($sizeMB -gt 50) {
        Write-Host "  [CẢNH BÁO] File khá lớn ($sizeMB MB), nhưng vẫn có thể dùng được." -ForegroundColor Yellow
    } else {
        Write-Host "  [OK] Kích thước hợp lệ." -ForegroundColor Green
    }
} else {
    Write-Host "  [LỖI] Không tìm thấy file APK Debug!" -ForegroundColor Red
    Write-Host "  Vui lòng build APK trước: Build > Build APK(s)" -ForegroundColor Yellow
}

Write-Host ""

# Kiểm tra file APK Release
Write-Host "[2/6] Kiểm tra file APK Release..." -ForegroundColor Yellow
if (Test-Path $apkReleasePath) {
    $fileInfo = Get-Item $apkReleasePath
    $sizeMB = [math]::Round($fileInfo.Length / 1MB, 2)
    Write-Host "  [OK] Tìm thấy file: $apkReleasePath" -ForegroundColor Green
    Write-Host "  Kích thước: $sizeMB MB" -ForegroundColor White
    Write-Host "  [GỢI Ý] APK Release thường ổn định hơn Debug!" -ForegroundColor Cyan
} else {
    Write-Host "  [THÔNG BÁO] Không tìm thấy APK Release." -ForegroundColor Yellow
    Write-Host "  Bạn có thể build APK Release để ổn định hơn." -ForegroundColor White
}

Write-Host ""

# Kiểm tra ADB
Write-Host "[3/6] Kiểm tra ADB..." -ForegroundColor Yellow
$adbPath = Get-Command adb -ErrorAction SilentlyContinue
if ($adbPath) {
    Write-Host "  [OK] Tìm thấy ADB" -ForegroundColor Green
    
    # Kiểm tra thiết bị
    Write-Host "  Đang kiểm tra thiết bị..." -ForegroundColor White
    $devices = adb devices 2>&1
    if ($devices -match "device$") {
        Write-Host "  [OK] Có thiết bị đã kết nối" -ForegroundColor Green
        
        Write-Host ""
        Write-Host "[4/6] Thử cài đặt APK qua ADB để xem lỗi cụ thể..." -ForegroundColor Yellow
        $response = Read-Host "  Bạn có muốn thử cài APK qua ADB không? (Y/N)"
        if ($response -eq "Y" -or $response -eq "y") {
            if (Test-Path $apkPath) {
                Write-Host "  Đang cài đặt..." -ForegroundColor White
                adb install -r -d $apkPath
            } else {
                Write-Host "  [LỖI] Không tìm thấy file APK để cài đặt" -ForegroundColor Red
            }
        }
    } else {
        Write-Host "  [THÔNG BÁO] Không có thiết bị nào kết nối" -ForegroundColor Yellow
        Write-Host "  Kết nối điện thoại qua USB và bật USB Debugging" -ForegroundColor White
    }
} else {
    Write-Host "  [THÔNG BÁO] Không tìm thấy ADB" -ForegroundColor Yellow
    Write-Host "  ADB nằm trong Android SDK platform-tools" -ForegroundColor White
}

Write-Host ""

# Kiểm tra AndroidManifest
Write-Host "[5/6] Kiểm tra AndroidManifest.xml..." -ForegroundColor Yellow
$manifestPath = "app\src\main\AndroidManifest.xml"
if (Test-Path $manifestPath) {
    $manifestContent = Get-Content $manifestPath -Raw
    
    $checks = @{
        "Package attribute" = $manifestContent -match 'package="com\.banknotification\.reader"'
        "MainActivity exported" = $manifestContent -match 'android:name="\.MainActivity".*android:exported="true"'
        "Service exported=false" = $manifestContent -match 'android:name="\.service\.BankNotificationListenerService".*android:exported="false"'
    }
    
    foreach ($check in $checks.GetEnumerator()) {
        if ($check.Value) {
            Write-Host "  [OK] $($check.Key)" -ForegroundColor Green
        } else {
            Write-Host "  [LỖI] $($check.Key) - Cần kiểm tra lại!" -ForegroundColor Red
        }
    }
} else {
    Write-Host "  [LỖI] Không tìm thấy AndroidManifest.xml!" -ForegroundColor Red
}

Write-Host ""

# Tóm tắt và gợi ý
Write-Host "[6/6] Tóm tắt và gợi ý..." -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Các bước khắc phục" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Gỡ app cũ hoàn toàn:" -ForegroundColor White
Write-Host "   - Chạy: .\xoa-app.bat" -ForegroundColor Yellow
Write-Host "   - Hoặc: Settings > Apps > Uninstall" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. Build APK Release (ổn định hơn):" -ForegroundColor White
Write-Host "   - Build > Generate Signed Bundle / APK" -ForegroundColor Yellow
Write-Host "   - Xem file: BUILD_APK_RELEASE.md" -ForegroundColor Yellow
Write-Host ""
Write-Host "3. Kiểm tra cài đặt điện thoại:" -ForegroundColor White
Write-Host "   - Bật 'Cho phép cài đặt từ nguồn không xác định'" -ForegroundColor Yellow
Write-Host "   - Đảm bảo Android 8.0+ (API 26+)" -ForegroundColor Yellow
Write-Host ""
Write-Host "4. Xem log lỗi chi tiết:" -ForegroundColor White
Write-Host "   - adb install -r -d app\build\outputs\apk\debug\app-debug.apk" -ForegroundColor Yellow
Write-Host ""
Write-Host "5. Xem hướng dẫn chi tiết:" -ForegroundColor White
Write-Host "   - KIEM_TRA_APK.md" -ForegroundColor Yellow
Write-Host "   - KHAC_PHUC_LOI_CAI_DAT.md" -ForegroundColor Yellow
Write-Host ""

