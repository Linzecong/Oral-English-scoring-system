QT += qml quick
QT += qml quick quickcontrols2
QT+=network
QT       += script
QT += multimedia
#QT+=androidextras

CONFIG += c++11

SOURCES += main.cpp \
    SpeechSystem.cpp

RESOURCES += qml.qrc \
    android/img.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    SpeechSystem.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
