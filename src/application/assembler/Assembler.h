#pragma once

#ifndef ASSEMBLER_H
#define ASSEMBLER_H

#include <infrastructure/helper/UserHelper.h>
#include <domain/entity/Repositories.h>
#include <application/vo/RepositoriesVo.h>

class Assembler
{
public:
    static RepositoriesVo* repositories2Vo(const Repositories& val,RepositoriesVo* vo){
        vo->fullName(val.full_name);
        vo->description(val.description);
        vo->language(val.language);
        vo->license(val.license);
        vo->updatedAt(val.updated_at);
        return vo;
    }
};

#endif  // Assembler_H
