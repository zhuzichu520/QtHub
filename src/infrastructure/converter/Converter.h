#pragma once

#include <QObject>
#include <infrastructure/tool/CommonTool.h>
#include <infrastructure/dto/UserDto.h>
#include <domain/entity/User.h>
#include <QJsonDocument>

class Converter
{
public:
    static User dto2User(const UserDto val){
        User user;
        user.name = QString::fromStdString(val.name);
        user.avatar = QString::fromStdString(val.avatar_url);
        user.location = QString::fromStdString(val.location);
        user.email = QString::fromStdString(val.email);
        user.blog = QString::fromStdString(val.blog);
        user.created_at = QString::fromStdString(val.created_at);
        user.updated_at = QString::fromStdString(val.updated_at);
        user.public_repos = val.public_repos;
        user.public_gists = val.public_gists;
        user.followers = val.followers;
        user.following = val.following;
        user.login = QString::fromStdString(val.login);
        return user;
    };
};
