#include "script_component.hpp"

class cfgPatches
{
	class ADDON
	{
        name = "TMF: Autotest";
		author = "Snippers";
		url = "http://www.teamonetactical.com";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"tmf_common"};
		VERSION_CONFIG;
	};
};

#include "CfgFunctions.hpp"
#include "Cfg3DEN.hpp"
#include "display3DEN.hpp"