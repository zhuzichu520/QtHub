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
    int starNumber;
    QString name;
    QString login;
    QList<QString> topics;

public:
    QString getStyleName() const{
        return QString::fromStdString("%1/<b>%2</b>").arg(login,name);
    }
};
