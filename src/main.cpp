#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QNetworkAccessManager>
#include <ui/MainWindow.h>

int main(int argc, char* argv[])
{
  QGuiApplication app(argc, argv);

  //    QHotkey hotkey(QKeySequence("Ctrl+Alt+Q"), true, &app);
  //    QObject::connect(&hotkey, &QHotkey::activated, qApp, [&](){
  //        qApp->quit();
  //    });
  MainWindow window(argv);
  QGuiApplication::setOrganizationName("HIWITECH.COM");
  QGuiApplication::setApplicationName("AvicIM");
  window.show();

  const int exec = QCoreApplication::exec();
  if (exec == 931)
  {
    QProcess::startDetached(qApp->applicationFilePath(), QStringList());
  }
  return exec;
}
