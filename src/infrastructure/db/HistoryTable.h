#ifndef HISTORYTABLE_H
#define HISTORYTABLE_H

#include <QObject>
#include <QtNut/table.h>

class HistoryTable : public Nut::Table
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

    int m_id;
    QString m_name;

    // BEGIN OF NUT MACROS
    NUT_PRIMARY_KEY(id)
    NUT_FIELD(int, id)
    NUT_FIELD(QString, name)
    //END OF NUT MACROS

public:
    explicit HistoryTable(QObject *parent = nullptr);

    int id() const;
    QString name() const;

public Q_SLOTS:
    void setId(int id);
    void setName(QString name);

Q_SIGNALS:
    void idChanged(int id);
    void nameChanged(QString name);
};

#endif // HISTORYTABLE_H
