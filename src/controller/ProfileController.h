#ifndef PROFILECONTROLLER_H
#define PROFILECONTROLLER_H

#include <QObject>
#include <QtQml/qqml.h>
#include "BaseController.h"
#include "application/service/UserService.h"

class ProfileController : public BaseController
{
    Q_OBJECT
    QML_NAMED_ELEMENT(ProfileController)
public:
    explicit ProfileController(QObject *parent = nullptr);

    Q_INVOKABLE void loadProfileInfo();
private:
    UserService* _userService(){return QInjection::Inject;}
};

#endif // PROFILECONTROLLER_H
