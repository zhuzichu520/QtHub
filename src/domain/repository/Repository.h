#ifndef REPOSITORY_H
#define REPOSITORY_H

#include <QObject>
#include <domain/entity/User.h>
#include <domain/entity/Repositories.h>

class Repository : public QObject
{
    Q_OBJECT
public:
    explicit Repository(QObject* parent = nullptr);

    QString api(const QString& path){
        return "https://api.github.com" + path;
    }

    QString html(const QString& path){
        return "https://github.com" + path;
    }

    virtual QString accessToken(const QString &id,const QString &secret,const QString &code) = 0;

    virtual User user() = 0;

    virtual QList<Repositories> search(const QString& q,const QString& sort,const QString& order,int per_page,int page) = 0;

};

#endif  // REPOSITORY_H
