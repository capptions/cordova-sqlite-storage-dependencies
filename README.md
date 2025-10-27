# Cordova sqlite storage dependencies

**AUTHOR:** Christopher J. Brody

**LICENSE:** MIT (for `sql-asm-memory-growth.js` built from fork of [`sql-js/sql.js`](https://github.com/sql-js/sql.js)); public domain for other artifacts

**NOTE:** This branch includes Android 16KB page size support for Android 15+ devices. For more information, see [Android 16KB Page Size Support](#android-16kb-page-size-support) below.

Contains source and object code built from:
- [`storesafe/sql.js`](https://github.com/storesafe/sql.js) - fork of [`sql-js/sql.js`](https://github.com/sql-js/sql.js) (MIT license)
- SQLite3 from [sqlite.org](http://sqlite.org/) (public domain)
- [`brodybits/android-sqlite-native-ndk-connector`](https://github.com/brodybits/android-sqlite-native-ndk-connector) (Unlicense, public domain)
- [`brodybits/android-sqlite-ndk-native-driver`](https://github.com/brodybits/android-sqlite-ndk-native-driver) (Unlicense, public domain)

This project provides the following dependencies needed to build [`storesafe/cordova-sqlite-storage`](https://github.com/storesafe/cordova-sqlite-storage):
- `sql-asm-memory-growth.js` - built from [`storesafe/sql.js`](https://github.com/storesafe/sql.js) (fork of [`sql-js/sql.js`](https://github.com/sql-js/sql.js)) with SQLite `3.22.3` for `browser` platform
- `sqlite3.h`, `sqlite3.c` - SQLite `3.40.0` amalgamation needed to build iOS, macOS, and Windows platforms
- `libs` - JAR libraries built from [`github:brodybits/android-sqlite-ndk-native-driver` - `sqlite-storage-ndk-native-driver` branch](https://github.com/brodybits/android-sqlite-ndk-native-driver/tree/sqlite-storage-ndk-native-driver) and [`brodybits/android-sqlite-native-ndk-connector`](https://github.com/brodybits/android-sqlite-native-ndk-connector), built with SQLite amalgamation, with the following flags:
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

1. Clone the source repositories ([android-sqlite-ndk-native-driver](https://github.com/brodybits/android-sqlite-ndk-native-driver))
2. Apply the linker flags from `jni/Android.mk.example`
3. Build with NDK r28+ using the Application.mk configuration provided
4. Package the resulting `.so` files into JAR files

For automated rebuilding, see the rebuild scripts in the parent cordova-sqlite-storage repository.

### References

- [Android 16KB Page Size Documentation](https://source.android.com/docs/core/architecture/16kb-page-size/16kb)
- [Google Play Requirements](https://support.google.com/googleplay/android-developer/answer/11926878)
