cmake_minimum_required(VERSION 3.14)

project(QtHub VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(THIRD_DIR_PATH ${PROJECT_SOURCE_DIR}/third)
set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR} CACHE PATH "Install path prefix" FORCE)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick Network Widgets Concurrent QuickControls2)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick Network Widgets Concurrent QuickControls2)

add_definitions(-DGLOG_NO_ABBREVIATED_SEVERITIES)
add_definitions(-DSYSTEM_NAME="${CMAKE_SYSTEM_NAME}")
add_definitions(-DBUILD_TYPE="${CMAKE_BUILD_TYPE}")


add_subdirectory(src)
