find_package(tinytmx QUIET) # QUIET or REQUIRED
if (NOT tinytmx_FOUND) # If there's none, fetch and build raylib
    include(FetchContent)
    FetchContent_Declare(
            tinytmx
            GIT_REPOSITORY https://github.com/KaseyJenkins/tinytmx.git
            GIT_TAG master
    )
    FetchContent_GetProperties(tinytmx)
    if (NOT tinytmx_POPULATED) # Have we downloaded raylib yet?
        set(FETCHCONTENT_QUIET NO)
        if (EMSCRIPTEN)
            set(TINYTMX_USE_MINIZ ON)
            add_definitions(-DTINYTMX_USE_MINIZ)
        endif ()
        #        if (EMSCRIPTEN)
        #            add_definitions(-DPLATFORM_WEB)
        #        else ()
        #            add_definitions(-DPLATFORM_DESKTOP)
        #
        #        endif ()
        #        add_definitions(-DGRAPHICS_API_OPENGL_33)
        FetchContent_Populate(tinytmx)
        #        set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE) # don't build the supplied examples
        add_subdirectory(${tinytmx_SOURCE_DIR} ${tinytmx_BINARY_DIR})
    endif ()
endif ()