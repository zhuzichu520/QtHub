#ifndef COMMONTOOL_H
#define COMMONTOOL_H

#include <QObject>
#include <QGlobalStatic>
#include <QJsonDocument>
#include <QJsonObject>
#include <QCryptographicHash>

class CommonTool : public QObject
{
    Q_OBJECT

public:
    static CommonTool* instance();
    explicit CommonTool(QObject* parent = nullptr);

    Q_INVOKABLE bool isJson(const QString& val);

    Q_INVOKABLE QString toBase64(const QString&);
    Q_INVOKABLE QString fromBase64(const QString&);
    Q_INVOKABLE QString md5(const QString&);
    Q_INVOKABLE QString sha1(const QString&);
    Q_INVOKABLE QString sha224(const QString&);
    Q_INVOKABLE QString sha256(const QString&);
    Q_INVOKABLE QString sha384(const QString&);
    Q_INVOKABLE QString sha512(const QString&);
    Q_INVOKABLE qint64 currentTimeMillis();

    Q_INVOKABLE QString maxString(const QString&,int max);

    Q_INVOKABLE QJsonObject json2Object(const std::string&);
    Q_INVOKABLE QJsonObject json2Object(const QString&);
    Q_INVOKABLE QString object2Json(const QJsonObject&);

    Q_INVOKABLE void jsonNonNull(QString& val);
};

#endif  // COMMONTOOL_H
