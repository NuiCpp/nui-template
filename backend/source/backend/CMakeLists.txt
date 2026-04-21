target_sources(${PROJECT_NAME} PRIVATE main.cpp)

target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/backend/include)

# Link backend of nui outside of emscripten
target_link_libraries(${PROJECT_NAME} PRIVATE nui-backend)

nui_set_target_output_directories(${PROJECT_NAME})

# Creates a target that is compiled through emscripten. This target becomes the frontend part.
nui_add_emscripten_target(
    TARGET
        ${PROJECT_NAME}
    PREJS
        ${PREJS_FILE}
    SOURCE_DIR
        ${CMAKE_SOURCE_DIR}
    CMAKE_OPTIONS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)

set(NUI_TEMPLATE_GENERATED_INDEX_HPP
    "${CMAKE_BINARY_DIR}/module_${PROJECT_NAME}/include/index.hpp")
set(NUI_TEMPLATE_GENERATED_INDEX_HTML
    "${CMAKE_BINARY_DIR}/module_${PROJECT_NAME}/bin/index.html")

set_source_files_properties(
    main.cpp
    PROPERTIES
        OBJECT_DEPENDS "${NUI_TEMPLATE_GENERATED_INDEX_HPP}"
)

target_sources(${PROJECT_NAME} PRIVATE "${NUI_TEMPLATE_GENERATED_INDEX_HTML}")
