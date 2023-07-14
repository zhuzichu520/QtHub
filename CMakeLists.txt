cmake_minimum_required(VERSION 3.20)

project(QtHub VERSION 0.1 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)

set(FLUENTUI_BUILD_EXAMPLES OFF)
set(FLUENTUI_BUILD_STATIC_LIB OFF)
set(FLUENTUI_BUILD_FRAMELESSHEPLER ON)

add_subdirectory(src)
add_subdirectory(FluentUI)
set(WITH_GFLAGS OFF)
set(WITH_GTEST OFF)
add_subdirectory(glog)
