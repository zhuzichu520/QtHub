#pragma once

#include <infrastructure/nlohmann/json.h>

struct OwnerDto{
    std::string login;
    int64_t id;
    std::string node_id;
    std::string avatar_id;
    std::string gravatar_id;
    std::string url;
    std::string html_url;
    std::string followers_url;
    std::string following_url;
    std::string gists_url;
    std::string starred_url;
    std::string subscriptions_url;
    std::string organizations_url;
    std::string repos_url;
    std::string events_url;
    std::string received_events_url;
    std::string type;
    bool site_admin;
};
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(
        OwnerDto,login,id,node_id,avatar_id,gravatar_id,url,html_url,followers_url,
        following_url,gists_url,starred_url,subscriptions_url,organizations_url,repos_url,
        repos_url,events_url,received_events_url,type,site_admin
        );
