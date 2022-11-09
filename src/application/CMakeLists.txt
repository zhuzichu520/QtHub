set(APPLICATION_HEADERS
    assembler/Assembler.h
    di/ApplicationInjector.h
    di/ServiceInjector.h
    service/BaseService.h
    service/UserService.h
    service/RepositoriesService.h
)

set(APPLICATION_SRS
    assembler/Assembler.cpp
    service/UserService.cpp
    service/BaseService.cpp
    service/RepositoriesService.cpp
)

add_library(APPLICATION ${APPLICATION_HEADERS} ${APPLICATION_SRS})

install(TARGETS APPLICATION LIBRARY DESTINATION lib)
install(FILES ${APPLICATION_HEADERS} DESTINATION include/application)

target_link_libraries(APPLICATION PUBLIC
    Qt${QT_VERSION_MAJOR}::CorePrivate
    DOMAIN
    INFRASTRUCTURE
)

target_include_directories(APPLICATION PUBLIC
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/qolm/include
)
