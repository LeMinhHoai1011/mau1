plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.mau1"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        // Nâng lên VERSION_17 hoặc VERSION_21 để tương thích với SDK 36 và JDK 21
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        // Chuỗi chuẩn cho Kotlin DSL bản mới
        jvmTarget = "17" 
    }

    defaultConfig {
        applicationId = "com.example.mau1"
        minSdk = 21
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}