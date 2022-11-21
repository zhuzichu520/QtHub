#pragma once
#include <infrastructure/nlohmann/json.h>
struct ReadmeDto
{
std::string content;
std::string download_url;
std::string encoding;
std::string git_url;
std::string html_url;
std::string name;
std::string path;
std::string sha;
int size;
std::string type;
std::string url;
};
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(ReadmeDto,content,download_url,encoding,git_url,html_url,name,path,sha,size,type,url);
