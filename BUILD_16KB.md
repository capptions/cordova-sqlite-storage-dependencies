# Building with Android 16KB Page Size Support

This document describes how to rebuild the native libraries in this package with Android 16KB page size support.

## Prerequisites

1. **Android NDK r28 or higher** - Download from [Android NDK](https://developer.android.com/ndk/downloads)
2. **Java JDK** - For JAR packaging
3. **Source repositories**:
   - [android-sqlite-ndk-native-driver](https://github.com/brodybits/Android-sqlite-ext-native-driver/tree/sqlite-storage-native-driver)
   - [android-sqlite-native-ndk-connector](https://github.com/brodybits/android-sqlite-native-ndk-connector)

## Build Configuration

### Application.mk

Use the provided `jni/Application.mk` which includes:
- `APP_SUPPORT_FLEXIBLE_PAGE_SIZES := true` - Required for 16KB support
- NDK_TOOLCHAIN_VERSION := clang
- APP_PLATFORM := android-21

### Android.mk

Add the following linker flags to your Android.mk:

```makefile
LOCAL_LDFLAGS += -Wl,-z,max-page-size=16384
LOCAL_LDFLAGS += -Wl,-z,common-page-size=16384
```

These flags ensure that the library is aligned to 16KB pages, allowing it to work on both 4KB and 16KB page size devices.

## Build Steps

1. **Clone the native driver source repository**:
   ```bash
   git clone https://github.com/brodybits/Android-sqlite-ext-native-driver.git
   cd Android-sqlite-ext-native-driver
   git checkout sqlite-storage-native-driver
   ```

2. **Copy build configuration files**:
   ```bash
   mkdir jni
   cp /path/to/cordova-sqlite-storage-dependencies/jni/Application.mk jni/
   cp /path/to/cordova-sqlite-storage-dependencies/jni/Android.mk.example jni/Android.mk
   ```

3. **Update Android.mk with linker flags** as described above

4. **Clean previous builds**:
   ```bash
   ndk-build clean
   ```

5. **Build the native libraries**:
   ```bash
   ndk-build NDK_APPLICATION_MK=jni/Application.mk
   ```

6. **Verify 16KB alignment** (optional):
   ```bash
   readelf -l libs/arm64-v8a/libsqlc-native-driver.so | grep align
   # Should show: align 2**14 (16KB)
   ```

7. **Package into JAR**:
   ```bash
   cd libs
   jar cf ../sqlite-ndk-native-driver.jar lib/
   ```

## Verification

After building, verify that your `.so` files are aligned to 16KB:

```bash
readelf -l libs/*/libsqlc*.so | grep -A 1 LOAD
```

Look for sections with alignment `0x4000` (16384 bytes = 16KB).

## Automated Build Script

For automated building, use the `rebuild-sqlite-16kb.sh` script in the parent cordova-sqlite-storage repository.

## More Information

- [Android 16KB Page Size Guide](https://source.android.com/docs/core/architecture/16kb-page-size/16kb)
- [Google Play Requirements](https://support.google.com/googleplay/android-developer/answer/11926878)
- This project's README.md for general information
