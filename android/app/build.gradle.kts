plugins {
    id("com.android.application")
    id("kotlin-android")
    // O Flutter Gradle Plugin deve ser aplicado após os plugins do Android e Kotlin.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.app1"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // Especifica a versão do NDK

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17 // Configurado para Java 17
        targetCompatibility = JavaVersion.VERSION_17 // Configurado para Java 17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString() // Configura o Kotlin para usar Java 17
    }

    defaultConfig {
        multiDexEnabled = true
        applicationId = "com.example.app1" // Identificador único para o aplicativo
        minSdk = flutter.minSdkVersion // Versão mínima do SDK
        targetSdk = flutter.targetSdkVersion // Versão alvo do SDK
        versionCode = flutter.versionCode // Código da versão
        versionName = flutter.versionName // Nome da versão
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Configuração de assinatura
        }
    }

    lint {
        checkReleaseBuilds = false // Desabilitar checagem de builds de release
    }
}

dependencies {
    // Atualizando para a versão 2.1.4 conforme requerido pelo flutter_local_notifications
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.." // Diretório do código-fonte do Flutter
}