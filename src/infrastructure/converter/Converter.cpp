#include "Converter.h"

User Converter::dto2User(const UserDto& val){
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
}
