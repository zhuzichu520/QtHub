#ifndef BASESERVICE_H
#define BASESERVICE_H

#include <QObject>
#include <infrastructure/log/Logger.h>
#include <infrastructure/injection/dependencyinjector.h>
#include <domain/repository/Repository.h>

class BaseService : public QObject
{
  Q_OBJECT
public:
  explicit BaseService(QObject* parent = nullptr);
};

#endif  // BASESERVICE_H
