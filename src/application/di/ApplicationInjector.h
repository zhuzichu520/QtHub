#ifndef APPLICATIONINJECTOR_H
#define APPLICATIONINJECTOR_H

#include <application/di/ServiceInjector.h>
#include <infrastructure/di/RepositoryInjector.h>
#include <infrastructure/injection/dependencyinjector.h>

using namespace QInjection;

class ApplicationInjector
{
public:
    static void init()
    {
        ServiceInjector::init();
        RepositoryInjector::init();
    }
};

#endif  // APPLICATIONINJECTOR_H
