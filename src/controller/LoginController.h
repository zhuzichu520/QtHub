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
  std::string htmlError = R"(<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>QtHub</title>
</head>
<body>
    <h1>QtHub授权</h1>
    <p>网络异常，请刷新页面，重新授权。</p>
</body>
</html>
)";
  std::string htmlSuccess = R"(<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>QtHub</title>
</head>
<body>
    <h1>QtHub授权</h1>
    <p>授权成功，欢迎使用QtHub。</p>
</body>
</html>
)";
};

#endif  // LOGINCONTROLLER_H
