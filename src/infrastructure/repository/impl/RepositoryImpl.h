﻿#ifndef REPOSITORYIMPL_H
#define REPOSITORYIMPL_H

#include <QObject>
#include "domain/repository/Repository.h"

class RepositoryImpl : public Repository
{
    Q_OBJECT

private:
    template <typename T>
    void handleResult(QString result, T& data);

    QString accessToken(const QString &id,const QString &secret,const QString &code) override;

    User user() override;

public:
    explicit RepositoryImpl(QObject* parent = nullptr);

};

#endif  // REPOSITORYIMPL_H
