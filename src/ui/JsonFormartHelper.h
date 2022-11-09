#ifndef JSONFORMARTHELPER_H
#define JSONFORMARTHELPER_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QFile>
#include <QDesktopServices>
#include <infrastructure/config/AppConfig.h>

class JsonFormartHelper: public QObject
{
    Q_OBJECT
public:
    explicit JsonFormartHelper(QObject* parent = nullptr);

    Q_INVOKABLE QString format(const QString &json);

    Q_INVOKABLE void exportClass(const QString &json);

    Q_INVOKABLE void openDir();

    Q_INVOKABLE void crash(){
        QList<QString> data;
        qDebug()<<data[0];
    }

private:
    void loadCpp(const QString& name,const QJsonObject &object);
};

#endif // JSONFORMARTHELPER_H
