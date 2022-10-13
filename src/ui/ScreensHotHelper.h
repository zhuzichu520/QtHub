#ifndef SCREENSHOTHELPER_H
#define SCREENSHOTHELPER_H

#include <QObject>
#include <QPixmap>
#include <QGuiApplication>
#include <QScreen>
#include <QClipboard>
#include <infrastructure/helper/UiHelper.h>

class ScreensHotHelper : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QPixmap screenPixmap READ screenPixmap NOTIFY screenPixmapChanged)
  Q_PROPERTY(QPixmap clipPixmap READ clipPixmap NOTIFY clipPixmapChanged)
public:
  explicit ScreensHotHelper(QObject* parent = nullptr);

  [[nodiscard]] QPixmap screenPixmap() const;
  Q_SIGNAL void screenPixmapChanged();

  [[nodiscard]] QPixmap clipPixmap() const;
  Q_SIGNAL void clipPixmapChanged();

  Q_INVOKABLE void refreshScreen();
  Q_INVOKABLE void captureRect(int x, int y, int width, int height);

private:
  QPixmap m_screenPixmap;
  QPixmap m_clipPixmap;
};

#endif  // SCREENSHOTHELPER_H
