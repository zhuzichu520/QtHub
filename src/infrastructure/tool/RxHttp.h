#ifndef RXHTTP_H
#define RXHTTP_H

#include <domain/exception/BizException.h>
#include <infrastructure/helper/SettingsHelper.h>
#include <infrastructure/helper/UserHelper.h>
#include <infrastructure/http/HttpClient.h>
#include <infrastructure/log/Logger.h>
#include <infrastructure/tool/MainThread.h>

#include <QObject>

using namespace AeaQt;

class RxHttp {
  public:
    static QString get(const QString& url, const QVariantMap& data = {}) {
        return handle(QNetworkAccessManager::GetOperation, url, data);
    }
    static QString post(const QString& url, const QVariantMap& data = {}) {
        return handle(QNetworkAccessManager::PostOperation, url, data);
    }

    static void download(const QString& url, const QString& filePath, const std::function<void(QByteArray)>& onSuccess,
                         const std::function<void(qint64, qint64)>& onDownloadProgress,
                         const std::function<void(QByteArray)>& onFailed) {
        HttpClient::instance()
            ->get(url)
            .download(filePath)
            .onSuccess(onSuccess)
            .onDownloadProgress(onDownloadProgress)
            .onFailed(onFailed)
            .exec();
    }

  private:
    static QString handle(const QNetworkAccessManager::Operation& operation, const QString& url,
                          const QVariantMap& data) {
        qDebug() << "【HTTP】请求地址->" << url;
        qDebug() << "【HTTP】请求参数->" << data;
        HttpClient client;
        QString result;
        QNetworkReply::NetworkError error;
        QNetworkReply* reply = nullptr;
        if (operation == QNetworkAccessManager::GetOperation) {
            reply = client.get(url).headers(headers()).queryParams(data).timeout(timeout()).block().exec()->reply();
        } else if (operation == QNetworkAccessManager::PostOperation) {
            reply = client.post(url).headers(headers()).body(data).timeout(timeout()).block().exec()->reply();
        } else {
            throw BizException("QNetworkAccessManager::Operation 没有定义");
        }
        error = reply->error();
        QByteArray bytes = reply->readAll();
        result = QString::fromUtf8(bytes);
        if (error != QNetworkReply::NoError) {
            LOGI(QString::fromStdString("【网络错误】code->%1").arg(error).toStdString());
            throw BizException(QString::fromStdString("网络出现异常，错误码：%1").arg(error));
        }
        return result;
    }
    static int timeout() { return 10; };
    static QMap<QString, QVariant> headers() {
        QMap<QString, QVariant> data;
        data.insert("Accept", "application/json");
        QString token = SettingsHelper::instance()->getToken();
        if (!token.isEmpty()) {
            data.insert("Authorization", "token " + token);
        }
        return data;
    };
};

#endif  // RXHTTP_H
