#ifndef APPLICATIONINJECTOR_H
#define APPLICATIONINJECTOR_H

#include "infrastructure/di/ServiceInjector.h"
#include <infrastructure/di/RepositoryInjector.h>

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
