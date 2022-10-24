include(FetchContent)
FetchContent_Declare(
	nui
	GIT_REPOSITORY https://github.com/NuiCpp/Nui.git
	GIT_TAG        ed62e5ec61a08177660a7d4301eec814a3d1fa78    
)
FetchContent_MakeAvailable(nui)