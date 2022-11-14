#include "MainWindow.h"

MainWindow::MainWindow(char* argv[])
{
    QNetworkProxy::setApplicationProxy(QNetworkProxy::NoProxy);//如果不设置默认是QNetworkProxy::DefaultProxy
    // 初始化日志
    Logger::instance()->initGoogleLog(argv);
    // 依赖注入
    ApplicationInjector::init();

//        QGuiApplication::setQuitOnLastWindowClosed(true);
    QFont font;
    font.setFamily("Microsoft YaHei");
    QGuiApplication::setFont(font);
    QQuickWindow::setTextRenderType(QQuickWindow::NativeTextRendering);
    QGuiApplication::setWindowIcon(QIcon(":/image/favicon.png"));
    QQuickStyle::setStyle("Basic");

    CommonTool* commonTool = CommonTool::instance();
    m_engine.rootContext()->setContextProperty("commonTool", commonTool);

    UiHelper* uiHelper = UiHelper::instance();
    m_engine.rootContext()->setContextProperty("uiHelper", uiHelper);

    UserHelper* userHelper = UserHelper::instance();
    m_engine.rootContext()->setContextProperty("userHelper", userHelper);

    SettingsHelper* settingsHelper = SettingsHelper::instance();
    m_engine.rootContext()->setContextProperty("settingsHelper", settingsHelper);

    AppConfig* appConfig = AppConfig::instance();
    m_engine.rootContext()->setContextProperty("appConfig", appConfig);

    qmlRegisterType<TextDocument>("UI", 1, 0, "TextDocument");
    qmlRegisterType<PixmapImage>("UI", 1, 0, "PixmapImage");
    qmlRegisterType<ScreensHotHelper>("UI", 1, 0, "ScreensHotHelper");
     qmlRegisterType<JsonFormartHelper>("UI", 1, 0, "JsonFormartHelper");

    qmlRegisterType<LoginController>("Controller", 1, 0, "LoginController");
    qmlRegisterType<MainController>("Controller", 1, 0, "MainController");

    m_engine.setNetworkAccessManagerFactory(new MyNetworkAccessManagerFactory);
}

MainWindow::~MainWindow()
{
}

void MainWindow::show()
{
    m_engine.load(QUrl("qrc:///layout/App.qml"));
}
