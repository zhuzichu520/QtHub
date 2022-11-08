#pragma once

#include <infrastructure/nlohmann/json.h>

struct SearchRepositoriesDto{
    std::string access_token;
    std::string token_type;
    std::string scope;
};
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(SearchRepositoriesDto,access_token);
