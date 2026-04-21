target_sources(${PROJECT_NAME} PRIVATE main.cpp main_page.cpp)

target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/frontend/include)

# Link frontend of nui inside of emscripten
target_link_libraries(${PROJECT_NAME} PRIVATE nui-frontend)

set(DEPENDANT_LINK_OPTIONS "")
set(DEPENDANT_COMPILE_OPTIONS "")
set(PARCEL_ARGS "")
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(DEPENDANT_LINK_OPTIONS "-g1")
    set(DEPENDANT_COMPILE_OPTIONS "-g1")
    set(PARCEL_ARGS "--no-optimize")
else()
    set(DEPENDANT_LINK_OPTIONS "-O2")
    set(DEPENDANT_COMPILE_OPTIONS "-O2")
    set(PARCEL_ARGS "--no-source-maps")
endif()

nui_prepare_emscripten_target(
    TARGET
        ${PROJECT_NAME}
    PARCEL_ARGS
        ${PARCEL_ARGS}
    # Provide this argument if you dont want the main application bundled.
    # This can be useful if it gets large and you want to show a load screen.
    # LEAN_INDEX_HTML
    NPM_INSTALL_ARGS
        # --verbose
    PREJS
        ${PREJS_FILE}
    EMSCRIPTEN_LINK_OPTIONS
        -sEXPORTED_FUNCTIONS=_frontendMain
        -sALLOW_MEMORY_GROWTH=1
        -sWASM_BIGINT
        -fexceptions
        ${DEPENDANT_LINK_OPTIONS}
        # or other options, see emscripten docs.
    EMSCRIPTEN_COMPILE_OPTIONS
        -fexceptions
        ${DEPENDANT_COMPILE_OPTIONS}
)
