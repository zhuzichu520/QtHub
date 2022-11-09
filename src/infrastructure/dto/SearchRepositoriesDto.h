#pragma once
#include <infrastructure/nlohmann/json.h>
#include <infrastructure/dto/RepositoriesDto.h>

struct SearchRepositoriesDto
{
    bool incomplete_results;
    std::vector<RepositoriesDto> items;
    int total_count;
};

NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(SearchRepositoriesDto,incomplete_results,items,total_count);
