#include "HistoryTable.h"


HistoryTable::HistoryTable(QObject *parent) : Nut::Table(parent)
{
    init();
}

int HistoryTable::id() const
{
    return m_id;
}

QString HistoryTable::name() const
{
    return m_name;
}


void HistoryTable::setId(int id)
{
    if (m_id == id)
        return;

    m_id = id;
    Q_EMIT idChanged(m_id);
}

void HistoryTable::setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    Q_EMIT nameChanged(m_name);
}
