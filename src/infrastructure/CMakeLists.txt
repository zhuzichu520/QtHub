set(INFRASTRUCTURE_HEADERS
    stdafx.h

    injection/dep_global.h
    injection/dependencycreator.h
    injection/dependencyinjector.h
    injection/dependencypointer.h
    injection/dependencypool.h

    nlohmann/json.h
    http/HttpClient.h
    http/httplib.h
    log/Logger.h
    config/AppConfig.h
    tool/CommonTool.h
    tool/RxTool.h
    tool/RxHttp.h
    tool/MainThread.h
    tool/CountDownLatch.h
    helper/UiHelper.h
    helper/UserHelper.h
    helper/SettingsHelper.h

    converter/Converter.h

    repository/impl/RepositoryImpl.h
    di/RepositoryInjector.h

    dto/TokenDto.h
    dto/UserDto.h
    dto/OwnerDto.h
    dto/RepositoryDto.h
    dto/SearchRepositoriesDto.h

)

set(INFRASTRUCTURE_SRS
    injection/dependencycreator.cpp
    injection/dependencyinjector.cpp
    injection/dependencypointer.cpp
    injection/dependencypool.cpp

    log/Logger.cpp
    config/AppConfig.cpp
    tool/RxTool.cpp
    tool/CommonTool.cpp
    tool/CountDownLatch.cpp
    tool/MainThread.cpp
    helper/UiHelper.cpp
    helper/UserHelper.cpp
    helper/SettingsHelper.cpp

    repository/impl/RepositoryImpl.cpp

    converter/Converter.cpp

)

add_library(INFRASTRUCTURE ${INFRASTRUCTURE_HEADERS} ${INFRASTRUCTURE_SRS})

install(TARGETS INFRASTRUCTURE LIBRARY DESTINATION lib)

install(FILES ${INFRASTRUCTURE_HEADERS} DESTINATION include/infrastructure)

target_link_libraries(INFRASTRUCTURE PUBLIC
    Qt${QT_VERSION_MAJOR}::CorePrivate
    Qt${QT_VERSION_MAJOR}::NetworkPrivate
    Qt${QT_VERSION_MAJOR}::QuickPrivate
    DOMAIN
)

target_include_directories(INFRASTRUCTURE PUBLIC
    ${CMAKE_SOURCE_DIR}/src
)

if (CMAKE_SYSTEM_NAME STREQUAL "Windows")

    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_link_libraries(INFRASTRUCTURE PUBLIC
            ${THIRD_DIR_PATH}/win64/glog/debug/glogd.lib
            ${THIRD_DIR_PATH}/win64/qolm/debug/QOlm.lib
        )
endif ()

if (CMAKE_BUILD_TYPE STREQUAL "Release")
    target_link_libraries(INFRASTRUCTURE PUBLIC
        ${THIRD_DIR_PATH}/win64/glog/release/glog.lib
        ${THIRD_DIR_PATH}/win64/qolm/release/QOlm.lib
    )
endif ()

target_link_libraries(INFRASTRUCTURE PUBLIC
)

message(${THIRD_DIR_PATH})
target_include_directories(
    INFRASTRUCTURE PUBLIC
    ${THIRD_DIR_PATH}/win64/glog/include
    ${THIRD_DIR_PATH}/win64/qolm/include
    ${THIRD_DIR_PATH}/win64/rxcpp/include
    ${THIRD_DIR_PATH}/win64/rxqt/include
)

endif ()


if (CMAKE_SYSTEM_NAME STREQUAL "Linux")

    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_link_libraries(INFRASTRUCTURE PUBLIC
            ${THIRD_DIR_PATH}/linux/glog/debug/libglogd.so
        )
endif ()

if (CMAKE_BUILD_TYPE STREQUAL "Release")
    target_link_libraries(INFRASTRUCTURE PUBLIC
        ${THIRD_DIR_PATH}/linux/glog/release/libglog.so
    )
endif ()

target_link_libraries(INFRASTRUCTURE PUBLIC
)

target_include_directories(
    INFRASTRUCTURE PUBLIC
    ${THIRD_DIR_PATH}/linux/glog/include
)

endif ()
