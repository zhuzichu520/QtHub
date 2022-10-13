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

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(QtHub
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
        )
else()
    if(ANDROID)
        add_library(QtHub SHARED
            ${PROJECT_SOURCES}
            )
    else()
        add_executable(QtHub
            ${PROJECT_SOURCES}
            )
    endif()
endif()

target_compile_definitions(QtHub
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(QtHub PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Quick
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
    #    WIN32_EXECUTABLE TRUE
    )

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(QtHub)
    qt_finalize_executable(QtHub)
endif()
