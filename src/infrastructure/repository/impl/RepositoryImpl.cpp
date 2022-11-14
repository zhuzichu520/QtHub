#include "RepositoryImpl.h"

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
       const QJsonObject& obj = CommonTool::instance()->string2JsonObject(result.toStdString());
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

QList<Repositories> RepositoryImpl::search(const QString& q,const QString& sort,const QString& order,int per_page,int page){
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
    return list;
}

User RepositoryImpl::user(){
    UserDto dto;
    handleResult(RxHttp::get(api("/user")),dto);
    return Converter::dto2User(dto);
}
