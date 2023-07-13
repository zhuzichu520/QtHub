#include "LoginController.h"

#include <QtConcurrent>
#include "domain/exception/BizException.h"

LoginController::LoginController(QObject *parent,UserService* service)
    : BaseController{parent},_userService(service)
{
    loginStatus(1);
    _server.route("/oauth/redirect",QHttpServerRequest::Method::Get,[this](const QHttpServerRequest &request) {
        loginStatus(2);
        const QString& code = request.query().queryItemValue("code");
        return QtConcurrent::run([this,code] () {
            try {
                _userService->login(code);
                loginStatus(4);
            } catch (const BizException& e) {
                loginStatus(1);
                return QHttpServerResponse(QString::fromStdString(_htmlError));
            }
            return QHttpServerResponse(QString::fromStdString(_htmlSuccess));
        });
    });
    _server.listen(QHostAddress("127.0.0.1"),8080);
}
