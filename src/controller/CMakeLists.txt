set(CONTROLLER_HEADERS
    BaseController.h
    LoginController.h
    MainController.h
)

set(CONTROLLER_SRS
    BaseController.cpp
    LoginController.cpp
    MainController.cpp
)

add_library(CONTROLLER ${CONTROLLER_HEADERS} ${CONTROLLER_SRS})

install(TARGETS CONTROLLER LIBRARY DESTINATION lib)
install(FILES ${CONTOLLER_HEADERS} DESTINATION include/controller)

target_link_libraries(CONTROLLER PUBLIC
    Qt${QT_VERSION_MAJOR}::QmlPrivate
    Qt${QT_VERSION_MAJOR}::QuickPrivate
    Qt${QT_VERSION_MAJOR}::QuickControls2Private
    Qt${QT_VERSION_MAJOR}::HttpServerPrivate
    Qt${QT_VERSION_MAJOR}::ConcurrentPrivate
    INFRASTRUCTURE
    DOMAIN
    APPLICATION
)

target_include_directories(CONTROLLER PUBLIC
    ${CMAKE_SOURCE_DIR}/src
    ${THIRD_DIR_PATH}/win64/rxcpp/include
    ${THIRD_DIR_PATH}/win64/rxqt/include
)
