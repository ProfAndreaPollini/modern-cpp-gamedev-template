set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_BUILD_TYPE "Debug")


include(CheckIPOSupported)
check_ipo_supported(
        RESULT
        result
        OUTPUT
        output)
if(result)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
    message(STATUS "IPO is supported : ACTIVE")
else()
    message(SEND_ERROR "IPO is not supported: ${output}")
endif()