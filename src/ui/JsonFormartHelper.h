#ifndef JSONFORMARTHELPER_H
#define JSONFORMARTHELPER_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>

class JsonFormartHelper: public QObject
{
    Q_OBJECT
public:
    explicit JsonFormartHelper(QObject* parent = nullptr);

     Q_INVOKABLE QString format(const QString &json);
};

#endif // JSONFORMARTHELPER_H
