#pragma once
#include <infrastructure/nlohmann/json.h>
#include <infrastructure/dto/ReactionsDto.h>
#include <infrastructure/dto/UserDto.h>
struct IssuesDto
{
    std::string author_association;
    std::string body;
    int comments;
    std::string comments_url;
    std::string created_at;
    std::string events_url;
    std::string html_url;
    int id;
    std::string labels_url;
    bool locked;
    std::string node_id;
    int number;
    ReactionsDto reactions;
    std::string repository_url;
    std::string state;
    std::string timeline_url;
    std::string title;
    std::string updated_at;
    std::string url;
    UserDto user;
};
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(IssuesDto,author_association,body,comments,comments_url,created_at,events_url,html_url,id,labels_url,locked,node_id,number,reactions,repository_url,state,timeline_url,title,updated_at,url,user);
