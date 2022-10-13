#include "MyNetworkAccessManagerFactory.h"

QNetworkAccessManager* MyNetworkAccessManagerFactory::create(QObject* parent)
{
  QNetworkAccessManager* nam = new QNetworkAccessManager(parent);
  QNetworkDiskCache* diskCache = new QNetworkDiskCache(nam);

  QString cachePath = AppConfig::instance()->getImageCacheDir();

  qDebug() << "cache path:" << cachePath;

  diskCache->setCacheDirectory(cachePath);
  diskCache->setMaximumCacheSize(100 * 1024 * 1024);  // 这里设置的缓存大小为 100 MB

  nam->setCache(diskCache);

  return nam;
}
