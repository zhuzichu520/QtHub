#pragma once

#include <infrastructure/nlohmann/json.hpp>

struct UserStatusDto
{
    std::string message;
    std::string emojiHTML;
};
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(UserStatusDto,message,emojiHTML);
