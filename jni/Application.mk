# Application.mk for cordova-sqlite-storage-dependencies
# Android 16KB Page Size Support Configuration

# Supported ABIs
APP_ABI := armeabi-v7a arm64-v8a x86 x86_64

# Minimum API level
APP_PLATFORM := android-21

# Use Clang toolchain
NDK_TOOLCHAIN_VERSION := clang

# Enable flexible page size support (required for Android 15+ 16KB pages)
APP_SUPPORT_FLEXIBLE_PAGE_SIZES := true

# C++ standard
APP_CPPFLAGS := -std=c++11

# C++ Standard Library
APP_STL := c++_static
