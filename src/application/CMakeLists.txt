set(APPLICATION_HEADERS
    assembler/Assembler.h
    di/ApplicationInjector.h
    di/ServiceInjector.h
    service/BaseService.h
    service/UserService.h
    service/RepositoriesService.h
    vo/RepositoriesVo.h
    vo/RepositoriesListVo.h
)

set(APPLICATION_SRS
    assembler/Assembler.cpp
    service/UserService.cpp
    service/BaseService.cpp
    service/RepositoriesService.cpp
    vo/RepositoriesVo.cpp
    vo/RepositoriesListVo.cpp
)

add_library(APPLICATION ${APPLICATION_HEADERS} ${APPLICATION_SRS})


install(TARGETS APPLICATION LIBRARY DESTINATION lib)
install(FILES ${APPLICATION_HEADERS} DESTINATION include/application)

target_link_libraries(APPLICATION PUBLIC
    Qt${QT_VERSION_MAJOR}::CorePrivate
    DOMAIN
    INFRASTRUCTURE
)

if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_link_libraries(INFRASTRUCTURE PUBLIC
            ${THIRD_DIR_PATH}/win64/qolm/debug/QOlm.lib
        )
endif ()
if (CMAKE_BUILD_TYPE STREQUAL "Release")
    target_link_libraries(INFRASTRUCTURE PUBLIC
        ${THIRD_DIR_PATH}/win64/qolm/release/QOlm.lib
    )
endif ()

target_include_directories(APPLICATION PUBLIC
    ${CMAKE_SOURCE_DIR}/src
    ${THIRD_DIR_PATH}/win64/qolm/include
)

endif ()


