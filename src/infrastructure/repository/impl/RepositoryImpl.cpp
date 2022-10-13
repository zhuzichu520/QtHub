#include "RepositoryImpl.h"

RepositoryImpl::RepositoryImpl(QObject* parent) : Repository{ parent }
{
}

template <typename T>
void RepositoryImpl::handleResult(const QString &result, T& data)
{
  LOGD(result);
  if (!CommonTool::instance()->isJson(result))
  {
    throw BizException(-1, "服务器异常");
  }
  json j = json::parse(result.toStdString());
//  ResultDto resultDto = j.get<ResultDto>();
//  if (!resultDto.success)
//  {
//    throw BizException(atoi(resultDto.errCode.c_str()), QString::fromStdString(resultDto.errDesc));
//  }
//  data = j["result"].get<T>();
}
