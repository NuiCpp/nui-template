include(FetchContent)
FetchContent_Declare(
	nui
	GIT_REPOSITORY https://github.com/NuiCpp/Nui.git
	GIT_TAG        7798ba0a9f850c3e519f1d5073b1e58008a8d58f    
)
FetchContent_MakeAvailable(nui)