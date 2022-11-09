#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QNetworkAccessManager>
#include <ui/MainWindow.h>

#include <Windows.h>
#include <DbgHelp.h>
#include <qt_windows.h>
#include <QMessageBox>

#pragma comment(lib, "user32.lib")
#pragma comment(lib, "dbghelp.lib")


void GetExceptionDescription(DWORD errCode,QString& err)
{
#if 0

#else
//    errCode = 0xc0000005;
    LPTSTR lpMsgBuf = NULL;
    HMODULE Hand = LoadLibrary(TEXT("ntdll.dll"));
    FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
                  FORMAT_MESSAGE_IGNORE_INSERTS/*FORMAT_MESSAGE_FROM_SYSTEM*/|
                  FORMAT_MESSAGE_FROM_HMODULE,
                  Hand,
                  errCode,
                  MAKELANGID(LANG_NEUTRAL,SUBLANG_DEFAULT),
                  (LPTSTR)&lpMsgBuf,
                  0,NULL);
    err = QString::fromWCharArray( lpMsgBuf );
    qDebug()<<err;
    LocalFree(lpMsgBuf);
#endif
}

LONG ApplicationCrashHandler(EXCEPTION_POINTERS *pException){//程式异常捕获
    /*
      ***保存数据代码***
    */
    //创建 Dump 文件
    qDebug()<<"触发异常!";
    QString createPath = QCoreApplication::applicationDirPath()+"/Dumps";
    QDir dir;
    dir.mkpath(createPath);
    createPath=QString("%1/dump_%2.dmp").arg(createPath).arg(QDateTime::currentDateTime().toString("yyyy_MM_dd_hh_mm_ss_zzz"));
    std::wstring wlpstr = createPath.toStdWString();
    LPCWSTR lpcwStr = wlpstr.c_str();

    HANDLE hDumpFile = CreateFile(lpcwStr,
                                  GENERIC_WRITE,
                                  0,
                                  NULL,
                                  CREATE_ALWAYS,
                                  FILE_ATTRIBUTE_NORMAL,
                                  NULL);
    if( hDumpFile != INVALID_HANDLE_VALUE){
        //Dump信息
        MINIDUMP_EXCEPTION_INFORMATION dumpInfo;
        dumpInfo.ExceptionPointers = pException;
        dumpInfo.ThreadId = GetCurrentThreadId();
        dumpInfo.ClientPointers = FALSE;
        //写入Dump文件内容
        MiniDumpWriteDump(GetCurrentProcess(), GetCurrentProcessId(), hDumpFile, MiniDumpNormal, &dumpInfo, NULL, NULL);
    }
    //这里弹出一个错误对话框并退出程序
    EXCEPTION_RECORD* record = pException->ExceptionRecord;
    QString errCode(QString::number(record->ExceptionCode,16)),errAdr(QString::number((UINT)((UINT_PTR)record->ExceptionAddress),16));;
    QString errstr;
    GetExceptionDescription(record->ExceptionCode,errstr);
    if(record->NumberParameters>0){
        if(record->ExceptionInformation[0]==0){
            errstr+="\r\n访问冲突,线程试图读取不可访问的数据";
        }else if(record->ExceptionInformation[0]==1){
            errstr+="\r\n访问冲突,线程尝试写入不可访问的地址";
        }
    }
    QMessageBox::critical(NULL,"程式崩溃","<FONT size=4><div><b>程式崩溃</b><br/></div>"+
        QString("<div>错误代码：%1</div><div>错误地址：%2</div><div>具体原因：%3</div></FONT>").arg(errCode).arg(errAdr).arg(errstr),
        QMessageBox::Ok);
    return EXCEPTION_EXECUTE_HANDLER;
}


int main(int argc, char* argv[])
{
  QApplication app(argc, argv);
  SetUnhandledExceptionFilter((LPTOP_LEVEL_EXCEPTION_FILTER)ApplicationCrashHandler);//注冊异常捕获函数
  QSharedMemory singleton(app.applicationName());
   if(!singleton.create(1))  {    //已经存在的
       QMessageBox::critical(nullptr, QObject::tr("错误"),
                             QObject::tr("程序已经在运行，请先关闭！"));
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
  if (exec == 931)
  {
    QProcess::startDetached(qApp->applicationFilePath(), QStringList());
  }
  return exec;
}
