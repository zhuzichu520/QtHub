#ifndef REOISITORIESCONTROLLER_H
#define REOISITORIESCONTROLLER_H

#include <application/assembler/Assembler.h>
#include <application/service/RepositoriesService.h>
#include <application/vo/RepositoriesListVo.h>
#include <infrastructure/tool/MainThread.h>

#include <QObject>
#include <QtConcurrent>

#include "BaseController.h"

class RepositoriesController : public BaseController {
    Q_OBJECT
    Q_PROPERTY_AUTO(QString, readme);
    Q_PROPERTY_AUTO(QString, originalReadme);
    //0：显示webview，1：loading，2:empty 3，error
    Q_PROPERTY_AUTO(int, showType);

public:
    explicit RepositoriesController(QObject* parent = nullptr);

    ~RepositoriesController();

    RepositoriesService* repositoriesService() { return QInjection::Inject; }

    Q_INVOKABLE void loadReadMe(const QString&, const QString&, bool isDark);

private:
    QString htmlMarkdown(const QString& data, bool isDark) {
        return QString::fromStdString(R"(
        <!DOCTYPE html>
        <html>
        <head>
        <title>Loading...</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="%1">
        </head>
        <body bgcolor="%2">
        %3
        </body>
        </html>
)")
                .arg(isDark ? "./html/markdown_dark.css" : "./html/markdown.css", isDark ? "#333" : "#FFFFFF", data);
    }


};

#endif  // REOISITORIESCONTROLLER_H
