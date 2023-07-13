#pragma once

#include <QObject>


template<typename T>
class Pager
{
public:
    Pager(){};
    ~Pager(){};

   int totalCount;
   T data;
};
