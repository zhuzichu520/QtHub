#ifndef REPOSITORYINJECTOR_H
#define REPOSITORYINJECTOR_H

#include <infrastructure/injection/dependencyinjector.h>
#include <domain/repository/Repository.h>
#include <infrastructure/repository/impl/RepositoryImpl.h>
#include <infrastructure/http/HttpClient.h>

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
  }
};

#endif  // REPOSITORYINJECTOR_H
