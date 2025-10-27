# Cordova sqlite storage dependencies

**AUTHOR:** Christopher J. Brody

**LICENSE:** [Unlicense (unlicense.org)](http://unlicense.org/) (public domain)

**NOTE:** This branch includes Android 16KB page size support for Android 15+ devices. For more information, see [Android 16KB Page Size Support](#android-16kb-page-size-support) below.

Contains source and object code built from:
- SQLite3 from [sqlite.org](http://sqlite.org/) (public domain)
- [liteglue / Android-sqlite-native-driver](https://github.com/liteglue/Android-sqlite-native-driver) (Unlicense, public domain)
- [brodybits / Android-sqlite-ext-native-driver (sqlite-storage-native-driver branch)](https://github.com/brodybits/Android-sqlite-ext-native-driver/tree/sqlite-storage-native-driver) (Unlicense, public domain)

This project provides the following dependencies needed to build [litehelpers / Cordova-sqlite-storage](https://github.com/litehelpers/Cordova-sqlite-storage):
- `sqlite3.h`, `sqlite3.c` - SQLite `3.32.3` amalgamation needed to build iOS/macOS and Windows versions
- `libs` - [liteglue / Android-sqlite-connector](https://github.com/liteglue/Android-sqlite-connector) and [brodybits / Android-sqlite-ext-native-driver (sqlite-storage-native-driver branch)](https://github.com/brodybits/Android-sqlite-ext-native-driver/tree/sqlite-storage-native-driver) JAR libraries built with SQLite `3.32.3` amalgamation, with the following flags:
  - `-DSQLITE_THREADSAFE=1`
  - `-DSQLITE_DEFAULT_SYNCHRONOUS=3`
  - `-DSQLITE_DEFAULT_MEMSTATUS=0`
  - `-DSQLITE_OMIT_DECLTYPE`
  - `-DSQLITE_OMIT_DEPRECATED`
  - `-DSQLITE_OMIT_PROGRESS_CALLBACK`
  - `-DSQLITE_OMIT_SHARED_CACHE`
  - `-DSQLITE_TEMP_STORE=2`
  - `-DSQLITE_OMIT_LOAD_EXTENSION`
  - `-DSQLITE_ENABLE_FTS3`
  - `-DSQLITE_ENABLE_FTS3_PARENTHESIS`
  - `-DSQLITE_ENABLE_FTS4`
  - `-DSQLITE_ENABLE_RTREE`
  - `-DSQLITE_DEFAULT_PAGE_SIZE=4096`
  - `-DSQLITE_DEFAULT_CACHE_SIZE=-2000`

## Android 16KB Page Size Support

Starting with Android 15, Google requires apps to support 16KB memory pages in addition to the traditional 4KB pages. This branch includes native libraries rebuilt with 16KB page size support.

### Build Configuration

The following configuration files have been added for building with 16KB support:

- `jni/Application.mk` - NDK build configuration with `APP_SUPPORT_FLEXIBLE_PAGE_SIZES := true`
- `jni/Android.mk.example` - Reference linker flags for 16KB alignment

### Requirements

- Android NDK r28 or higher
- Android Gradle Plugin 8.5.1 or higher
- Native libraries compiled with:
  - `APP_SUPPORT_FLEXIBLE_PAGE_SIZES := true` in Application.mk
  - Linker flags: `-Wl,-z,max-page-size=16384` and `-Wl,-z,common-page-size=16384`

### Google Play Requirements

- **By November 1, 2025**: All new apps and updates targeting Android 15 or higher must support 16KB memory pages.
- **By May 1, 2026**: Updates for existing apps lacking this support will no longer be accepted on Google Play.

### Rebuilding

To rebuild the native libraries with 16KB support, you'll need to:

1. Clone the source repositories ([android-sqlite-native-driver](https://github.com/brodybits/Android-sqlite-ext-native-driver/tree/sqlite-storage-native-driver))
2. Apply the linker flags from `jni/Android.mk.example`
3. Build with NDK r28+ using the Application.mk configuration provided
4. Package the resulting `.so` files into JAR files

For automated rebuilding, see the rebuild scripts in the parent cordova-sqlite-storage repository.

### References

- [Android 16KB Page Size Documentation](https://source.android.com/docs/core/architecture/16kb-page-size/16kb)
- [Google Play Requirements](https://support.google.com/googleplay/android-developer/answer/11926878)
