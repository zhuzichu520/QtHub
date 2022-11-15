#ifndef ISSUESSERVICE_H
#define ISSUESSERVICE_H

#include <QObject>
#include <domain/entity/Issues.h>
#include "BaseService.h"

using namespace QInjection;
class IssuesService : public BaseService
{
    Q_OBJECT
public:
    explicit IssuesService(QObject *parent = nullptr);

    Repository* repository(){return QInjection::Inject; }

    QList<Issues> getIssuesList(const QString& owner,const QString& repo);

};

#endif // ISSUESSERVICE_H
