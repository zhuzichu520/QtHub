#ifndef LOGGER_H
#define LOGGER_H

#include <infrastructure/stdafx.h>
#include <QObject>
#include <QStandardPaths>
#include <QDir>
#include <QDebug>
#include <QDir>
#include <QtGlobal>
#include <fstream>
#include <glog/logging.h>
#include <infrastructure/config/AppConfig.h>

#define LOGD(data) qDebug() << data
#define LOGI(data) LOG(INFO) << data
#define LOGW(data) LOG(WARNING) << data
#define LOGE(data) LOG(ERROR) << data

class Logger : public QObject
{
  Q_OBJECT
public:
  explicit Logger(QObject* parent = nullptr);
  ~Logger();

  static Logger* instance();

  void initGoogleLog(char* argv[]);
};

#endif  // LOGGER_H
