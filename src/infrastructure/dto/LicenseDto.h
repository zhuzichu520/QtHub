#pragma once

#include <infrastructure/nlohmann/json.h>

struct LicenseDto
{
    std::string key;
    std::string name;
    std::string node_id;
    std::string spdx_id;
    std::string url;
};

NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(LicenseDto,key,name,node_id,spdx_id,url);
