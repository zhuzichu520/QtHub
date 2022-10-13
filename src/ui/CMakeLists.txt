set(UI_HEADERS
        MainWindow.h
        TextDocument.h
        PixmapImage.h
        ScreensHotHelper.h
        MyNetworkAccessManagerFactory.h
        )

set(UI_SRS
        MainWindow.cpp
        TextDocument.cpp
        PixmapImage.cpp
        ScreensHotHelper.cpp
        MyNetworkAccessManagerFactory.cpp
        )

set(UI_RCC
        res/qml.qrc
        )

add_library(UI ${UI_SRS} ${UI_HEADERS} ${UI_RCC})

install(FILES ${UI_HEADERS} DESTINATION include/ui)

target_link_libraries(UI PUBLIC
        Qt${QT_VERSION_MAJOR}::Core
        Qt${QT_VERSION_MAJOR}::Quick
        Qt${QT_VERSION_MAJOR}::QuickControls2
        Qt${QT_VERSION_MAJOR}::Widgets
        INFRASTRUCTURE
        DOMAIN
        APPLICATION
        CONTROLLER
        )

target_include_directories(UI PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        )

if (CMAKE_SYSTEM_NAME STREQUAL "Windows")

    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_link_libraries(UI PUBLIC
                ${THIRD_DIR_PATH}/win64/frameless/debug/FramelessHelper.lib
                )
    endif ()

    if (CMAKE_BUILD_TYPE STREQUAL "Release")
        target_link_libraries(UI PUBLIC
                ${THIRD_DIR_PATH}/win64/frameless/release/FramelessHelper.lib
                )
    endif ()

    target_include_directories(
            UI PUBLIC
            ${THIRD_DIR_PATH}/win64/frameless/include
    )

endif ()

if (CMAKE_SYSTEM_NAME STREQUAL "Linux")

    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_link_libraries(UI PUBLIC
                ${THIRD_DIR_PATH}/linux/frameless/debug/libFramelessHelper.so
                )
    endif ()

    if (CMAKE_BUILD_TYPE STREQUAL "Release")
        target_link_libraries(UI PUBLIC
                ${THIRD_DIR_PATH}/linux/frameless/release/libFramelessHelper.so
                )
    endif ()

    target_include_directories(
            UI PUBLIC
            ${THIRD_DIR_PATH}/linux/frameless/include
    )


endif ()
