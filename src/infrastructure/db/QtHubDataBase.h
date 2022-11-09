#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtNut/Database>

class HistoryTable;
class QtHubDataBase : public NUT_WRAP_NAMESPACE(Database)
{
    Q_OBJECT
    NUT_DB_VERSION(1)
    NUT_DECLARE_TABLE(HistoryTable, items)
public:
     QtHubDataBase();

signals:

};

#endif // DATABASE_H
