#include "UiHelper.h"

Q_GLOBAL_STATIC(UiHelper, uiHelper)

UiHelper* UiHelper::instance()
{
  return uiHelper;
}

UiHelper::UiHelper(QObject* parent) : QObject{ parent }
{
}

QPoint UiHelper::mousePos()
{
  return QCursor::pos();
}

QString UiHelper::getStringBySecretValue(int val)
{
  switch (val)
  {
    case 1:
      return "机密";
    case 2:
      return "秘密";
    case 3:
      return "核心商密";
    case 4:
      return "内部";
    case 5:
      return "普通商密";
    case 6:
      return "公开";
    default:
      return "";
  }
}

QString UiHelper::getResBySecretValue(int val)
{
  switch (val)
  {
    case 1:
      return "qrc:/image/ic_secret_1.png";
    case 2:
      return "qrc:/image/ic_secret_2.png";
    case 3:
      return "qrc:/image/ic_secret_3.png";
    case 4:
      return "qrc:/image/ic_secret_4.png";
    case 5:
      return "qrc:/image/ic_secret_5.png";
    default:
      return "";
  }
}

int UiHelper::getWH(bool isWidth, int width, int height, int ref)
{
  int realW;
  int realH;
  bool flag = width > height;
  if (flag)
  {
    if (width > ref)
    {
      qreal proportion = (qreal)ref / width;
      realW = width * proportion;
      realH = height * proportion;
    }
    else
    {
      realW = width;
      realH = height;
    }
  }
  else
  {
    if (height > ref)
    {
      qreal proportion = (qreal)ref / height;
      realW = width * proportion;
      realH = height * proportion;
    }
    else
    {
      realW = width;
      realH = height;
    }
  }
  if (isWidth)
  {
    return realW;
  }
  else
  {
    return realH;
  }
}

// 获取当前屏幕索引
int UiHelper::getScreenIndex()
{
  // 需要对多个屏幕进行处理
  int screenIndex = 0;
#if (QT_VERSION >= QT_VERSION_CHECK(5, 0, 0))
  int screenCount = qApp->screens().count();
#else
  int screenCount = qApp->desktop()->screenCount();
#endif

  if (screenCount > 1)
  {
    // 找到当前鼠标所在屏幕
    QPoint pos = QCursor::pos();
    for (int i = 0; i < screenCount; ++i)
    {
#if (QT_VERSION >= QT_VERSION_CHECK(5, 0, 0))
      if (qApp->screens().at(i)->geometry().contains(pos))
      {
#else
      if (qApp->desktop()->screenGeometry(i).contains(pos))
      {
#endif
        screenIndex = i;
        break;
      }
    }
  }
  return screenIndex;
}
