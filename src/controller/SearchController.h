#ifndef SEARCHCONTROLLER_H
#define SEARCHCONTROLLER_H

#include <QObject>
#include <application/service/RepositoriesService.h>
#include <application/vo/RepositoriesListVo.h>
#include <application/assembler/Assembler.h>
#include <infrastructure/tool/MainThread.h>
#include "BaseController.h"
#include <QtConcurrent>

class SearchController : public BaseController
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QJsonArray,historyList)
    Q_PROPERTY_AUTO(RepositoriesListVo*,searchListModel)
    Q_PROPERTY_AUTO(bool,showLoading)
    Q_PROPERTY_AUTO(int,totalCount)
public:
    explicit SearchController(QObject *parent = nullptr);

    RepositoriesService* repositoriesService()  { return QInjection::Inject;}

    Q_INVOKABLE void search(const QString&,int page,int pageCount);

    Q_INVOKABLE void addHistory(const QString&);

    Q_INVOKABLE void loadHistoryList();

    Q_INVOKABLE void releaseSearch();

private:

    rxcpp::subscription subscriptionSearch;

};

#endif // SEARCHCONTROLLER_H
