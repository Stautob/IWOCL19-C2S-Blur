cmake_minimum_required(VERSION 3.4.3)
project(IWOCL-2019-C2S-Examples LANGUAGES CXX)

set(ComputeCpp_DIR /opt/ComputeCpp-CE/)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

find_package(ComputeCpp REQUIRED)
include(AddExample)

option(COMPUTECPP_SDK_USE_OPENMP "Enable OpenMP support in samples" OFF)

add_subdirectory("ch.stautob.cuda2sycl.example_blur_sycl")

