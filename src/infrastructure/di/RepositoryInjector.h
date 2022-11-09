#ifndef REPOSITORYINJECTOR_H
#define REPOSITORYINJECTOR_H

#include <infrastructure/injection/dependencyinjector.h>
#include <domain/repository/Repository.h>
#include <infrastructure/repository/impl/RepositoryImpl.h>
#include <infrastructure/http/HttpClient.h>
#include <infrastructure/db/QtHubDataBase.h>
#include <infrastructure/db/HistoryTable.h>

using namespace QInjection;

class RepositoryInjector
{
public:
  static Repository* repository()
  {
    return new RepositoryImpl;
  }

  static void init()
  {
    HttpClient::instance();
    QInjection::addSingleton(repository);
    qRegisterMetaType<HistoryTable*>();
    qRegisterMetaType<QtHubDataBase*>();
    QtHubDataBase db;
    db.setDriver("QSQLITE");
    db.setDatabaseName("data.sb");
    if (db.open()) {
        qDebug() << "Unable to open the database";
    }
  }
};

#endif  // REPOSITORYINJECTOR_H
