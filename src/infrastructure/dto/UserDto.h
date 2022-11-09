#pragma once

#include <infrastructure/nlohmann/json.h>

struct UserDto
{
    std::string avatar_url;
    std::string bio;
    std::string blog;
    std::string company;
    std::string created_at;
    std::string email;
    std::string events_url;
    int followers;
    std::string followers_url;
    int following;
    std::string following_url;
    std::string gists_url;
    std::string gravatar_id;
    std::string hireable;
    std::string html_url;
    int64_t id;
    std::string location;
    std::string login;
    std::string name;
    std::string node_id;
    std::string organizations_url;
    int public_gists;
    int public_repos;
    std::string received_events_url;
    std::string repos_url;
    int site_admin;
    std::string starred_url;
    std::string subscriptions_url;
    std::string twitter_username;
    std::string type;
    std::string updated_at;
    std::string url;
};
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(UserDto,avatar_url,bio,blog,company,created_at,email,events_url,followers,followers_url,following,following_url,gists_url,gravatar_id,hireable,html_url,id,location,login,name,node_id,organizations_url,public_gists,public_repos,received_events_url,repos_url,site_admin,starred_url,subscriptions_url,twitter_username,type,updated_at,url);
