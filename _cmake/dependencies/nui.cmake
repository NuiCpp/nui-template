include(FetchContent)
FetchContent_Declare(
	nui
	GIT_REPOSITORY https://github.com/NuiCpp/Nui.git
	GIT_TAG        v0.11.1
)
FetchContent_MakeAvailable(nui)