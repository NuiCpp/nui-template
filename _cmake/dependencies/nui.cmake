include(FetchContent)
FetchContent_Declare(
	nui
	GIT_REPOSITORY https://github.com/NuiCpp/Nui.git
	GIT_TAG        f0ddf68c72a5b0de65aa2d6f25d53c11c89dba36    
)
FetchContent_MakeAvailable(nui)