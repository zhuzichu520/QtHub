#include "IssuesService.h"

IssuesService::IssuesService(QObject *parent)
    : BaseService{parent}
{

}

QList<Issues> IssuesService::getIssuesList(const QString& owner,const QString& repo){
    return repository()->getIssuesList(owner,repo);
}
