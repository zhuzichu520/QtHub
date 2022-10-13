#include "Repository.h"

Repository::Repository(QObject* parent) : QObject{ parent }
{
}

QString Repository::api(const QString& path)
{
  return baseUrl + path;
}
