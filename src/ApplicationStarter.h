#ifndef APPLICATIONINJECTOR_H
#define APPLICATIONINJECTOR_H

#include "infrastructure/di/ServiceInjector.h"
#include "infrastructure/di/RepositoryInjector.h"
#include "infrastructure/log/Logger.h"

using namespace QInjection;

class ApplicationStarter
{
public:
    static void init(char* argv[])
    {
        Logger::instance()->initGoogleLog(argv);
        LOGI(QString("Logger init completed"));
        ServiceInjector::init();
        RepositoryInjector::init();
    }
};

#endif  // APPLICATIONINJECTOR_H
