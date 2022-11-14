#include "LocalRepositoryImpl.h"
#include <infrastructure/po/HistoryPo.h>

LocalRepositoryImpl::LocalRepositoryImpl(QObject *parent)
    : LocalRepository{parent}
{
    qRegisterMetaType<HistoryPo*>();
    qRegisterMetaType<DB*>();
    db.setDriver("QSQLITE");
    db.setDatabaseName("data.sqlite");
    auto isSuccess = db.open();
    if (isSuccess) {
        LOGI("【数据库】数据库初始化成功");
    }else{
        LOGE("【数据库】数据库初始化失败");
    }
}

void LocalRepositoryImpl::saveOrUpdateHisotry(const QString &name){
    QSharedPointer<HistoryPo> item = db.history()->query().where(HistoryPo::nameField() == name).first();
    if(!item){
        item = Nut::create<HistoryPo>();
        db.history()->append(item);
    }
    item->setName(name);
    item->setUpdateTime(CommonTool::instance()->currentTimeMillis());
    db.saveChanges();
}

QList<History> LocalRepositoryImpl::findAllHistory(){
    auto list = db.history()->query().orderBy(!HistoryPo::updateTimeField()).toList(15);
    QList<History> data;
    foreach (auto item, list) {
        data.append(Converter::po2Hisotory(*item.data()));
    }
    return data;
}
