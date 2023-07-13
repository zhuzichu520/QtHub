#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H

#include <QObject>
#include <QtQml/qqml.h>

class MainController : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(MainController)
public:
    explicit MainController(QObject *parent = nullptr);

signals:

};

#endif // MAINCONTROLLER_H
