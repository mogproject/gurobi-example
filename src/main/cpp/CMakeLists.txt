cmake_minimum_required(VERSION 3.14)

# Avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP in CMake 3.24
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
  cmake_policy(SET CMP0135 NEW)
endif()

project(mip)

# Options
option(CXX "enable C++ compilation" ON)

if(CXX)
  enable_language(CXX)
endif()

option(BUILD_TESTS "Build test programs" OFF)

# Specify the C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Compiler options
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -fopenmp -pthread")

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -fno-omit-frame-pointer -fsanitize=leak -O0")
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -funroll-loops -O3")
endif()
message(STATUS "Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "Options: ${CMAKE_CXX_FLAGS}")

# Gurobi settings
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
find_package(GUROBI REQUIRED)
include_directories(${GUROBI_INCLUDE_DIRS})
message(STATUS "GUROBI_HOME: $ENV{GUROBI_HOME}")
message(STATUS "GUROBI_LIBRARY: ${GUROBI_LIBRARY}")
message(STATUS "GUROBI_CXX_LIBRARY: ${GUROBI_CXX_LIBRARY}")

# Executable
add_executable(mip mip1_c++.cpp)
target_link_libraries(mip
  optimized ${GUROBI_CXX_LIBRARY}
  debug ${GUROBI_CXX_DEBUG_LIBRARY}
  ${GUROBI_LIBRARY}
)
