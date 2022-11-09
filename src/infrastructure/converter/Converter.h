#pragma once

#include <QObject>
#include <infrastructure/tool/CommonTool.h>
#include <infrastructure/dto/UserDto.h>
#include <domain/entity/User.h>
#include <infrastructure/dto/RepositoriesDto.h>
#include <domain/entity/Repositories.h>
#include <QJsonDocument>

class Converter
{
public:
    static User dto2User(const UserDto& val){
        User obj;
        obj.name = QString::fromStdString(val.name);
        obj.avatar = QString::fromStdString(val.avatar_url);
        obj.location = QString::fromStdString(val.location);
        obj.email = QString::fromStdString(val.email);
        obj.blog = QString::fromStdString(val.blog);
        obj.created_at = QString::fromStdString(val.created_at);
        obj.updated_at = QString::fromStdString(val.updated_at);
        obj.public_repos = val.public_repos;
        obj.public_gists = val.public_gists;
        obj.followers = val.followers;
        obj.following = val.following;
        obj.login = QString::fromStdString(val.login);
        return obj;
    };

    static Repositories dto2Repositories(const RepositoriesDto& val){
        Repositories obj;
        obj.full_name = QString::fromStdString(val.full_name);
        obj.description = QString::fromStdString(val.description);
        obj.language = QString::fromStdString(val.language);
        obj.license = QString::fromStdString(val.license.name);
        obj.updated_at = QString::fromStdString(val.updated_at);
        return obj;
    }

};
