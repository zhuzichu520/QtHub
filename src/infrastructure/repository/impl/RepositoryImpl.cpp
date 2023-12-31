﻿#include "RepositoryImpl.h"

RepositoryImpl::RepositoryImpl(QObject* parent) : Repository{ parent }
{

}

template <typename T>
void RepositoryImpl::handleResult(QString result, T& data)
{

    if (!CommonTool::instance()->isJson(result))
    {
        LOGD(result);
        throw BizException(-1, "服务器异常");
    }else{
        CommonTool::instance()->jsonNonNull(result);
        const QJsonObject& obj = CommonTool::instance()->json2Object(result.toStdString());
        LOGD(obj);
    }
    json j = json::parse(result.toStdString());
    data = j.get<T>();
}

QString RepositoryImpl::accessToken(const QString &id,const QString &secret,const QString &code){
    const QVariantMap& data = {
        {"client_id",id},
        {"client_secret",secret},
        {"code",code}
    };
    TokenDto dto;
    handleResult(RxHttp::get(html("/login/oauth/access_token"),data),dto);
    return QString::fromStdString(dto.access_token);
}

Pager<QList<Repositories>> RepositoryImpl::search(const QString& q,const QString& sort,const QString& order,int per_page,int page){
    const QVariantMap& data = {
        {"q",q},
        {"sort",sort},
        {"order",order},
        {"per_page",per_page},
        {"page",page}
    };
    SearchRepositoriesDto dto;
    handleResult(RxHttp::get(api("/search/repositories"),data),dto);
    QList<Repositories> list;
    foreach (auto item, dto.items) {
        list.append(Converter::dto2Repositories(item));
    }
    Pager<QList<Repositories>> pager;
    pager.totalCount = dto.total_count;
    pager.data = list;
    return pager;
}

QList<Issues> RepositoryImpl::getIssuesList(const QString& owner,const QString& repo){
    std::vector<IssuesDto> dto;
    handleResult(RxHttp::get(api(QString::fromStdString("/repos/%1/%2/issues").arg(owner,repo)),{}),dto);
    QList<Issues> data;
    foreach (auto item, dto) {
        data.append(Converter::dto2Issues(item));
    }
    return data;
}

User RepositoryImpl::user(){
    UserDto dto;
    handleResult(RxHttp::get(api("/user")),dto);
    return Converter::dto2User(dto);
}

QString RepositoryImpl::getReadme(const QString& login,const QString& name){
    return RxHttp::get(html(QString::fromStdString("/%1/%2").arg(login,name)));
}

QString RepositoryImpl::getReadme2(const QString& login,const QString& name){
    ReadmeDto dto;
    handleResult(RxHttp::get(api(QString::fromStdString("/repos/%1/%2/readme").arg(login,name))),dto);
    QString readme = CommonTool::instance()->fromBase64(QString::fromStdString(dto.content));
    return readme2Html(readme);
}

QString RepositoryImpl::readme2Html(const QString& text){
    const QVariantMap& data = {
        {"text",text}
    };
    QString html = RxHttp::postJson(api(QString::fromStdString("/markdown")),data);
    return html;
}

QString RepositoryImpl::getFileTree(const QString& owner,const QString& repo,const QString& tree_sha,int recursive){
    const QVariantMap& data = {
        {"recursive",recursive}
    };
    return RxHttp::get(api(QString::fromStdString("/repos/%1/%2/git/trees/%3").arg(owner,repo,tree_sha)),data);
}
