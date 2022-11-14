#include "SearchController.h"

SearchController::SearchController(QObject *parent)
    : BaseController{parent}
{
    loadHistoryList();
}

void SearchController::loadHistoryList(){
    subscription.add(rxs::create<QJsonArray>([this](subscriber<QJsonArray> subscriber)
                     {
                         auto data = repositoriesService()->getSearchHistory();
                         subscriber.on_next(data);
                         subscriber.on_completed();
                     }).subscribe_on(Rx->IO()).observe_on(Rx->mainThread()).subscribe([this](const QJsonArray &data){
        historyList(data);
    },
    [this](const rxu::error_ptr& error){
        handleError(error,[](const BizException& e){

        });
    }));
}

void SearchController::addHistory(const QString& keyword){
    subscription.add(rxs::create<QString>([this,keyword](subscriber<QString> subscriber)
    {
        repositoriesService()->addSearchHistory(keyword);
        subscriber.on_next("");
        subscriber.on_completed();
    }).subscribe_on(Rx->IO()).observe_on(Rx->mainThread()).subscribe([this](const QString &data){
        loadHistoryList();
    },
    [this](const rxu::error_ptr& error){
        handleError(error,[](const BizException& e){

        });
    }));
}

void SearchController::search(const QString& keyword){
    addHistory(keyword);
    subscription.add(rxs::create<QString>([this,keyword](subscriber<QString> subscriber)
    {
        QList<Repositories> data = repositoriesService()->search(keyword);
        subscriber.on_next(QString::fromStdString("数据长度：%1").arg(data.size()));
        subscriber.on_completed();
    }).subscribe_on(Rx->IO()).observe_on(Rx->mainThread()).subscribe([](const QString &data){

    },
    [this](const rxu::error_ptr& error){
        handleError(error,[](const BizException& e){

        });
    }));
}
