#ifndef SEARCHCONTROLLER_H
#define SEARCHCONTROLLER_H

#include <QObject>
#include <application/service/RepositoriesService.h>
#include "BaseController.h"

class SearchController : public BaseController
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QJsonArray,historyList)
public:
    explicit SearchController(QObject *parent = nullptr);

    RepositoriesService* repositoriesService()  { return QInjection::Inject;}

    Q_INVOKABLE void search(const QString&);

    Q_INVOKABLE void addHistory(const QString&);

    Q_INVOKABLE void loadHistoryList();

};

#endif // SEARCHCONTROLLER_H
