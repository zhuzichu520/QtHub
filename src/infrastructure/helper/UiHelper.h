#ifndef UIHELPER_H
#define UIHELPER_H

#include <QObject>
#include <QGlobalStatic>
#include <QCursor>
#include <QDateTime>
#include <QScreen>
#include <QJsonObject>
#include <QGuiApplication>
#include <infrastructure/stdafx.h>
#include <QDir>
#include <infrastructure/log/Logger.h>
#include <infrastructure/tool/CommonTool.h>
#include <QProcess>
#include <QFile>

class UiHelper : public QObject
{
    Q_OBJECT
public:
    explicit UiHelper(QObject* parent = nullptr);
    static UiHelper* instance();

    Q_INVOKABLE QPoint mousePos();

    Q_INVOKABLE int getScreenIndex();

    Q_INVOKABLE void restart();

    Q_INVOKABLE QString getLanguageColor(const QString& name);

    Q_INVOKABLE int getWH(bool isWidth, int width, int height, int ref = 200);

    Q_INVOKABLE QString uuid();

    Q_INVOKABLE void checkUpdate();
private:
    QJsonObject languageColor;
    QString unkownColor = "#aaaaaa";
};

#endif  // UIHELPER_H
