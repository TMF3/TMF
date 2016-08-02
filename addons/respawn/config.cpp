#include "script_component.hpp"

class cfgPatches
{
	class ADDON
	{
        name = "TMF: Respawn";
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
#include "CfgEventHandlers.hpp"

#include "defines.hpp"
#include "dialogs.hpp"