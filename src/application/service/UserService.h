#ifndef USERSERVICE_H
#define USERSERVICE_H

#include <QObject>
#include <infrastructure/tool/CommonTool.h>
#include <infrastructure/helper/UserHelper.h>
#include "BaseService.h"

using namespace QInjection;

class UserService : public BaseService
{
  Q_OBJECT
public:
  explicit UserService(QObject* parent = nullptr, Repository* repository = QInjection::Inject)
    : repository(repository){};

private:
  Repository* repository;
};

#endif  // USERSERVICE_H
