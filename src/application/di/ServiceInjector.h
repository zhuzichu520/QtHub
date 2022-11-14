#ifndef SERVICEINJECTOR_H
#define SERVICEINJECTOR_H

#include <application/service/UserService.h>
#include <application/service/RepositoriesService.h>
#include <infrastructure/injection/dependencyinjector.h>

using namespace QInjection;

class ServiceInjector
{
public:
    static UserService* userService()
    {
        return new UserService();
    }

    static RepositoriesService* repositoriesService()
    {
        return new RepositoriesService();
    }

    static void init()
    {
        QInjection::addSingleton(userService);
        QInjection::addSingleton(repositoriesService);
    }
};

#endif  // SERVICEINJECTOR_H
