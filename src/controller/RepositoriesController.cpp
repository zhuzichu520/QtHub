#include "RepositoriesController.h"

RepositoriesController::RepositoriesController(QObject* parent) : BaseController{parent} {}

RepositoriesController::~RepositoriesController() {}

void RepositoriesController::loadReadMe(const QString& login, const QString& name, bool isDark) {
    if (!originalReadme().isEmpty()) {
        readme(htmlMarkdown(originalReadme(), isDark));
        return;
    }
    showLoading(isDark);
    subscription.add(rxs::create<QString>([this, login, name, isDark](subscriber<QString> subscriber) {
                         auto data = repositoriesService()->getReadme2(login, name);
                         subscriber.on_next(data);
                         subscriber.on_completed();
                     })
                         .subscribe_on(Rx->IO())
                         .observe_on(Rx->mainThread())
                         .subscribe(
                             [this, isDark](const QString& data) {
                                 originalReadme(data);
                                 readme(htmlMarkdown(data, isDark));
                             },
                             [this](const rxu::error_ptr& error) {
                                 handleError(error, [](const BizException& e) {

                                 });
                             }));
}
