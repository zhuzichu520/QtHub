#ifndef MYNETWORKACCESSMANAGERFACTORY_H
#define MYNETWORKACCESSMANAGERFACTORY_H

#include <QNetworkAccessManager>
#include <QNetworkDiskCache>
#include <QStandardPaths>
#include <QQmlNetworkAccessManagerFactory>
#include <infrastructure/config/AppConfig.h>

class MyNetworkAccessManagerFactory : public QQmlNetworkAccessManagerFactory
{
public:
  virtual QNetworkAccessManager* create(QObject* parent);
};

#endif  // MYNETWORKACCESSMANAGERFACTORY_H
