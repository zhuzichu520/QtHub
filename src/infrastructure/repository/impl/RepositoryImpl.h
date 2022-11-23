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
#include <infrastructure/converter/Converter.h>
#include <infrastructure/dto/TokenDto.h>
#include <infrastructure/dto/ReadmeDto.h>
#include <infrastructure/dto/SearchRepositoriesDto.h>

using namespace AeaQt;
using namespace nlohmann;


class RepositoryImpl : public Repository
{
    Q_OBJECT

private:
    template <typename T>
    void handleResult(QString result, T& data);

    QString accessToken(const QString &id,const QString &secret,const QString &code) override;

    User user() override;

    Pager<QList<Repositories>> search(const QString& q,const QString& sort,const QString& order,int per_page,int page) override;

    QList<Issues> getIssuesList(const QString& owner,const QString& repo) override;

    QString getReadme(const QString& login,const QString& name) override;

    QString getReadme2(const QString& login,const QString& name) override;

    QString readme2Html(const QString& text) override;

    QString getFileTree(const QString& owner,const QString& repo,const QString& tree_sha,int recursive) override;

public:
    explicit RepositoryImpl(QObject* parent = nullptr);

};

#endif  // REPOSITORYIMPL_H
