#ifndef LOGINCONTROLLER_H
#define LOGINCONTROLLER_H

#include <QObject>
#include <application/service/UserService.h>
#include <QHttpServer>
#include <QtConcurrent>
#include "BaseController.h"

using namespace QInjection;

class LoginController : public BaseController
{
  Q_OBJECT
  //1->未登录,2->正在登录,3->登录失败,4->登录成功
  Q_PROPERTY_AUTO(int,loginStatus)

private:
  UserService* userService()
  {
    return QInjection::Inject;
  }

public:
  explicit LoginController(QObject* parent = nullptr);
  ~LoginController();
private:
  QHttpServer server;
};

#endif  // LOGINCONTROLLER_H
