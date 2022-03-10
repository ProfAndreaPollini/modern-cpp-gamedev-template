find_package(nlohmann_json 3.2.0 QUIET) # QUIET or REQUIRED
if (NOT nlohmann_json_FOUND) # If there's none, fetch and build raylib
    include(FetchContent)
    FetchContent_Declare(
            nlohmann_json
            GIT_REPOSITORY  https://github.com/nlohmann/json.git
            GIT_TAG         develop
    )
    FetchContent_GetProperties(nlohmann_json)
    if (NOT nlohmann_json_POPULATED) # Have we downloaded raylib yet?
        set(FETCHCONTENT_QUIET NO)

        add_subdirectory(${nlohmann_json_SOURCE_DIR} ${nlohmann_json_BINARY_DIR})
    endif ()
endif ()