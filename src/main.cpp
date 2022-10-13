#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QNetworkAccessManager>
#include <ui/MainWindow.h>

FRAMELESSHELPER_USE_NAMESPACE

int main(int argc, char* argv[])
{
    std::setlocale(LC_ALL, "en_US.UTF-8");
    FramelessHelper::Quick::initialize();

    QGuiApplication application(argc, argv);

    FramelessHelper::Core::setApplicationOSThemeAware(true, true);
    FramelessConfig::instance()->set(Global::Option::WindowUseRoundCorners);
    FramelessConfig::instance()->set(Global::Option::EnableBlurBehindWindow);

    if (!qEnvironmentVariableIsSet("QSG_INFO")) {
        qputenv("QSG_INFO", FRAMELESSHELPER_BYTEARRAY_LITERAL("1"));
    }

    if (!qEnvironmentVariableIsSet("QSG_RHI_BACKEND")) {
#if (QT_VERSION >= QT_VERSION_CHECK(6, 0, 0))
        QQuickWindow::setGraphicsApi(QSGRendererInterface::Software);
#elif (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
        QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Software);
#endif
    }

    //    QHotkey hotkey(QKeySequence("Ctrl+Alt+Q"), true, &app);
    //    QObject::connect(&hotkey, &QHotkey::activated, qApp, [&](){
    //        qApp->quit();
    //    });
    MainWindow window(argv);
    QGuiApplication::setOrganizationName("HIWITECH.COM");
    QGuiApplication::setApplicationName("AvicIM");
    window.show();

    const int exec = QCoreApplication::exec();
    FramelessHelper::Quick::uninitialize();
    if (exec == 931)
    {
        QProcess::startDetached(qApp->applicationFilePath(), QStringList());
    }
    return exec;
}
