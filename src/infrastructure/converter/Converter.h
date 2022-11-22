#pragma once

#include <QObject>
#include <infrastructure/tool/CommonTool.h>
#include <infrastructure/dto/UserDto.h>
#include <domain/entity/User.h>
#include <infrastructure/dto/RepositoriesDto.h>
#include <domain/entity/Repositories.h>
#include <infrastructure/po/HistoryPo.h>
#include <domain/entity/History.h>
#include <infrastructure/dto/IssuesDto.h>
#include <domain/entity/Issues.h>
#include <QJsonDocument>

class Converter
{
public:

    static History po2Hisotory(const HistoryPo& val){
        History obj;
        obj.name = val.m_name;
        return obj;
    }

    static Issues dto2Issues(const IssuesDto& val){
        Issues obj;
        obj.title = QString::fromStdString(val.title);
        obj.avatar = QString::fromStdString(val.user.avatar_url);
        obj.login = QString::fromStdString(val.user.login);
        obj.body = QString::fromStdString(val.body);
        obj.createTime = QString::fromStdString(val.created_at);
        obj.updateTime = QString::fromStdString(val.updated_at);
        return obj;
    }

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
        obj.name = QString::fromStdString(val.name);
        obj.login = QString::fromStdString(val.owner.login);
        obj.starNumber = val.stargazers_count;
        QList<QString> topicList;
        foreach (auto item, val.topics) {
            topicList.append(QString::fromStdString(item));
        }
        obj.topics = topicList;
        return obj;
    }

};
