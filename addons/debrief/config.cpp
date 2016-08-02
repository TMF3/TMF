#include "script_component.hpp"

class cfgPatches
{
	class ADDON
	{
        name = "TMF: Debrief";
		author = "Head";
		url = "http://www.teamonetactical.com";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"tmf_common"};
		VERSION_CONFIG;
	};
};

#include "dialog.hpp"
#include "CfgFunctions.hpp"
