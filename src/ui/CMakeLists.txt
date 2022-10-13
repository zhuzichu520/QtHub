set(UI_HEADERS
        MainWindow.h
        TextDocument.h
        PixmapImage.h
        ScreensHotHelper.h
        Settings.h
        MyNetworkAccessManagerFactory.h
        )

set(UI_SRS
        MainWindow.cpp
        TextDocument.cpp
        PixmapImage.cpp
        ScreensHotHelper.cpp
        Settings.cpp
        MyNetworkAccessManagerFactory.cpp
        )

set(UI_RCC
        res/qml.qrc
        )

add_library(UI ${UI_SRS} ${UI_HEADERS} ${UI_RCC})

install(FILES ${UI_HEADERS} DESTINATION include/ui)

target_link_libraries(UI PUBLIC
        Qt6::Core
        Qt6::Quick
        Qt6::QuickControls2
        Qt6::Widgets
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
                ${THIRD_DIR_PATH}/win64/frameless/debug/FramelessHelperCored.lib
                ${THIRD_DIR_PATH}/win64/frameless/debug/FramelessHelperQuickd.lib
                ${THIRD_DIR_PATH}/win64/frameless/debug/FramelessHelperWidgetsd.lib
                )
    endif ()

    if (CMAKE_BUILD_TYPE STREQUAL "Release")
        target_link_libraries(UI PUBLIC
                ${THIRD_DIR_PATH}/win64/frameless/release/FramelessHelperCore.lib
                ${THIRD_DIR_PATH}/win64/frameless/release/FramelessHelperQuick.lib
                ${THIRD_DIR_PATH}/win64/frameless/release/FramelessHelperWidgets.lib
                )
    endif ()

    target_include_directories(
            UI PUBLIC
            ${THIRD_DIR_PATH}/win64/frameless/include/FramelessHelper/Core/private
            ${THIRD_DIR_PATH}/win64/frameless/include/FramelessHelper/Core
            ${THIRD_DIR_PATH}/win64/frameless/include/FramelessHelper/Quick
            ${THIRD_DIR_PATH}/win64/frameless/include/FramelessHelper/Widgets
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
