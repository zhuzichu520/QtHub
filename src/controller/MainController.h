#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H

#include <QObject>
#include "BaseController.h"
#include <application/service/UserService.h>
#include <infrastructure/helper/UserHelper.h>
#include <application/assembler/Assembler.h>

class MainController : public BaseController
{
  Q_OBJECT
private:
  UserService* userService()
  {
    return QInjection::Inject;
  }

public:
  explicit MainController(QObject* parent = nullptr);

  ~MainController();

  Q_SIGNAL void loginSuccess();

  Q_INVOKABLE void loadUser();


};

#endif  // MAINCONTROLLER_H
