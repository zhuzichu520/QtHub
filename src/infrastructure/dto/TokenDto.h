#pragma once

#include <infrastructure/nlohmann/json.hpp>

struct TokenDto{
    std::string access_token;
    std::string token_type;
    std::string scope;
};

NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(TokenDto,access_token);
