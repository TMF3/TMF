#include "script_component.hpp"

class cfgPatches
{
	class ADDON
	{
        name = "TMF: Spectator";
		author = "Head";
		url = "http://www.teamonetactical.com";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"tmf_common"};
		VERSION_CONFIG;
	};
};
class CfgRespawnTemplates
{
	class TMF_Spectator
	{
		displayName = "Teamwork Spectator";
		onPlayerRespawn  = "tmf_spectator_fnc_init";
		onPlayerKilled = "";
	};
};

class Extended_Fired_Eventhandlers {
    class AllVehicles {
        class GVAR(fired) {
            fired = "if([] call tmf_spectator_fnc_isOpen) then { _this call tmf_spectator_fnc_onFired;};"
        };
    };
};
class Extended_Hit_Eventhandlers {
    class AllVehicles {
        class GVAR(hit) {
            hit = "if([] call tmf_spectator_fnc_isOpen) then {(_this select 0) setVariable ['tmf_spectator_lastDamage',(_this select 1)]};"
        };
    };
};


#include "CfgFunctions.hpp"
#include "dialog.hpp"

#include "Cfg3DEN.hpp"
#include "display3DEN.hpp"
#include "CfgModules.hpp"
#include "CfgEventHandlers.hpp"
