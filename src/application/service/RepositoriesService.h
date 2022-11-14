#ifndef REPOSITORIESSERVICE_H
#define REPOSITORIESSERVICE_H

#include <QObject>
#include <domain/entity/Repositories.h>
#include <QJsonArray>
#include "BaseService.h"

using namespace QInjection;

class RepositoriesService : public BaseService
{
    Q_OBJECT
public:
    explicit RepositoriesService(QObject* parent = nullptr){};

    LocalRepository* localRepository(){return QInjection::Inject; }

    Repository* repository(){return QInjection::Inject; }

    QList<Repositories> search(const QString& q,const QString& sort="",const QString& order="",int per_page=30,int page=1);

    QJsonArray getSearchHistory();

    void addSearchHistory(const QString&);
};

#endif // REPOSITORIESSERVICE_H
