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

if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    add_executable(QtHub ${PROJECT_SOURCES})
    message(${DEPLOYQT_EXECUTABLE})
#    add_custom_command(TARGET ${PROJECT_NAME}
#        POST_BUILD
#        COMMAND ${DEPLOYQT_EXECUTABLE} "$<TARGET_FILE:${PROJECT_NAME}>"
#        --$<LOWER_CASE:$<CONFIG>> --qmldir ${CMAKE_SOURCE_DIR}
#    )
else ()
    add_executable(QtHub ${PROJECT_SOURCES})
endif ()

target_link_libraries(QtHub PRIVATE
    Qt${QT_VERSION_MAJOR}::QmlPrivate
    Qt${QT_VERSION_MAJOR}::QuickPrivate
    Qt${QT_VERSION_MAJOR}::QuickControls2Private
    Qt${QT_VERSION_MAJOR}::Widgets
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
