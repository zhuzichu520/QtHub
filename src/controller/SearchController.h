#ifndef SEARCHCONTROLLER_H
#define SEARCHCONTROLLER_H

#include <QObject>
#include <application/service/RepositoriesService.h>
#include <application/vo/RepositoriesListVo.h>
#include <application/assembler/Assembler.h>
#include "BaseController.h"

class SearchController : public BaseController
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QJsonArray,historyList)
    Q_PROPERTY_AUTO(int,page)
    Q_PROPERTY_AUTO(RepositoriesListVo*,searchListModel)
    Q_PROPERTY_AUTO(bool,showLoading)
public:
    explicit SearchController(QObject *parent = nullptr);

    RepositoriesService* repositoriesService()  { return QInjection::Inject;}

    Q_INVOKABLE void search(const QString&);

    Q_INVOKABLE void addHistory(const QString&);

    Q_INVOKABLE void loadHistoryList();

    Q_INVOKABLE void releaseSearch();

private:

    rxcpp::subscription subscriptionSearch;

};

#endif // SEARCHCONTROLLER_H
