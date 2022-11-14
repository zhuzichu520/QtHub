#include "DB.h"
#include <infrastructure/po/HistoryPo.h>

DB::DB() : Nut::Database()
  , m_history(new Nut::TableSet<HistoryPo>(this))
{

}
