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
    Qt${QT_VERSION_MAJOR}::WidgetsPrivate
    Qt${QT_VERSION_MAJOR}::QmlPrivate
    Qt${QT_VERSION_MAJOR}::QuickPrivate
    Qt${QT_VERSION_MAJOR}::QuickControls2Private
    INFRASTRUCTURE
    DOMAIN
    APPLICATION
    CONTROLLER
)

target_include_directories(UI PUBLIC
    ${CMAKE_SOURCE_DIR}/src
)
