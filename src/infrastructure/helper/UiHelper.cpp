#include "UiHelper.h"

Q_GLOBAL_STATIC(UiHelper, uiHelper)

UiHelper* UiHelper::instance()
{
    return uiHelper;
}

UiHelper::UiHelper(QObject* parent) : QObject{ parent }
{
    QFile file("./language_colors.json");
    if(!file.open(QIODevice::ReadOnly))
        return;
    QByteArray data(file.readAll());
    languageColor = CommonTool::instance()->string2JsonObject(data.toStdString());
    file.close();
}

QPoint UiHelper::mousePos()
{
    return QCursor::pos();
}

QString UiHelper::getLanguageColor(const QString& name){
    if(languageColor.isEmpty()){
        return unkownColor;
    }
    auto val = languageColor.value(name);
    if(val.isNull()){
        return unkownColor;
    }
    if(!val.isObject())
        return unkownColor;
    auto obj = val.toObject();
    auto color =  obj.value("color");
    if(color.isNull())
        return unkownColor;
    if(!color.isString())
        return unkownColor;
    return color.toString();
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

void UiHelper::restart(){
    qApp->exit(931);
}
