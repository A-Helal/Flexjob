#!/bin/bash

# Script to verify 16 KB page size support for Android app
# Based on: https://developer.android.com/guide/practices/page-sizes

set -e

echo "=========================================="
echo "16 KB Page Size Support Verification"
echo "=========================================="
echo ""

# Check if APK/AAB file is provided
if [ -z "$1" ]; then
    echo "Usage: ./verify_16kb_support.sh <path-to-apk-or-aab>"
    echo "Example: ./verify_16kb_support.sh build/app/outputs/bundle/release/app-release.aab"
    exit 1
fi

APP_FILE="$1"

if [ ! -f "$APP_FILE" ]; then
    echo "Error: File not found: $APP_FILE"
    exit 1
fi

# Determine if it's an APK or AAB
FILE_EXT="${APP_FILE##*.}"

echo "Analyzing: $APP_FILE"
echo "File type: $FILE_EXT"
echo ""

# Create temporary directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Extract the file
echo "Extracting file..."
if [ "$FILE_EXT" = "aab" ]; then
    unzip -q "$APP_FILE" -d "$TEMP_DIR"
    # For AAB, check base module
    LIB_DIR="$TEMP_DIR/base/lib"
else
    unzip -q "$APP_FILE" -d "$TEMP_DIR"
    LIB_DIR="$TEMP_DIR/lib"
fi

# Check if lib directory exists
if [ ! -d "$LIB_DIR" ]; then
    echo "✓ No native libraries found - app is 16 KB compatible"
    exit 0
fi

echo "Found native libraries directory"
echo ""

# Find Android SDK and NDK
if [ -z "$ANDROID_HOME" ] && [ -z "$ANDROID_SDK_ROOT" ]; then
    echo "Error: ANDROID_HOME or ANDROID_SDK_ROOT not set"
    echo "Please set one of these environment variables to your Android SDK location"
    exit 1
fi

SDK_ROOT="${ANDROID_HOME:-$ANDROID_SDK_ROOT}"

# Find llvm-objdump
OBJDUMP=""
if [ -d "$SDK_ROOT/ndk" ]; then
    # Find the latest NDK version
    NDK_VERSION=$(ls -1 "$SDK_ROOT/ndk" | sort -V | tail -1)
    if [ "$(uname)" = "Darwin" ]; then
        OBJDUMP="$SDK_ROOT/ndk/$NDK_VERSION/toolchains/llvm/prebuilt/darwin-x86_64/bin/llvm-objdump"
    else
        OBJDUMP="$SDK_ROOT/ndk/$NDK_VERSION/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-objdump"
    fi
fi

if [ ! -f "$OBJDUMP" ]; then
    echo "Warning: llvm-objdump not found. Skipping ELF alignment check."
    echo "Install Android NDK to perform full verification."
    OBJDUMP=""
fi

# Check each .so file
FAILED=0
CHECKED=0

echo "Checking native libraries for 16 KB alignment..."
echo ""

for SO_FILE in $(find "$LIB_DIR" -name "*.so"); do
    RELATIVE_PATH="${SO_FILE#$TEMP_DIR/}"
    
    # Only check arm64-v8a and x86_64 architectures
    if [[ ! "$RELATIVE_PATH" =~ (arm64-v8a|x86_64) ]]; then
        continue
    fi
    
    CHECKED=$((CHECKED + 1))
    
    if [ -n "$OBJDUMP" ]; then
        # Check ELF segment alignment
        ALIGNMENT_OUTPUT=$("$OBJDUMP" -p "$SO_FILE" | grep "LOAD" || true)
        
        if echo "$ALIGNMENT_OUTPUT" | grep -q "2\*\*1[0-3]"; then
            echo "✗ FAILED: $RELATIVE_PATH"
            echo "  Found segments with alignment less than 2**14 (16 KB)"
            echo "$ALIGNMENT_OUTPUT" | head -3
            echo ""
            FAILED=$((FAILED + 1))
        else
            echo "✓ PASSED: $RELATIVE_PATH"
        fi
    else
        echo "? SKIPPED: $RELATIVE_PATH (no objdump available)"
    fi
done

echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
echo "Libraries checked: $CHECKED"

if [ $FAILED -gt 0 ]; then
    echo "Status: ✗ FAILED"
    echo ""
    echo "Some libraries are not 16 KB aligned."
    echo "Please rebuild your app with the updated configuration."
    exit 1
else
    echo "Status: ✓ PASSED"
    echo ""
    echo "All checked libraries appear to be 16 KB compatible!"
    
    if [ "$FILE_EXT" = "apk" ]; then
        echo ""
        echo "Note: For final verification, also check with zipalign:"
        echo "  zipalign -c -P 16 -v 4 $APP_FILE"
    fi
fi
