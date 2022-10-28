#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QNetworkAccessManager>
#include <ui/MainWindow.h>

int main(int argc, char* argv[])
{
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
