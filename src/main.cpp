#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QNetworkAccessManager>
#include <ui/MainWindow.h>

int main(int argc, char* argv[])
{
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
  QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
#if (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
  QApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
#endif
#endif
  QApplication app(argc, argv);

  //    QHotkey hotkey(QKeySequence("Ctrl+Alt+Q"), true, &app);
  //    QObject::connect(&hotkey, &QHotkey::activated, qApp, [&](){
  //        qApp->quit();
  //    });
  MainWindow window(argv);
  QApplication::setOrganizationName("HIWITECH.COM");
  QApplication::setApplicationName("AvicIM");
  window.show();

  int e = app.exec();
  if (e == 931)
  {
    QProcess::startDetached(qApp->applicationFilePath(), QStringList());
  }
  return 0;
}
