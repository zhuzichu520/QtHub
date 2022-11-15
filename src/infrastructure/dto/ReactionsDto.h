#pragma once
#include <infrastructure/nlohmann/json.h>
struct ReactionsDto
{
    int confused;
    int eyes;
    int heart;
    int hooray;
    int laugh;
    int rocket;
    int total_count;
    std::string url;
};
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(ReactionsDto,confused,eyes,heart,hooray,laugh,rocket,total_count,url);
