#include "Logger.h"

Q_GLOBAL_STATIC(Logger, logger)

#include <Windows.h>
#include <DbgHelp.h>
#include <qt_windows.h>
#include <QCoreApplication>

Logger* Logger::instance()
{
    return logger();
}

Logger::Logger(QObject* parent) : QObject{ parent }
{
}

Logger::~Logger()
{
    google::ShutdownGoogleLogging();
}

void handleDumpInfo(const char* data, size_t size)
{
    std::string str = std::string(data, size);
    auto appDataDir = AppConfig::instance()->getLogDir();
    std::ofstream fs(appDataDir.toStdString() + "/glog_dump.log", std::ios::app);
    fs << str;
    fs.close();
    LOG(ERROR) << str;
}

void Logger::initGoogleLog(char* argv[])
{
    google::InitGoogleLogging(argv[0]);
    google::InstallFailureSignalHandler();
    google::InstallFailureWriter(&handleDumpInfo);
    google::EnableLogCleaner(3);
    google::SetStderrLogging(google::GLOG_INFO);
    auto logDir = AppConfig::instance()->getLogDir();
    QByteArray byteLogDir = logDir.toUtf8();
    FLAGS_log_dir = byteLogDir.data();
#ifdef QT_NO_DEBUG
    FLAGS_logtostderr = false;
#else
    FLAGS_logtostderr = true;
#endif
    FLAGS_logbufsecs = 0;
    FLAGS_max_log_size = 10;
    FLAGS_stop_logging_if_full_disk = true;
    LOG(INFO) << "===================================================";
    LOG(INFO) << "[Product] QtHub";
    LOG(INFO) << "[DeviceId] " << QString(QSysInfo::machineUniqueId()).toStdString();
    LOG(INFO) << "[OSVersion] " << QSysInfo::prettyProductName().toStdString();
    LOG(INFO) << "[LogDir] " << logDir.toStdString();
    LOG(INFO) << "===================================================";
    qInstallMessageHandler([](QtMsgType, const QMessageLogContext&, const QString& message) {
        QByteArray localMsg = message.toLocal8Bit();
        LOG(INFO) << localMsg.toStdString();
    });
}
