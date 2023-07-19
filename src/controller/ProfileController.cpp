#include "ProfileController.h"

#include "infrastructure/helper/UserHelper.h"
#include <infrastructure/tool/RxTool.h>

ProfileController::ProfileController(QObject *parent)
    : BaseController{parent}
{

}

void ProfileController::loadProfileInfo(){
    rxs::create<QString>([this](subscriber<QString> subscriber){
        User user = _userService()->loadUser();
        UserHelper::getInstance()->updateUser(user);
        subscriber.on_next("");
        subscriber.on_completed();
    }).subscribe_on(Rx->IO()).observe_on(Rx->mainThread()).subscribe([=](const QString &data){
        Q_EMIT loadProfileSuccessEvent();
    },[this](const rxu::error_ptr& error){
        handleError(error,[=](const BizException& e){
            Q_EMIT loadProfileErrorEvent(e.message);
        });
    });
}
