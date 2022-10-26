#ifndef BASECONTROLLER_H
#define BASECONTROLLER_H

#include <QObject>
#include <QQmlParserStatus>
#include <QQuickWindow>
#include <QQuickItem>
#include <QMetaObject>
#include <infrastructure/stdafx.h>
#include <domain/exception/BizException.h>
#include <infrastructure/log/Logger.h>
#include <infrastructure/tool/RxTool.h>
#include <infrastructure/injection/dependencyinjector.h>

class BaseController : public QObject, public QQmlParserStatus
{
  Q_OBJECT
  Q_INTERFACES(QQmlParserStatus)
public:
  explicit BaseController(QObject* parent = nullptr);
  ~BaseController();

  void classBegin() override;
  void componentComplete() override;

  void showToast(const QString& text);
  void showLoading();
  void hideLoading();
  void navigate(const QString& url, int requestCode = 0);
  void finish();
  void handleError(std::exception_ptr eptr, std::function<void(BizException)> func = NULL);

  template <class S, class E, class T>
  auto obtSubscriber(S t, E e);

  QQuickWindow* window;

  rxcpp::composite_subscription subscription;
};

#endif  // BASECONTROLLER_H
