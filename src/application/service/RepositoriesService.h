#ifndef REPOSITORIESSERVICE_H
#define REPOSITORIESSERVICE_H

#include <QObject>
#include <domain/entity/Repositories.h>
#include <domain/entity/Pager.h>
#include <infrastructure/tool/CommonTool.h>
#include <QJsonArray>
#include <QJsonObject>
#include "BaseService.h"

using namespace QInjection;

class RepositoriesService : public BaseService
{
    Q_OBJECT
public:
    explicit RepositoriesService(QObject* parent = nullptr){};

    LocalRepository* localRepository(){return QInjection::Inject; }

    Repository* repository(){return QInjection::Inject; }

    Pager<QList<Repositories>> search(const QString& q,const QString& sort="",const QString& order="",int per_page=30,int page=1);

    QJsonArray getSearchHistory();

    void addSearchHistory(const QString&);

    QString getReadme(const QString&,const QString&);

    QString getReadme2(const QString&,const QString&);

    QJsonObject getFileTree(const QString&,const QString&);

};

#endif // REPOSITORIESSERVICE_H
