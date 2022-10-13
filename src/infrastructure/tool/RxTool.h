#ifndef RXTOOL_H
#define RXTOOL_H

#include <QObject>
#include <QGlobalStatic>
#include <rxcpp/rx.hpp>
#include <rxcpp/rx-util.hpp>
#include <rxqt.hpp>

using namespace rxcpp;
using namespace rxcpp::sources;
using namespace rxcpp::operators;
using namespace rxcpp::util;

#define Rx RxTool::instance()

class RxTool : public QObject
{
  Q_OBJECT
public:
  static RxTool* instance();
  explicit RxTool(QObject* parent = nullptr);
  rxcpp::observe_on_one_worker mainThread();
  rxcpp::observe_on_one_worker IO();

private:
  rxqt::run_loop main_loop;
};

#endif  // RXTOOL_H
