#include <QGuiApplication>
#include <QQuickView>
#include <QQuickStyle>
#include <QQmlEngine>
#include <QQuickItem>
#include <QObject>
#include <QFontDatabase>
#include"SpeechSystem.h"

int main(int argc, char *argv[]){
    QGuiApplication app(argc, argv);

    qmlRegisterType<SpeechSystem>("SpeechSystem",1,0,"SpeechSystem");
    QQuickView viewer;
    QObject::connect(viewer.engine(), SIGNAL(quit()), &app, SLOT(quit()));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setSource(QUrl("qrc:/main.qml"));
    viewer.show();

    return app.exec();
}
