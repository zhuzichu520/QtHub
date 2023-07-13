#ifndef USERHELPER_H
#define USERHELPER_H

#include <QObject>
#include <QGlobalStatic>
#include "infrastructure/helper/SettingsHelper.h"
#include "domain/entity/User.h"
#include "stdafx.h"

class UserHelper : public QObject
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QString,token)
    Q_PROPERTY_AUTO(QString,name)
    Q_PROPERTY_AUTO(QString,account)
    Q_PROPERTY_AUTO(QString,avatar)
    Q_PROPERTY_AUTO(QString,location)
    Q_PROPERTY_AUTO(QString,email)
    Q_PROPERTY_AUTO(QString,blog)
    Q_PROPERTY_AUTO(QString,created_at)
    Q_PROPERTY_AUTO(QString,updated_at)
    Q_PROPERTY_AUTO(int,public_repos)
    Q_PROPERTY_AUTO(int,public_gists)
    Q_PROPERTY_AUTO(int,followers)
    Q_PROPERTY_AUTO(int,following)
public:
    static UserHelper* instance();

    explicit UserHelper(QObject* parent = nullptr);

    Q_INVOKABLE bool isLogin(){
        return !_token.isEmpty();
    }

    Q_INVOKABLE void logout(){
        token(""),name(""),account(""),avatar(""),location(""),email(""),blog(""),created_at(""),updated_at("");
        public_repos(0),public_gists(0),followers(0),following(0);
        SettingsHelper::instance()->saveToken(_token);
    }

    Q_INVOKABLE void login(const QString& val){
        token(val);
        SettingsHelper::instance()->saveToken(_token);
    }

    void updateUser(const User& user){
        name(user.name);
        avatar(user.avatar);
        location(user.location);
        email(user.email);
        blog(user.blog);
        created_at(user.created_at);
        updated_at(user.updated_at);
        public_repos(user.public_repos);
        public_gists(user.public_gists);
        followers(user.followers);
        following(user.following);
        account(user.login);
    };

};

#endif  // USERHELPER_H
