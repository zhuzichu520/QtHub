#include "FeedbackController.h"

FeedbackController::FeedbackController(QObject *parent)
    : BaseController{parent}
{
    page(1);
    feedbackList(new FeedbackListVo(this));

    loadFeedback();
}

void FeedbackController::loadFeedback() {
    if(page() == 1){
        showLoading(true);
    }
    subscription.add(
                rxs::create<QList<Issues>>([this](subscriber<QList<Issues>> subscriber) {
                    QList<Issues> data = issuesService()->getIssuesList("zhuzichu520", "QtHub");
                    subscriber.on_next(data);
                    subscriber.on_completed();
                })
            .flat_map([](const QList<Issues>& data) { return rxcpp::observable<>::iterate(data); })
            .subscribe_on(Rx->IO())
            .observe_on(Rx->mainThread())
            .map(
                [this](const Issues& item) { return Assembler::issues2Vo(item, new FeedbackVo(this)); })
            .reduce(QList<FeedbackVo*>(),
                    [this](QList<FeedbackVo*> data, FeedbackVo* vo) {
        data.append(vo);
        return data;
    })
    .subscribe([this](const QList<FeedbackVo*>& data) {
        if (page() == 1) {
            showLoading(false);
            feedbackList()->clear();
        };
        feedbackList()->append(data);
    },
    [this](const rxu::error_ptr& error) {
        showLoading(false);
        handleError(error, [](const BizException& e) {

        });
    }));
}
