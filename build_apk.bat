@echo off
title Flex Yemen - One-Click Build Script

echo ==========================================
echo    Flex Yemen - Building Release APK      
echo ==========================================

:: 1. Clean previous builds
echo Step 1: Cleaning previous builds...
call flutter clean

:: 2. Get dependencies
echo Step 2: Fetching dependencies...
call flutter pub get

:: 3. Build APK
echo Step 3: Building Release APK...
call flutter build apk --release --no-tree-shake-icons

:: 4. Check result
if %ERRORLEVEL% EQU 0 (
    echo ==========================================
    echo ✅ Success! APK generated at:
    echo build\app\outputs\flutter-apk\app-release.apk
    echo ==========================================
) else (
    echo ==========================================
    echo ❌ Error: Build failed. Please check the logs above.
    echo ==========================================
)

pause
