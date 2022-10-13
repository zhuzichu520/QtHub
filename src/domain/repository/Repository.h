#ifndef REPOSITORY_H
#define REPOSITORY_H

#include <QObject>
#include <windows.h>

class Repository : public QObject
{
  Q_OBJECT
public:
  explicit Repository(QObject* parent = nullptr);

  QString api(const QString& path);

private:
  QString baseUrl = "https://nim-saas-api.avicnet.cn";
};

#endif  // REPOSITORY_H
