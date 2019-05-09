cmake_minimum_required(VERSION 3.4.3)
project(IWOCL-2019-C2S-Examples LANGUAGES CXX)

add_example(TARGET ${PROJECT_NAME} SOURCES main.cpp;filter.cpp;filter.h;lodepng.h;lodepng.cpp)
