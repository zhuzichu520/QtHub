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

  public:
    explicit RepositoriesController(QObject* parent = nullptr);

    ~RepositoriesController();

    RepositoriesService* repositoriesService() { return QInjection::Inject; }

    Q_INVOKABLE void loadReadMe(const QString&, const QString&, bool isDark);

    Q_INVOKABLE void showLoading(bool isDark) { readme(hmltLoading(isDark)); }

    Q_INVOKABLE void showEmpty(bool isDark) { readme(hmltEmpty(isDark)); }

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
    QString hmltLoading(bool isDark) {
        return QString::fromStdString(R"(
        <!DOCTYPE html>
        <html>
        <head>
        <title>Loading...</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="./html/loading.css">
        </head>
        <body bgcolor="%1">
        <div class="loading">
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        </div>
        </body>
        </html>
)")
            .arg(isDark ? "#333" : "#FFFFFF");
    }

    QString hmltEmpty(bool isDark) {
        return QString::fromStdString(R"(
        <!DOCTYPE html>
        <html>
        <head>
        <title>Loading...</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        </head>
        <body bgcolor="%1">
        <div class="loading">
            <h1 style="color:%2">空空如也</h1>
        </div>
        </body>
        </html>
)")
            .arg(isDark ? "#333" : "#FFFFFF", isDark ? "#FFFFFF" : "#333");
    }
};

#endif  // REOISITORIESCONTROLLER_H
