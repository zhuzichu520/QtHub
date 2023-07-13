#pragma once

#include <infrastructure/nlohmann/json.h>

struct OwnerDto
{
    std::string avatar_url;
    std::string events_url;
    std::string followers_url;
    std::string following_url;
    std::string gists_url;
    std::string gravatar_id;
    std::string html_url;
    int id;
    std::string login;
    std::string node_id;
    std::string organizations_url;
    std::string received_events_url;
    std::string repos_url;
    bool site_admin;
    std::string starred_url;
    std::string subscriptions_url;
    std::string type;
    std::string url;
};

NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(OwnerDto,avatar_url,events_url,followers_url,following_url,gists_url,gravatar_id,html_url,id,login,node_id,organizations_url,received_events_url,repos_url,site_admin,starred_url,subscriptions_url,type,url);
