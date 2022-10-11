cmake_minimum_required(VERSION 3.21)

project(nui-template VERSION 0.1.0)

# Nui Dependency
include(FetchContent)
FetchContent_Declare(
	nui
	GIT_REPOSITORY https://github.com/5cript/Nui.git
	GIT_TAG        a42ab7d5ab6632f352379e5fa5969d368be331ab    
)
FetchContent_MakeAvailable(nui)

add_executable(nui-template)

set(COMMON_OPTIONS -fexceptions -Wall -pedantic-errors -pedantic -fconstexpr-steps=1271242)
set(DEBUG_OPTIONS  -g ${COMMON_OPTIONS})
set(RELEASE_OPTIONS -O3 ${COMMON_OPTIONS})
target_compile_options(nui-template PUBLIC "$<$<CONFIG:DEBUG>:${DEBUG_OPTIONS}>")
target_compile_options(nui-template PUBLIC "$<$<CONFIG:RELEASE>:${RELEASE_OPTIONS}>")

if (EMSCRIPTEN)
	# Link frontend of nui inside of emscripten
	target_link_libraries(nui-template PRIVATE nui-frontend)
  
	nui_prepare_emscripten_target(
		TARGET
			nui-template
		PREJS
			${CMAKE_CURRENT_SOURCE_DIR}/frontend/module.js
		EMSCRIPTEN_LINK_OPTIONS
			-sALLOW_MEMORY_GROWTH=1 # or other options, see emscripten docs.
	)
  
	# Use this to add more source files based on frontend/backend build
	target_sources(nui-template PRIVATE frontend/frontend.cpp)
else()
    # Link backend of nui outside of emscripten
    target_link_libraries(nui-template PRIVATE nui-backend)

    nui_set_target_output_directories(nui-template)

    # Creates a target that is compiled through emscripten. This target becomes the frontend part.
	nui_add_emscripten_target(nui-template
		TARGET
			nui-template
		PREJS 
			${CMAKE_CURRENT_SOURCE_DIR}/frontend/module.js
		SOURCE_DIR
			${CMAKE_SOURCE_DIR}
		CMAKE_OPTIONS
			-DNUI_BUILD_EXAMPLES=off
		# MAKE_OPTIONS
			# VERBOSE=1
	)

	target_sources(nui-template PRIVATE main.cpp)	
endif()