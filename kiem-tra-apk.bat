@echo off
echo ========================================
echo   Kiem tra APK
echo ========================================
echo.

set APK_PATH=app\build\outputs\apk\debug\app-debug.apk

if not exist "%APK_PATH%" (
    echo [LOI] Khong tim thay file APK!
    echo Vui long build APK truoc: Build ^> Build APK(s)
    pause
    exit /b 1
)

echo [OK] Tim thay file APK: %APK_PATH%
echo.

echo [1/4] Kiem tra kich thuoc file...
for %%A in ("%APK_PATH%") do set SIZE=%%~zA
set /a SIZE_MB=%SIZE% / 1048576
echo     Kich thuoc: %SIZE_MB% MB

if %SIZE_MB% LSS 1 (
    echo [LOI] File APK qua nho! Co the bi loi trong qua trinh build.
    echo     Vui long build lai APK.
) else if %SIZE_MB% GTR 50 (
    echo [CANH BAO] File APK kha lon (%SIZE_MB% MB), nhung van co the dung duoc.
) else (
    echo [OK] Kich thuoc hop le.
)
echo.

echo [2/4] Kiem tra vi tri file...
echo     Vi tri: %APK_PATH%
if "%APK_PATH%"=="app\build\outputs\apk\debug\app-debug.apk" (
    echo [OK] File o dung vi tri.
) else (
    echo [CANH BAO] File khong o vi tri chuan.
    echo     Vi tri chuan: app\build\outputs\apk\debug\app-debug.apk
)
echo.

echo [3/4] Kiem tra ADB (neu co)...
where adb >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Tim thay ADB
    echo.
    echo [4/4] Kiem tra thiet bi ket noi...
    adb devices | find "device" >nul 2>&1
    if %errorlevel% equ 0 (
        echo [OK] Co thiet bi ket noi
        echo.
        echo Ban co muon cai APK qua ADB khong? (Y/N)
        set /p INSTALL="Nhap Y de cai, N de bo qua: "
        if /i "%INSTALL%"=="Y" (
            echo.
            echo Dang cai APK...
            adb install -r "%APK_PATH%"
            if %errorlevel% equ 0 (
                echo [OK] Cai dat thanh cong!
            ) else (
                echo [LOI] Cai dat that bai. Xem thong bao loi o tren.
            )
        )
    ) else (
        echo [THONG BAO] Khong co thiet bi ket noi
        echo     Ket noi dien thoai qua USB va bat USB Debugging
    )
) else (
    echo [THONG BAO] Khong tim thay ADB
    echo     ADB nam trong Android SDK platform-tools
)
echo.

echo ========================================
echo   Ket qua kiem tra
echo ========================================
echo.
echo File APK: %APK_PATH%
echo Kich thuoc: %SIZE_MB% MB
echo.
echo Neu van bi loi "Ung dung chua duoc cai dat":
echo 1. Go app cu hoan toan (Settings ^> Apps ^> Uninstall)
echo 2. Bat "Cho phep cai dat tu nguon khong xac dinh"
echo 3. Thu build APK Release thay vi Debug
echo 4. Xem file KIEM_TRA_APK.md de biet them chi tiet
echo.

pause

