#include "SearchController.h"

SearchController::SearchController(QObject* parent) : BaseController{parent} {
    page(1);
    searchListModel(new RepositoriesListVo(this));
    loadHistoryList();
}

void SearchController::loadHistoryList() {
    subscription.add(rxs::create<QJsonArray>([this](subscriber<QJsonArray> subscriber) {
                         auto data = repositoriesService()->getSearchHistory();
                         subscriber.on_next(data);
                         subscriber.on_completed();
                     })
                         .subscribe_on(Rx->IO())
                         .observe_on(Rx->mainThread())
                         .subscribe([this](const QJsonArray& data) { historyList(data); },
                                    [this](const rxu::error_ptr& error) {
                                        handleError(error, [](const BizException& e) {

                                        });
                                    }));
}

void SearchController::addHistory(const QString& keyword) {
    subscription.add(rxs::create<QString>([this, keyword](subscriber<QString> subscriber) {
                         repositoriesService()->addSearchHistory(keyword);
                         subscriber.on_next("");
                         subscriber.on_completed();
                     })
                         .subscribe_on(Rx->IO())
                         .observe_on(Rx->mainThread())
                         .subscribe([this](const QString& data) { loadHistoryList(); },
                                    [this](const rxu::error_ptr& error) {
                                        handleError(error, [](const BizException& e) {

                                        });
                                    }));
}

void SearchController::search(const QString& keyword) {
    releaseSearch();
    addHistory(keyword);
    if(page() == 1){
        showLoading(true);
    }
    subscriptionSearch =
        rxs::create<QList<Repositories>>([this, keyword](subscriber<QList<Repositories>> subscriber) {
            QList<Repositories> data = repositoriesService()->search(keyword, "", "", 30, page());
            subscriber.on_next(data);
            subscriber.on_completed();
        })
            .flat_map([](const QList<Repositories>& data) { return rxcpp::observable<>::iterate(data); })
            .subscribe_on(Rx->IO())
            .observe_on(Rx->mainThread())
            .map(
                [this](const Repositories& item) { return Assembler::repositories2Vo(item, new RepositoriesVo(this)); })
            .reduce(QList<RepositoriesVo*>(),
                    [this](QList<RepositoriesVo*> data, RepositoriesVo* vo) {
                        data.append(vo);
                        return data;
                    })
            .subscribe(
                [this](const QList<RepositoriesVo*>& data) {
                    if (page() == 1) {
                        showLoading(false);
                        searchListModel()->clear();
                    };
                    searchListModel()->append(data);
                },
                [this](const rxu::error_ptr& error) {
                    showLoading(false);
                    handleError(error, [](const BizException& e) {

                    });
                });
}

void SearchController::releaseSearch() {
    if (subscriptionSearch.is_subscribed()) {
        subscriptionSearch.unsubscribe();
    }
}
