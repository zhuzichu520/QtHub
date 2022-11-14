#ifndef LOCALREPOSITORY_H
#define LOCALREPOSITORY_H

#include <QObject>
#include <domain/entity/History.h>

class LocalRepository : public QObject
{
    Q_OBJECT
public:
    explicit LocalRepository(QObject* parent = nullptr);

    virtual void saveOrUpdateHisotry(const QString &name) = 0;

    virtual QList<History> findAllHistory() = 0;

};

#endif // LOCALREPOSITORY_H
