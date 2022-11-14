#pragma once

#include <QObject>
#include <QtNut/table.h>
#include <infrastructure/stdafx.h>

class HistoryPo : public Nut::Table
{
    Q_OBJECT

    NUT_PRIMARY_AUTO_INCREMENT(id)
    NUT_DECLARE_FIELD(int,id,id,setId)
    NUT_DECLARE_FIELD(QString,name,name,setName)
    NUT_DECLARE_FIELD(qint64,updateTime,updateTime,setUpdateTime)

};
