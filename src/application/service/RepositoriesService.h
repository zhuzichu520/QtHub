#ifndef REPOSITORIESSERVICE_H
#define REPOSITORIESSERVICE_H

#include <QObject>
#include <domain/entity/Repositories.h>
#include "BaseService.h"

using namespace QInjection;

class RepositoriesService : public BaseService
{
    Q_OBJECT
public:
    explicit RepositoriesService(QObject* parent = nullptr, Repository* repository = QInjection::Inject)
        : repository(repository){};

    QList<Repositories> search(const QString& q,const QString& sort="",const QString& order="",int per_page=30,int page=1);

private:
    Repository* repository;

};

#endif // REPOSITORIESSERVICE_H
