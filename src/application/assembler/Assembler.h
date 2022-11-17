#pragma once

#include <application/vo/FeedbackVo.h>
#include <application/vo/RepositoriesVo.h>
#include <domain/entity/Issues.h>
#include <domain/entity/Repositories.h>
#include <infrastructure/helper/UserHelper.h>
#include <infrastructure/tool/CommonTool.h>

class Assembler {
public:
    static RepositoriesVo* repositories2Vo(const Repositories& val, RepositoriesVo* vo) {
        vo->fullName(val.getStyleName());
        vo->description(CommonTool::instance()->maxString(val.description,150));
        vo->language(val.language);
        vo->license(val.license);
        vo->updatedAt(val.updated_at);
        vo->name(val.name);
        vo->login(val.login);
        return vo;
    }

    static FeedbackVo* issues2Vo(const Issues& val, FeedbackVo* vo) {
        vo->title(val.title);
        vo->avatar(val.avatar);
        vo->login(val.login);
        vo->body(val.body);
        vo->createTime(val.createTime);
        return vo;
    }
};
