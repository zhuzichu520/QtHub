#ifndef LOCALREPOSITORYIMPL_H
#define LOCALREPOSITORYIMPL_H

#include <QObject>
#include <domain/repository/LocalRepository.h>
#include <infrastructure/db/DB.h>
#include <infrastructure/log/Logger.h>
#include <infrastructure/tool/CommonTool.h>
#include <infrastructure/converter/Converter.h>
#include <QtNut/Query>

class LocalRepositoryImpl : public LocalRepository
{
    Q_OBJECT
public:
    explicit LocalRepositoryImpl(QObject *parent = nullptr);

    void saveOrUpdateHisotry(const QString &name) override;

    QList<History> findAllHistory() override;

private:
    DB db;
};

#endif // LOCALREPOSITORYIMPL_H
