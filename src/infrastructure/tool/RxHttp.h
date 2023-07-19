#ifndef RXHTTP_H
#define RXHTTP_H

#include <QObject>
#include <infrastructure/http/HttpClient.h>
#include "domain/exception/BizException.h"
#include "infrastructure/helper/CommonHelper.h"
#include "infrastructure/helper/SettingsHelper.h"
#include "infrastructure/log/Logger.h"

using namespace AeaQt;

class RxHttp {
  public:
    static QString get(const QString& url, const QVariantMap& data = {}) {
        return handle(QNetworkAccessManager::GetOperation, url, data);
    }
    static QString post(const QString& url, const QVariantMap& data = {}) {
        return handle(QNetworkAccessManager::PostOperation, url, data);
    }
    static QString postJson(const QString& url, const QVariantMap& data = {}) {
        return handle(QNetworkAccessManager::PostOperation, url, data, true);
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
                          const QVariantMap& data, const bool isJson = false) {
        LOGI(QString::fromStdString("【Http】url->%1").arg(url));
        LOGI(QString::fromStdString("【Http】param->%1").arg(QJsonDocument::fromVariant(QVariant(data)).toJson()));
        HttpClient client;
        QString result;
        QNetworkReply* reply = nullptr;
        if (operation == QNetworkAccessManager::GetOperation) {
            reply = client.get(url).headers(headers()).queryParams(data).timeout(timeout()).block().exec()->reply();
        } else if (operation == QNetworkAccessManager::PostOperation) {
            if (isJson) {
                QJsonObject obj = QJsonDocument::fromJson(QJsonDocument::fromVariant(QVariant(data)).toJson()).object();
                reply = client.post(url).headers(headers()).bodyWithJson(obj).timeout(timeout()).block().exec()->reply();
            } else {
                reply = client.post(url).headers(headers()).body(data).timeout(timeout()).block().exec()->reply();
            }
        } else {
            throw BizException("QNetworkAccessManager::Operation 没有定义");
        }
        QByteArray bytes = reply->readAll();
        result = QString::fromUtf8(bytes);
        if (reply->error() != QNetworkReply::NoError) {
            int httpStatus = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
            LOGE(QString::fromStdString("【Http】url->%1，httpcode->%2，param->%3，result->%4")
                     .arg(url,
                         QString::number(httpStatus),
                         CommonHelper::getInstance()->object2Json(QJsonObject(QJsonDocument::fromJson(QJsonDocument::fromVariant(QVariant(data)).toJson()).object()))
                         ,result)
                 );
            throw BizException(QString::fromStdString("网络出现异常，错误码：%1").arg(httpStatus),httpStatus);
        }
        return result;
    }
    static int timeout() { return 10; };
    static QMap<QString, QVariant> headers() {
        QMap<QString, QVariant> data;
        data.insert("Accept", "application/json");
        QString token = SettingsHelper::getInstance()->getToken();
        if (!token.isEmpty()) {
            data.insert("Authorization", "token " + token);
        }
        return data;
    };
};

#endif  // RXHTTP_H
