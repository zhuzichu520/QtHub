#include "UserService.h"

void UserService::login(const QString& code){
    const QString& token =  repository->accessToken("ebf59d49ca54dae4bda5","308363e4ab2d5687894d05d3d7f0e63aa22a020b",code);
    UserHelper::instance()->login(token);
    Q_EMIT loginSuccess();
    LOGD("【token】"+token);
}

User UserService::loadUser(){
    return repository->user();
}
