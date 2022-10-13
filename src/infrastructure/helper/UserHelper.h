#ifndef USERHELPER_H
#define USERHELPER_H

#include <QObject>
#include <QGlobalStatic>

class UserHelper : public QObject
{
  Q_OBJECT
public:
  static UserHelper* instance();

  explicit UserHelper(QObject* parent = nullptr);

};

#endif  // USERHELPER_H
