#!/bin/bash

echo "========================================"
echo "  Building Bank Notification Reader APK"
echo "========================================"
echo ""

echo "[1/3] Cleaning previous builds..."
./gradlew clean
if [ $? -ne 0 ]; then
    echo "Clean failed!"
    exit 1
fi

echo ""
echo "[2/3] Building Debug APK..."
./gradlew assembleDebug
if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

echo ""
echo "[3/3] Build completed successfully!"
echo ""
echo "APK location: app/build/outputs/apk/debug/app-debug.apk"
echo ""
echo "You can now install this APK on your Android device."
echo ""

