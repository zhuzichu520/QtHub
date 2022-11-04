#pragma once

#include <QObject>

class User
{
public:
    User(){};
    ~User(){};
    QString name;
    QString avatar;
    QString location;
    QString email;
    QString blog;
    QString created_at;
    QString updated_at;
    QString login;
    int public_repos;
    int public_gists;
    int followers;
    int following;
};
