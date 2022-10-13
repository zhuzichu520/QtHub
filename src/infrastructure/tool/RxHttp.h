#ifndef RXHTTP_H
#define RXHTTP_H

#include <QObject>
#include <infrastructure/http/HttpClient.h>
#include <infrastructure/helper/UserHelper.h>
#include <infrastructure/tool/MainThread.h>
#include <infrastructure/tool/CountDownLatch.h>
#include <domain/exception/BizException.h>

using namespace AeaQt;

class RxHttp
{

public:
  static QString get(const QString& url,const QVariantMap& data = {})
  {
    return handle(QNetworkAccessManager::GetOperation,url,data);
  }
  static QString post(const QString& url,const QVariantMap& data = {})
  {
    return handle(QNetworkAccessManager::PostOperation,url,data);
  }

  static void download(
      const QString& url,
      const QString& filePath,
      const std::function<void(QByteArray)> &onSuccess,
      const std::function<void(qint64, qint64)> &onDownloadProgress,
      const std::function<void(QByteArray)> &onFailed){
    MainThread::handle([url,filePath,onSuccess,onDownloadProgress,onFailed]() mutable{
      HttpClient::instance()->get(url)
          .download(filePath)
          .onSuccess(onSuccess)
          .onDownloadProgress(onDownloadProgress)
          .onFailed(onFailed)
          .exec();
    });
  }

private:

  static QString handle(const QNetworkAccessManager::Operation &operation,const QString& url,const QVariantMap& data){
    QString result;
    CountDownLatch latch(1);
    QNetworkReply::NetworkError error;
    MainThread::handle([&operation,&error,&latch,&result,url,data]() mutable{
      QNetworkReply* reply = nullptr;
      if(operation == QNetworkAccessManager::GetOperation){
        reply = HttpClient::instance()->get(url).headers(headers()).body(data).timeout(timeout()).block().exec()->reply();
      }else if(operation == QNetworkAccessManager::PostOperation){
        reply = HttpClient::instance()->post(url).headers(headers()).body(data).timeout(timeout()).block().exec()->reply();
      }else{
        throw BizException("QNetworkAccessManager::Operation 没有定义");
      }
      error = reply->error();
      QByteArray bytes = reply->readAll();
      result = QString::fromUtf8(bytes);
      latch.countDown();
    });
    latch.await();
    if(error != QNetworkReply::NoError){
      throw BizException(QString::fromStdString("网络出现异常，错误码：%1").arg(error));
    }
    return result;
  }
  static int timeout(){
    return 10;
  };
  static QMap<QString, QVariant> headers(){
    return {{"osType","3"},{"version","2.6.0"},{"token",""}};
  };
};

#endif  // RXHTTP_H
