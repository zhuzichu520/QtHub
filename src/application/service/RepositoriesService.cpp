#include "RepositoriesService.h"


Pager<QList<Repositories>> RepositoriesService::search(const QString& q,const QString& sort,const QString& order,int per_page,int page){
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

QString RepositoriesService::getReadme(const QString& login,const QString& name){
    QString html = repository()->getReadme(login,name);
    QRegularExpression rx(QString::fromStdString(R"(<readme-toc>([\s\S]*)</readme-toc>)"));
    QRegularExpressionMatch match = rx.match(html);
    if (match.hasMatch())
    {
        QString readme = match.captured(1);
        return readme;
    }
    return "该仓库还没有README.md文件";
}

QString RepositoriesService::getReadme2(const QString& login,const QString& name){
    return repository()->getReadme2(login,name);
}

QJsonObject RepositoriesService::getFileTree(const QString& owner,const QString& repo){
    return CommonTool::instance()->json2Object(repository()->getFileTree(owner,repo,"master",1));
}
