#include "script_component.hpp"

class cfgPatches
{
	class ADDON
	{
        name = "TMF: Team colour";
		author = "Nick";
		url = "http://www.teamonetactical.com";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"tmf_common"};
		VERSION_CONFIG;
	};
};

#include "CfgEventHandlers.hpp"
#include "Cfg3DEN.hpp"