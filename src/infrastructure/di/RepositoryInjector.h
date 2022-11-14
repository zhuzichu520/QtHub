#ifndef REPOSITORYINJECTOR_H
#define REPOSITORYINJECTOR_H

#include <infrastructure/injection/dependencyinjector.h>
#include <domain/repository/Repository.h>
#include <domain/repository/LocalRepository.h>
#include <infrastructure/repository/impl/RepositoryImpl.h>
#include <infrastructure/repository/impl/LocalRepositoryImpl.h>

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
    LocalRepository*  localRepository = new LocalRepositoryImpl;
    QInjection::addSingleton(localRepository);
  }
};

#endif  // REPOSITORYINJECTOR_H
