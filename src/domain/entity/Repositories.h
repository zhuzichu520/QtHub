#pragma once

#include <QObject>

class Repositories
{
public:
    Repositories(){};
    ~Repositories(){};
    QString full_name;
    QString description;
    QString language;
    QString license;
    QString updated_at;
};
