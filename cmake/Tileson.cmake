find_package(tileson QUIET) # QUIET or REQUIRED
if (NOT tileson_FOUND) # If there's none, fetch and build raylib
    include(FetchContent)
    FetchContent_Declare(
            tileson
            GIT_REPOSITORY  https://github.com/SSBMTonberry/tileson.git
            GIT_TAG         master
    )
    FetchContent_GetProperties(tileson)
    if (NOT tileson_POPULATED) # Have we downloaded raylib yet?
        set(FETCHCONTENT_QUIET NO)
        #        if (EMSCRIPTEN)
        #            add_definitions(-DPLATFORM_WEB)
        #        else ()
        #            add_definitions(-DPLATFORM_DESKTOP)
        #
        #        endif ()
        #        add_definitions(-DGRAPHICS_API_OPENGL_33)
        FetchContent_Populate(tileson)
        set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE) # don't build the supplied examples
        add_subdirectory(${tileson_SOURCE_DIR} ${tileson_BINARY_DIR})
    endif ()
endif ()