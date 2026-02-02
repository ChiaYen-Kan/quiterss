cmake_minimum_required(VERSION 3.16)

set(TARGET_NAME "QuiteRSS")

project(${TARGET_NAME}
    DESCRIPTION ${TARGET_NAME}
    LANGUAGES CXX
)

# create revision file

execute_process(COMMAND git rev-list --count HEAD
                OUTPUT_VARIABLE GIT_REV_COUNT
                ERROR_QUIET)

if ("${GIT_REV_COUNT}" STREQUAL "")
    set(GIT_REV_COUNT "0")
    set(GIT_REV_HASH "")
else()
    string(STRIP "${GIT_REV_COUNT}" ${GIT_REV_COUNT})

    execute_process(COMMAND git rev-parse --short HEAD
                OUTPUT_VARIABLE GIT_REV_HASH
                ERROR_QUIET)
    string(REGEX REPLACE "\n$" "" GIT_REV_HASH "${GIT_REV_HASH}")
    set(GIT_REV_HASH "\"${GIT_REV_HASH}\"")
endif()

set(VERSION "#define VCS_REVISION ${GIT_REV_COUNT}")
set(HASH "#define VCS_SHORT_HASH ${GIT_REV_HASH}")
file(WRITE ${CMAKE_CURRENT_SOURCE_DIR}/src/VersionRev.h "${VERSION}")
file(APPEND ${CMAKE_CURRENT_SOURCE_DIR}/src/VersionRev.h "${HASH}")

# qt setting
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

# C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# find pacakge
set(QT5_MIN_VERSION 5.15.0)
find_package(Qt5 REQUIRED COMPONENTS
    Core
    Gui
    Widgets
    Sql
    Multimedia
    Xml
)
find_package(Qt5WebKitWidgets REQUIRED)
find_package(Qt5LinguistTools REQUIRED)
find_package(SQLite3 REQUIRED)
find_package(Qt5 COMPONENTS LinguistTools REQUIRED)

# complier and linker flags
add_compile_options(-Wall -Wextra)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -flto")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -flto")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g3")

# output name
add_executable(${TARGET_NAME})

# target_compile_definitions(${TARGET_NAME} PUBLIC
#     HAVE_QT5
# )

if (WIN32)
    target_compile_definitions(${TARGET_NAME} PUBLIC
        UNICODE
        _UNICODE
        WIN32
    )

    set(CMAKE_EXE_LINKER_FLAGS "-Wl,-subsystem,windows")
    set(CMAKE_CXX_FLAGS "-fno-keep-inline-dllexport")
endif (WIN32)

# libraries
target_link_libraries(${TARGET_NAME}
    Qt::Core
    Qt::Gui
    Qt::Widgets
    Qt::Sql
    Qt::Multimedia
    Qt::Xml
    Qt5::WebKit
    Qt5::WebKitWidgets
    SQLite3
)

# qt resource file
target_sources(${TARGET_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/QuiteRSS.qrc)
target_sources(${TARGET_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/data/ca-bundle.qrc)

# windows resource file
if (WIN32)
    execute_process(COMMAND windres --codepage=65001 -i ${CMAKE_CURRENT_SOURCE_DIR}/QuiteRSSApp.rc -o ${CMAKE_CURRENT_BINARY_DIR}/QuiteRSSApp.o --include-dir=./)
    target_link_libraries(${TARGET_NAME}
        ${CMAKE_CURRENT_BINARY_DIR}/QuiteRSSApp.o
    )
endif (WIN32)

# qt language file
set(LANG_TS
    quiterss_ar
    quiterss_bg
    quiterss_cs
    quiterss_de
    quiterss_el_GR
    quiterss_es
    quiterss_fa
    quiterss_fi
    quiterss_fr
    quiterss_gl
    quiterss_hi
    quiterss_hu
    quiterss_it
    quiterss_ja
    quiterss_ko
    quiterss_lt
    quiterss_nl
    quiterss_pl
    quiterss_pt_BR
    quiterss_pt_PT
    quiterss_ro_RO
    quiterss_ru
    quiterss_sk
    quiterss_sr
    quiterss_sv
    quiterss_tg_TJ
    quiterss_tr
    quiterss_uk
    quiterss_vi
    quiterss_zh_CN
    quiterss_zh_TW
)

add_custom_target(build-time-make-directory ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR}/lang)

foreach(ts ${LANG_TS})
    add_custom_command(
        POST_BUILD
        TARGET ${TARGET_NAME}
        COMMAND lrelease-qt5 ${CMAKE_CURRENT_SOURCE_DIR}/lang/${ts}.ts -qm ${CMAKE_CURRENT_BINARY_DIR}/lang/${ts}.qm
    )
endforeach(ts)

#  source code
add_subdirectory(3rdparty/qtsingleapplication)
add_subdirectory(3rdparty/qupzilla)
add_subdirectory(3rdparty/qftp)
add_subdirectory(3rdparty/sqlitex)
add_subdirectory(src)
