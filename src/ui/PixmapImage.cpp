// ImageItem.cpp
#include "PixmapImage.h"

PixmapImage::PixmapImage(QQuickItem* parent) : QQuickPaintedItem(parent)
{
  setRound(false);
}

void PixmapImage::paint(QPainter* painter)
{
  painter->save();
  if (m_round)
  {
    painter->setRenderHints(QPainter::Antialiasing, true);
    QPainterPath path;
    path.addEllipse(0, 0, width(), height());
    painter->setClipPath(path);
    painter->setRenderHints(QPainter::Antialiasing, false);
  }
  painter->drawPixmap(QRect(0, 0, static_cast<int>(width()), static_cast<int>(height())), m_pixmap);
  painter->restore();
}

QPixmap PixmapImage::source() const
{
  return this->m_pixmap;
}

void PixmapImage::setSource(const QPixmap& pixmap)
{
  this->m_pixmap = pixmap;
  update();
  Q_EMIT sourceChanged();
}

bool PixmapImage::round() const
{
  return m_round;
}

void PixmapImage::setRound(bool round)
{
  m_round = round;
  update();
  Q_EMIT roundChanged();
}
