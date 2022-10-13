cmake_minimum_required(VERSION 3.14)

project(QtHub VERSION 0.1 LANGUAGES CXX)

add_subdirectory(infrastructure)
add_subdirectory(domain)
add_subdirectory(application)
add_subdirectory(controller)
add_subdirectory(ui)

set(PROJECT_SOURCES
    main.cpp
    ui/res/qml.qrc
    )

qt_add_executable(QtHub
    ${PROJECT_SOURCES}
    )

target_link_libraries(QtHub PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Widgets
    UI
    )

target_include_directories(QtHub PRIVATE
    ${CMAKE_SOURCE_DIR}/src
    )

set_target_properties(QtHub PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER zhjw.QtHub.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if (CMAKE_SYSTEM_NAME STREQUAL "Windows")

    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_link_libraries(QtHub PUBLIC
                ${THIRD_DIR_PATH}/win64/frameless/debug/FramelessHelperCored.lib
                ${THIRD_DIR_PATH}/win64/frameless/debug/FramelessHelperQuickd.lib
                ${THIRD_DIR_PATH}/win64/frameless/debug/FramelessHelperWidgetsd.lib
                )
    endif ()

    if (CMAKE_BUILD_TYPE STREQUAL "Release")
        target_link_libraries(QtHub PUBLIC
                ${THIRD_DIR_PATH}/win64/frameless/release/FramelessHelperCore.lib
                ${THIRD_DIR_PATH}/win64/frameless/release/FramelessHelperQuick.lib
                ${THIRD_DIR_PATH}/win64/frameless/release/FramelessHelperWidgets.lib
                )
    endif ()

    target_include_directories(
            QtHub PUBLIC
            ${THIRD_DIR_PATH}/win64/frameless/include/FramelessHelper/Core/private
            ${THIRD_DIR_PATH}/win64/frameless/include/FramelessHelper/Core
            ${THIRD_DIR_PATH}/win64/frameless/include/FramelessHelper/Quick
            ${THIRD_DIR_PATH}/win64/frameless/include/FramelessHelper/Widgets
    )

endif ()
