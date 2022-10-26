#include "BaseController.h"

BaseController::BaseController(QObject* parent) : QObject{ parent }
{
}
BaseController::~BaseController()
{
  subscription.unsubscribe();
}

void BaseController::classBegin()
{
}

template <class S, class E, class T>
auto BaseController::obtSubscriber(S t, E e)
{
  return rxcpp::make_subscriber<T>(subscription, t, e);
}

void BaseController::componentComplete()
{
  auto obj = parent();
  while (Q_NULLPTR != obj)
  {
    if (obj->inherits("QQuickRootItem"))
    {
      if (auto rootItem = qobject_cast<QQuickItem*>(obj))
      {
        if (auto window = rootItem->window())
        {
          this->window = window;
          break;
        }
      }
    }

    obj = obj->parent();
  }
}

void BaseController::handleError(std::exception_ptr eptr, std::function<void(BizException)> func)
{
  try
  {
    if (eptr)
    {
      std::rethrow_exception(eptr);
    }
  }
  catch (const BizException& e)
  {
    if (func)
    {
      func(e);
    }
    LOGI(QString::fromStdString("【业务异常】code->%1，msg->%2").arg(e.code).arg(e.message).toStdString());
  }
  catch (std::exception e)
  {
    if (func)
    {
      func(BizException("未知异常"));
    }
    LOGI(QString::fromStdString("【未知异常】message->%1").arg(e.what()).toStdString());
  }
}

void BaseController::showToast(const QString& text)
{
  QMetaObject::invokeMethod(window, "showToast", Q_ARG(QVariant, text));
}

void BaseController::showLoading()
{
  QMetaObject::invokeMethod(window, "showLoading");
}

void BaseController::hideLoading()
{
  QMetaObject::invokeMethod(window, "hideLoading");
}

void BaseController::navigate(const QString& url, int requestCode)
{
  QMetaObject::invokeMethod(window, "navigate", Q_ARG(QVariant, url), Q_ARG(QVariant, requestCode));
}

void BaseController::finish()
{
  QMetaObject::invokeMethod(window, "finish");
}
