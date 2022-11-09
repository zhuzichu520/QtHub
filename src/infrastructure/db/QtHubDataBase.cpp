#include "QtHubDataBase.h"
#include "HistoryTable.h"

QtHubDataBase::QtHubDataBase() : Nut::Database()
  , m_items(new Nut::TableSet<HistoryTable>(this))
{

}
