﻿set(DOMAIN_HEADERS
    repository/Repository.h
    repository/LocalRepository.h
    exception/BizException.h
    entity/User.h
    entity/Repositories.h
    entity/History.h
    entity/Issues.h
    entity/Pager.h
)

set(DOMAIN_SRS
    repository/Repository.cpp
    repository/LocalRepository.cpp
    exception/BizException.cpp
)

add_library(DOMAIN ${DOMAIN_HEADERS} ${DOMAIN_SRS})

install(TARGETS DOMAIN LIBRARY DESTINATION lib)
install(FILES ${APPLICATION_HEADERS} DESTINATION include/domain)

target_link_libraries(DOMAIN PUBLIC
    Qt${QT_VERSION_MAJOR}::CorePrivate
)

target_include_directories(DOMAIN PUBLIC
    ${CMAKE_SOURCE_DIR}/src
)
