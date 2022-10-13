#ifndef LOGINCONTROLLER_H
#define LOGINCONTROLLER_H

#include <QObject>
#include <application/service/UserService.h>
#include "BaseController.h"

using namespace QInjection;

class LoginController : public BaseController
{
  Q_OBJECT

private:
  UserService* userService()
  {
    return QInjection::Inject;
  }

public:
  explicit LoginController(QObject* parent = nullptr);

};

#endif  // LOGINCONTROLLER_H
