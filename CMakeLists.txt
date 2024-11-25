cmake_minimum_required(VERSION 3.16)
project(Enigma_Messenger)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Find required Qt packages
find_package(Qt6 COMPONENTS
        Core
        Gui
        Quick
        REQUIRED
)

set(SOURCES
        app/main.cpp
)

set(QML_RESOURCES
        resources/qml/Main.qml
)

set(RESOURCE_FILES
        qml.qrc
)

add_executable(${PROJECT_NAME}
        ${SOURCES}
        ${RESOURCE_FILES}
)

target_link_libraries(${PROJECT_NAME}
        PRIVATE
        Qt::Core
        Qt::Gui
        Qt::Quick
)

# Deploy Qt dependencies
if(WIN32)
    set(DEBUG_SUFFIX)
    if(MSVC AND CMAKE_BUILD_TYPE MATCHES "Debug")
        set(DEBUG_SUFFIX "d")
    endif()

    # Deploy Qt DLLs
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_if_different
            $<TARGET_FILE:Qt6::Core>
            $<TARGET_FILE:Qt6::Gui>
            $<TARGET_FILE:Qt6::Quick>
            $<TARGET_FILE_DIR:${PROJECT_NAME}>
    )

    # Deploy Qt plugins
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E make_directory
            $<TARGET_FILE_DIR:${PROJECT_NAME}>/plugins/platforms
            $<TARGET_FILE_DIR:${PROJECT_NAME}>/plugins/qmltooling
    )

    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${Qt6_DIR}/../../../plugins/platforms"
            "$<TARGET_FILE_DIR:${PROJECT_NAME}>/plugins/platforms"
    )

    # Deploy QML modules
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E make_directory
            $<TARGET_FILE_DIR:${PROJECT_NAME}>/qml
    )

    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${Qt6_DIR}/../../../qml/QtQuick"
            "$<TARGET_FILE_DIR:${PROJECT_NAME}>/qml/QtQuick"
    )
endif()