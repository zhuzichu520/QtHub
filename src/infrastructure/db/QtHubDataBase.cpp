#include "QtHubDataBase.h"


QtHubDataBase::QtHubDataBase() : Nut::Database()
  , m_items(new Nut::TableSet<SampleTable>(this))
{

}
