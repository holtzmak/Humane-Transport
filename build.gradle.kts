buildscript {
    repositories {
        gradlePluginPortal()
        jcenter()
        google()
        mavenCentral()
    }
    dependencies {
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.4.10")
        classpath("com.android.tools.build:gradle:3.5.2")
    }
}
group = "ca.humanetransport"
version = "1.0"

repositories {
    mavenCentral()
}
