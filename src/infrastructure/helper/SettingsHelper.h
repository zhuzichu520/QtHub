#pragma once

#include <QtCore/qobject.h>
#include <QGlobalStatic>
#include <QSettings>
#include <QScopedPointer>
#include <QFileInfo>
#include <QCoreApplication>
#include <infrastructure/config/AppConfig.h>
#include <QDir>

class SettingsHelper : public QObject
{
    Q_OBJECT
public:
    explicit SettingsHelper(QObject* parent = nullptr);
    static SettingsHelper* instance();

    ~SettingsHelper() override;

    Q_INVOKABLE void saveToken(const QString& token){
        save("token",token);
    }

    Q_INVOKABLE QString getToken(){
        return get("token").toString();
    }

private:
    void save(const QString& key,QVariant val);

    QVariant get(const QString& key);

private:
    QScopedPointer<QSettings> m_settings;
};
