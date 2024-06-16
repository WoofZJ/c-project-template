cmake_minimum_required(VERSION 3.16)

get_filename_component(dirName ${CMAKE_CURRENT_SOURCE_DIR} NAME)

project(${dirName})

set(EXECUTABLE_NAME ${PROJECT_NAME})

add_executable(${EXECUTABLE_NAME})

file(GLOB SRC src/*.c)

target_sources(${EXECUTABLE_NAME} PRIVATE ${SRC})