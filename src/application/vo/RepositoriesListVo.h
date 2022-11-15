#ifndef REPOSITORIESLISTVO_H
#define REPOSITORIESLISTVO_H

#include <QObject>
#include <QOlm/QOlm.hpp>
#include "RepositoriesVo.h"

using RepositoriesListVo = qolm::QOlm<RepositoriesVo>;

//class RepositoriesListVo : public qolm::QOlm<RepositoriesVo>
//{
//    Q_OBJECT
//public:
//    RepositoriesListVo(QObject* parent = nullptr, const QList<QByteArray>& exposedRoles = {}, const QByteArray& displayRole = {}) :
//        QOlm<RepositoriesVo>(parent, exposedRoles, displayRole)
//    {
//    }
//};

#endif // REPOSITORIESLISTVO_H
