#pragma once

#include <infrastructure/nlohmann/json.hpp>
#include "UserStatusDto.h"
#include "PageDto.h"

struct UserDto
{
    std::string login;
    std::string bio;
    std::string name;
    std::string email;
    std::string location;
    std::string websiteUrl;
    std::string avatarUrl;
    std::string company;
    PageDto followers;
    PageDto following;
    UserStatusDto status;
};
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(UserDto,login,bio,name,email,location,websiteUrl,avatarUrl,company,followers,following,status);
