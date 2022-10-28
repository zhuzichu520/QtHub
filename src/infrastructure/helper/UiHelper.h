#ifndef UIHELPER_H
#define UIHELPER_H

#include <QObject>
#include <QGlobalStatic>
#include <QCursor>
#include <QDateTime>
#include <QScreen>
#include <QGuiApplication>
#include <infrastructure/stdafx.h>

class UiHelper : public QObject
{
  Q_OBJECT
public:
  explicit UiHelper(QObject* parent = nullptr);
  static UiHelper* instance();

  Q_INVOKABLE QPoint mousePos();

  Q_INVOKABLE int getWH(bool isWidth, int width, int height, int ref = 200);

  Q_INVOKABLE QString getStringBySecretValue(int val);

  Q_INVOKABLE QString getResBySecretValue(int val);

  Q_INVOKABLE int getScreenIndex();

  Q_INVOKABLE void restart();
};

#endif  // UIHELPER_H
