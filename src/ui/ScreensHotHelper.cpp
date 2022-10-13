#include "ScreensHotHelper.h"

ScreensHotHelper::ScreensHotHelper(QObject* parent) : QObject{ parent }
{
}

QPixmap ScreensHotHelper::screenPixmap() const
{
  return m_screenPixmap;
}

QPixmap ScreensHotHelper::clipPixmap() const
{
  return m_clipPixmap;
}

void ScreensHotHelper::refreshScreen()
{
  m_screenPixmap = qApp->screens().at(UiHelper::instance()->getScreenIndex())->grabWindow(0);
  m_clipPixmap = QPixmap();
  Q_EMIT screenPixmapChanged();
  Q_EMIT clipPixmapChanged();
}

void ScreensHotHelper::captureRect(int x, int y, int width, int height)
{
  m_clipPixmap = m_screenPixmap.copy(x, y, width, height);
  Q_EMIT clipPixmapChanged();
  //    qApp->clipboard()->setPixmap(m_clipPixmap);
}
