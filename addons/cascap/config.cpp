#include "script_component.hpp"

class cfgPatches
{
	class ADDON
	{
        name = "TMF: Casualty Cap";
		author = "Nick";
		url = "http://www.teamonetactical.com";
		units[] = {QGVAR(module)};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"tmf_common"};
		VERSION_CONFIG;
	};
};

#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"