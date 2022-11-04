#include "MainController.h"

MainController::MainController(QObject* parent) : BaseController{ parent }
{
    connect(userService(),&UserService::loginSuccess,this,[this](){
        loadUser();
        Q_EMIT loginSuccess();
    });
    if(UserHelper::instance()->isLogin()){
        loadUser();
    }
}

MainController::~MainController()
{
}

void MainController::loadUser(){
    rxs::create<QString>([this](subscriber<QString> subscriber){
        User user = userService()->loadUser();
        UserHelper::instance()->updateUser(user);
        subscriber.on_next("");
        subscriber.on_completed();
    }).subscribe_on(Rx->IO()).observe_on(Rx->mainThread()).subscribe([](const QString &data){

    },
    [this](const rxu::error_ptr& error){
        handleError(error,[](const BizException& e){

        });
    });
}
