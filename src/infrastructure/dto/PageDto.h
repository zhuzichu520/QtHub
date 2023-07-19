#pragma once

#include <infrastructure/nlohmann/json.hpp>

struct PageDto
{
    int totalCount;
};

NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(PageDto,totalCount);
