#ifndef REPOSITORIESVO_H
#define REPOSITORIESVO_H

#include <infrastructure/stdafx.h>
#include <QJsonArray>
#include <QObject>

class RepositoriesVo : public QObject {
    Q_OBJECT
    Q_PROPERTY_AUTO(QString, fullName)
    Q_PROPERTY_AUTO(QString, description)
    Q_PROPERTY_AUTO(QString, language)
    Q_PROPERTY_AUTO(QString, license)
    Q_PROPERTY_AUTO(QString, updatedAt)
    Q_PROPERTY_AUTO(QString, name)
    Q_PROPERTY_AUTO(QString, login)
    Q_PROPERTY_AUTO(int, starNumber)
    Q_PROPERTY_AUTO(QJsonArray,topics)
public:
    explicit RepositoriesVo(QObject* parent = nullptr);
    ~RepositoriesVo();
};

#endif  // REPOSITORIESVO_H
