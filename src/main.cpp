#include <ui/MainWindow.h>

#include <QApplication>
#include <QGuiApplication>
#include <QMessageBox>
#include <QNetworkAccessManager>
#include <QProcess>
#include <QWebEngineSettings>
#include <QQmlApplicationEngine>


int main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGLRhi);
    QtWebEngineQuick::initialize();
    QApplication app(argc, argv);
    QTranslator translator;
    translator.load(":/translations/qtwebengine_zh_CN.qm");
    app.installTranslator(&translator);
    QSharedMemory singleton(app.applicationName());
    if (!singleton.create(1)) {  // 已经存在的
        QMessageBox::critical(nullptr, QObject::tr("错误"), QObject::tr("程序已经在运行，请先关闭！"));
        return -1;
    }
    //    QHotkey hotkey(QKeySequence("Ctrl+Alt+Q"), true, &app);
    //    QObject::connect(&hotkey, &QHotkey::activated, qApp, [&](){
    //        qApp->quit();
    //    });
    MainWindow window(argv);
    QApplication::setOrganizationName("HIWITECH.COM");
    QApplication::setApplicationName("AvicIM");
    window.show();
    const int exec = QApplication::exec();
    if (exec == 931) {
        QProcess::startDetached(qApp->applicationFilePath(), QStringList());
    }
    return exec;
}
