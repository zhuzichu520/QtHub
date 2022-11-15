#ifndef FEEDBACKCONTROLLER_H
#define FEEDBACKCONTROLLER_H

#include <QObject>
#include <application/vo/FeedbackListVo.h>
#include <application/assembler/Assembler.h>
#include <application/service/IssuesService.h>

#include "BaseController.h"

class FeedbackController : public BaseController
{
    Q_OBJECT
    Q_PROPERTY_AUTO(FeedbackListVo*,feedbackList)
    Q_PROPERTY_AUTO(int,page)
    Q_PROPERTY_AUTO(bool,showLoading)
public:
    explicit FeedbackController(QObject *parent = nullptr);

    IssuesService* issuesService()  {  return QInjection::Inject; }

    Q_INVOKABLE void loadFeedback();

};

#endif // FEEDBACKCONTROLLER_H
