#pragma once

#ifndef ASSEMBLER_H
#define ASSEMBLER_H

#include <infrastructure/helper/UserHelper.h>
#include <domain/entity/Repositories.h>
#include <domain/entity/Issues.h>
#include <application/vo/RepositoriesVo.h>
#include <application/vo/FeedbackVo.h>

class Assembler
{
public:
    static RepositoriesVo* repositories2Vo(const Repositories& val,RepositoriesVo* vo){
        vo->fullName(val.getStyleName());
        vo->description(val.description);
        vo->language(val.language);
        vo->license(val.license);
        vo->updatedAt(val.updated_at);
        return vo;
    }

    static FeedbackVo* issues2Vo(const Issues& val,FeedbackVo* vo){
        vo->title(val.title);
        vo->avatar(val.avatar);
        vo->login(val.login);
        vo->body(val.body);
        vo->createTime(val.createTime);
        return vo;
    }
};

#endif  // Assembler_H
