﻿#ifndef REPOSITORY_H
#define REPOSITORY_H

#include <QObject>
#include <domain/entity/User.h>
#include <domain/entity/Issues.h>
#include <domain/entity/Repositories.h>
#include <domain/entity/Pager.h>

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

    virtual Pager<QList<Repositories>> search(const QString& q,const QString& sort,const QString& order,int per_page,int page) = 0;

    virtual QList<Issues> getIssuesList(const QString& owner,const QString& repo) = 0;

    virtual QString getReadme(const QString& login,const QString& name) = 0;

    virtual QString getReadme2(const QString& login,const QString& name) = 0;

    virtual QString readme2Html(const QString& text) = 0;

    virtual QString getFileTree(const QString& owner,const QString& repo,const QString& tree_sha,int recursive) = 0;
};

#endif  // REPOSITORY_H
