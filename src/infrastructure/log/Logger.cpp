#include "Logger.h"

Q_GLOBAL_STATIC(Logger, logger)

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

void Logger::initGoogleLog(char* argv[])
{
  google::InitGoogleLogging(argv[0]);
  google::EnableLogCleaner(3);
  google::SetStderrLogging(google::GLOG_INFO);
  auto logDir = AppConfig::instance()->getLogDir();
  QByteArray byteLogDir = logDir.toUtf8();
  FLAGS_log_dir = byteLogDir.data();
  if (AppConfig::instance()->isDebug())
  {
    FLAGS_logtostderr = true;
  }
  else
  {
    FLAGS_logtostderr = false;
  }
  FLAGS_logbufsecs = 0;
  FLAGS_max_log_size = 10;
  FLAGS_stop_logging_if_full_disk = true;
  LOG(INFO) << "===================================================";
  LOG(INFO) << "[Product] 安全即时通讯";
  LOG(INFO) << "[DeviceId] " << QString(QSysInfo::machineUniqueId()).toStdString();
  LOG(INFO) << "[OSVersion] " << QSysInfo::prettyProductName().toStdString();
  LOG(INFO) << "[LogDir] " << logDir.toStdString();
  LOG(INFO) << "===================================================";
  qInstallMessageHandler([](QtMsgType, const QMessageLogContext& context, const QString& message) {
    if (context.file && !message.isEmpty())
    {
      LOG(INFO) << "[" << context.file << ":" << context.line << "] " << message.toStdString();
    }
  });
}
