#pragma once

#include <QObject>

class Issues
{
public:
    Issues(){};
    ~Issues(){};
    QString title;
    QString avatar;
    QString login;
    QString body;
    QString createTime;
    QString updateTime;
};
