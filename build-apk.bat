@echo off
echo ========================================
echo   Building Bank Notification Reader APK
echo ========================================
echo.

echo [1/3] Cleaning previous builds...
call gradlew.bat clean
if %errorlevel% neq 0 (
    echo Clean failed!
    pause
    exit /b 1
)

echo.
echo [2/3] Building Debug APK...
call gradlew.bat assembleDebug
if %errorlevel% neq 0 (
    echo Build failed!
    pause
    exit /b 1
)

echo.
echo [3/3] Build completed successfully!
echo.
echo APK location: app\build\outputs\apk\debug\app-debug.apk
echo.
echo You can now install this APK on your Android device.
echo.

pause

