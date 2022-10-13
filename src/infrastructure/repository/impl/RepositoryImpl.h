#ifndef REPOSITORYIMPL_H
#define REPOSITORYIMPL_H

#include <QObject>
#include <domain/repository/Repository.h>
#include <domain/exception/BizException.h>
#include <infrastructure/log/Logger.h>
#include <infrastructure/http/HttpClient.h>
#include <infrastructure/nlohmann/json.h>
#include <infrastructure/tool/CommonTool.h>
#include <infrastructure/converter/Converter.h>
#include <infrastructure/injection/dependencyinjector.h>
#include <infrastructure/helper/UserHelper.h>
#include <infrastructure/tool/CountDownLatch.h>
#include <infrastructure/tool/RxHttp.h>
#include <infrastructure/tool/MainThread.h>

using namespace AeaQt;
using namespace nlohmann;

#define Http                                               \
HttpClient http;                                           \
http.header("osType", "3");                                \
http.header("version", "2.6.0");                           \
http.header("token", UserHelper::instance()->token());     \
http.timeout(10);

class RepositoryImpl : public Repository
{
  Q_OBJECT

private:
  template <typename T>
  void handleResult(const QString &result, T& data);

public:
  explicit RepositoryImpl(QObject* parent = nullptr);

};

#endif  // REPOSITORYIMPL_H
