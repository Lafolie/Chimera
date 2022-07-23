workspace "Chimera"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Ship"
	}

outDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-------------------------------------------------------------------------------
-- ENGINE
-------------------------------------------------------------------------------

project "Chimera"
	location "Chimera"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++20"
	staticruntime "off"

	targetdir("bin/" .. outDir .. "/%{prj.name}")
	objdir("build/" .. outDir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	-- include
	-- {

	-- }

	filter "system.windows"
		staticruntime "on"
		systemversion "latest"

		defines
		{
			"CHIMERA_PLATFORM_WINDOWS",
			"CHIMERA_BUILD_DLL"
			-- "_WINDLL"
		}

		postbuildcommands
		{
			"{copy} %{cfg.buildtarget.relpath} ../bin/" .. outDir .. "/Sandbox"
		}

	filter "configurations:Debug"
		defines "CHIMERA_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "CHIMERA_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Ship"
		defines "CHIMERA_SHIP"
		runtime "Release"
		optimize "On"