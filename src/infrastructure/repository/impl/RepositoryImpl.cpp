#include "RepositoryImpl.h"

#include <infrastructure/nlohmann/json.hpp>
#include "domain/exception/BizException.h"
#include "infrastructure/converter/Converter.h"
#include "infrastructure/tool/CommonTool.h"
#include "infrastructure/tool/RxHttp.h"
#include "infrastructure/dto/UserDto.h"
#include "infrastructure/dto/TokenDto.h"

using namespace AeaQt;
using namespace nlohmann;

RepositoryImpl::RepositoryImpl(QObject* parent) : Repository{ parent }
{

}

template <typename T>
void RepositoryImpl::handleResult(QString result, T& data,QString type)
{
    if (!CommonTool::instance()->isJson(result))
    {
        throw BizException(-1, "Json解析失败");
    }else{
        CommonTool::instance()->jsonNonNull(result);
        const QJsonObject& obj = CommonTool::instance()->json2Object(result.toStdString());
    }
    json j = json::parse(result.toStdString());
    if(!type.isEmpty()){
       j = j["data"][type.toStdString()];
    }
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

User RepositoryImpl::user(){
    UserDto dto;
    QString query = R"(query {
  viewer {
    login
    bio
    avatarUrl
    name
    status {
      message
      emojiHTML
    }
  }
})";
    const QVariantMap& data = {
        {"query",query},
    };
    handleResult(RxHttp::postJson("https://api.github.com/graphql",data),dto,"viewer");
    return Converter::dto2User(dto);
}
