#include "RxTool.h"

Q_GLOBAL_STATIC(RxTool, rxTool)

RxTool* RxTool::instance()
{
  return rxTool;
}

RxTool::RxTool(QObject* parent) : QObject{ parent }
{
}

rxcpp::observe_on_one_worker RxTool::mainThread()
{
  return main_loop.observe_on_run_loop();
}

rxcpp::observe_on_one_worker RxTool::IO()
{
  return rxcpp::observe_on_event_loop();
}
