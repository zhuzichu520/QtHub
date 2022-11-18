#include "SearchController.h"

SearchController::SearchController(QObject* parent) : BaseController{parent} {
    searchListModel(new RepositoriesListVo(this));
    totalCount(1);
    loadHistoryList();
}

SearchController::~SearchController(){
    releaseSearch();
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

void SearchController::search(const QString& keyword, int page, int pageCount) {
    releaseSearch();
    showLoading(true);
    subscriptionSearch = rxs::create<Pager<QList<Repositories>>>(
                             [this, keyword, page, pageCount](subscriber<Pager<QList<Repositories>>> subscriber) {
                                 Pager<QList<Repositories>> data =
                                     repositoriesService()->search(keyword, "", "", pageCount, page);
                                 subscriber.on_next(data);
                                 subscriber.on_completed();
                             })
                             .subscribe_on(Rx->IO())
                             .observe_on(Rx->mainThread())
                             .subscribe(
                                 [this,page](const Pager<QList<Repositories>>& pager) {
                                     QList<RepositoriesVo*> data;
                                     foreach (auto item, pager.data) {
                                         data.append(Assembler::repositories2Vo(item, new RepositoriesVo(this)));
                                     }
                                     totalCount(pager.totalCount);
                                     searchListModel(new RepositoriesListVo(this));
                                     searchListModel()->append(data);
                                     showLoading(false);
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
