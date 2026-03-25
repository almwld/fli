#!/bin/bash

# Flex Yemen - One-Click Build Script
# This script automates the process of building the release APK.

echo "=========================================="
echo "   Flex Yemen - Building Release APK      "
echo "=========================================="

# 1. Clean previous builds
echo "Step 1: Cleaning previous builds..."
flutter clean

# 2. Get dependencies
echo "Step 2: Fetching dependencies..."
flutter pub get

# 3. Build APK
echo "Step 3: Building Release APK..."
flutter build apk --release --no-tree-shake-icons

# 4. Check result
if [ $? -eq 0 ]; then
    echo "=========================================="
    echo "✅ Success! APK generated at:"
    echo "build/app/outputs/flutter-apk/app-release.apk"
    echo "=========================================="
else
    echo "=========================================="
    echo "❌ Error: Build failed. Please check the logs above."
    echo "=========================================="
fi

# Keep window open (for Windows users running via git bash)
read -p "Press enter to exit..."
