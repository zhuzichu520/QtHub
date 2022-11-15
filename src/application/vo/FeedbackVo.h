#ifndef FEEDBACKVO_H
#define FEEDBACKVO_H

#include <QObject>
#include <infrastructure/stdafx.h>

class FeedbackVo : public QObject
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QString,title)
    Q_PROPERTY_AUTO(QString,avatar)
    Q_PROPERTY_AUTO(QString,login)
    Q_PROPERTY_AUTO(QString,body)
    Q_PROPERTY_AUTO(QString,createTime)
public:
    explicit FeedbackVo(QObject *parent = nullptr);

signals:

};

#endif // FEEDBACKVO_H
