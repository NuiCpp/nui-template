include(FetchContent)
FetchContent_Declare(
	nui
	GIT_REPOSITORY https://github.com/NuiCpp/Nui.git
	GIT_TAG        64b47ecf9ea522c7d82b6e7b64eb8c3329f27cc0    
)
FetchContent_MakeAvailable(nui)