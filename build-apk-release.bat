@echo off
echo ========================================
echo   Building Bank Notification Reader APK (Release)
echo ========================================
echo.
echo NOTE: This will build a release APK.
echo For production use, you should sign the APK with a keystore.
echo.

echo [1/3] Cleaning previous builds...
call gradlew.bat clean
if %errorlevel% neq 0 (
    echo Clean failed!
    pause
    exit /b 1
)

echo.
echo [2/3] Building Release APK...
call gradlew.bat assembleRelease
if %errorlevel% neq 0 (
    echo Build failed!
    pause
    exit /b 1
)

echo.
echo [3/3] Build completed successfully!
echo.
echo APK location: app\build\outputs\apk\release\app-release.apk
echo.
echo NOTE: This APK is unsigned. For production, you need to sign it.
echo See HUONG_DAN_BUILD_APK.md for signing instructions.
echo.

pause

