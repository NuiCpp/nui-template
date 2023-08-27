include(FetchContent)
FetchContent_Declare(
	nui
	GIT_REPOSITORY https://github.com/NuiCpp/Nui.git
	GIT_TAG        91b75fa48a75927c4094eefd65be543fcbf2255e    
)
FetchContent_MakeAvailable(nui)