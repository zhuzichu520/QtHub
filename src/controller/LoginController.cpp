#include "LoginController.h"

LoginController::LoginController(QObject* parent) : BaseController{ parent }
{
    loginStatus(1);
    server.route("/oauth/redirect",QHttpServerRequest::Method::Get,[this](const QHttpServerRequest &request) {
        loginStatus(2);
        const QString& code = request.query().queryItemValue("code");
        return QtConcurrent::run([this,code] () {
            try {
                userService()->login(code);
                loginStatus(4);
            } catch (const BizException& e) {
                loginStatus(1);
                return QHttpServerResponse(QString::fromStdString(htmlError));
            }
            return QHttpServerResponse(QString::fromStdString(htmlSuccess));
        });
    });
    server.listen(QHostAddress("127.0.0.1"),8080);
}


LoginController::~LoginController(){

}
