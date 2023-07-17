#ifndef LOGGER_H
#define LOGGER_H

#include <stdafx.h>
#include <QObject>
#include <QStandardPaths>
#include <QDir>
#include <QDebug>
#include <QDir>
#include <QtGlobal>
#include <glog/logging.h>
#include <infrastructure/config/AppConfig.h>

#define LOGD(data) DLOG(INFO) << data.toLocal8Bit().constData()
#define LOGI(data) LOG(INFO) << data.toLocal8Bit().constData()
#define LOGW(data) LOG(WARNING) << data.toLocal8Bit().constData()
#define LOGE(data) LOG(ERROR) << data.toLocal8Bit().constData()

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
