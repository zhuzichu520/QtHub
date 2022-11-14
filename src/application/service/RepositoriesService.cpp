#include "RepositoriesService.h"


QList<Repositories> RepositoriesService::search(const QString& q,const QString& sort,const QString& order,int per_page,int page){
    return repository()->search(q,sort,order,per_page,page);
}

void RepositoriesService::addSearchHistory(const QString& keyword){
    localRepository()->saveOrUpdateHisotry(keyword);
}

QJsonArray RepositoriesService::getSearchHistory(){
    QJsonArray arr;
    auto data = localRepository()->findAllHistory();
    foreach(auto item,data){
        arr.append(item.name);
    }
    return arr;
}
