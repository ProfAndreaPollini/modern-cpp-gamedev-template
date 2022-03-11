cmake_minimum_required(VERSION 3.21)
project(test001)
#set(BUILD_ARGS "-v" "-w" "dupbuild=warn") # verbose output

include(cmake/tinytmx.cmake)
include(cmake/spdlog.cmake)
include(cmake/entt.cmake)
include(cmake/glm.cmake)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)


### GLOBAL SETTINGS ###
include(cmake/StandardProjectSettings.cmake)
add_library(${PROJECT_NAME}_project_options INTERFACE)
add_library(${PROJECT_NAME}_project_warnings INTERFACE)

### standard compiler warnings ###
include(cmake/CompilerWarnings.cmake)
set_project_warnings(${PROJECT_NAME}_project_warnings)

add_library(emscripten_support_options INTERFACE)
if(EMSCRIPTEN)
# include(cmake/EnableEmscripten.cmake)

# target_compile_options(emscripten_support_options INTERFACE "-o ${CMAKE_CURRENT_LIST_DIR}/web/noname-rl.html")

set(emscripten_support_options_list
        "-s USE_ZLIB=1"
        "--no-heap-copy"
        "-s WASM=1"
        "-s USE_ZLIB=1"
        "-s USE_GLFW=3"
        "-s ASSERTIONS=2"
        "-s DEMANGLE_SUPPORT=1"
        "-s SAFE_HEAP=1"
        "-s USE_WEBGL2=1"
        "-s DISABLE_EXCEPTION_CATCHING=0"
        "-s ALLOW_MEMORY_GROWTH=1"
        "--source-map-base http://localhost:3000/test001.html"
#        "SHELL:-o ${CMAKE_CURRENT_LIST_DIR}/web/out.html"
#        "SHELL:--shell-file  ${CMAKE_CURRENT_LIST_DIR}/web/shell.html"
        )
set(emscripten_support_compiler_options_list
        -g -O3 -gsource-map


#        "SHELL:-o ${CMAKE_CURRENT_LIST_DIR}/web/out.html"
        )
target_compile_options(emscripten_support_options INTERFACE ${emscripten_support_compiler_options_list})
 target_link_options(emscripten_support_options INTERFACE ${emscripten_support_options_list})
set(CMAKE_EXECUTABLE_SUFFIX ".html") # This line is used to set your executable to build with the emscripten html template so that you can directly open it.

 message(STATUS "Building with emscripten")
 message("BUILD TYPE: ${CMAKE_BUILD_TYPE}")
 message("BUILD ARGS: ${BUILD_ARGS}")
 message("BUILD ARGS: ${CMAKE_CURRENT_LIST_DIR}")

 else()

 #### CCACHE ####
 include(cmake/Cache.cmake)
endif()

# Dependencies
if (EMSCRIPTEN)
 set(PLATFORM Web)
endif ()

include(FetchContent)
FetchContent_Declare(
        raylib
        GIT_REPOSITORY https://github.com/raysan5/raylib.git
        GIT_PROGRESS TRUE
        GIT_SHALLOW TRUE
        GIT_TAG master
)
FetchContent_GetProperties(raylib)
if (NOT raylib_POPULATED) # Have we downloaded raylib yet?
 set(FETCHCONTENT_QUIET NO)
 if (EMSCRIPTEN)
  add_definitions(-DPLATFORM_WEB)
 else ()
  #   add_definitions(-DPLATFORM_DESKTOP)

 endif ()
 #        add_definitions(-DGRAPHICS_API_OPENGL_33)
 FetchContent_Populate(raylib)
 set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE) # don't build the supplied examples
 add_subdirectory(${raylib_SOURCE_DIR} ${raylib_BINARY_DIR})
endif ()


message(STATUS "Building with raylib")
message("source dir: ${raylib_INCLUDE_DIR}")
message("binary dir: ${raylib_BINARY_DIR}")

FetchContent_Declare(json
        GIT_REPOSITORY https://github.com/ArthurSonzogni/nlohmann_json_cmake_fetchcontent
        GIT_PROGRESS TRUE
        GIT_SHALLOW TRUE
        GIT_TAG v3.10.5)

FetchContent_MakeAvailable(json)


add_executable(test001 main.cpp)
target_compile_features(test001  INTERFACE cxx_std_20)
target_include_directories(test001 PRIVATE ${raylib_INCLUDE_DIRS})
target_link_libraries(test001 PRIVATE
        tinytmx::tinytmx
        spdlog::spdlog
        nlohmann_json::nlohmann_json
        EnTT::EnTT
        raylib
        glm::glm
        emscripten_support_options
        ${PROJECT_NAME}_project_options ${PROJECT_NAME}_project_warnings)
target_precompile_headers(${PROJECT_NAME} PRIVATE pch.h)
