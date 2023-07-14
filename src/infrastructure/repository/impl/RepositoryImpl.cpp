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
void RepositoryImpl::handleResult(QString result, T& data)
{
    if (!CommonTool::instance()->isJson(result))
    {
        throw BizException(-1, "服务器异常");
    }else{
        CommonTool::instance()->jsonNonNull(result);
        const QJsonObject& obj = CommonTool::instance()->json2Object(result.toStdString());
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

User RepositoryImpl::user(){
    UserDto dto;
    handleResult(RxHttp::get(api("/user")),dto);
    return Converter::dto2User(dto);
}
