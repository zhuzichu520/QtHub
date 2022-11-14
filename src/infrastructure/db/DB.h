#pragma once

#include <QObject>
#include <QtNut/Database>

class HistoryPo;
class DB : public NUT_WRAP_NAMESPACE(Database)
{
    Q_OBJECT
    NUT_DB_VERSION(1)
    NUT_DECLARE_TABLE(HistoryPo, history)
public:
     DB();

signals:

};
