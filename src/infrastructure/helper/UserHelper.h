#ifndef USERHELPER_H
#define USERHELPER_H

#include <QObject>
#include <QGlobalStatic>
#include <infrastructure/stdafx.h>

class UserHelper : public QObject
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QString,token)
public:
    static UserHelper* instance();

    explicit UserHelper(QObject* parent = nullptr);

};

#endif  // USERHELPER_H
