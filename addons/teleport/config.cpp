#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Teleport";
        author = "Head";
        url = "http://www.teamonetactical.com";
        units[] = {QGVAR(module),QGVAR(deploy)};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgModules.hpp"


class CfgWaypoints
{
    class Teamwork
    {
        displayName = "TMF";
        class Paradrop
        {
            displayName = "Paradrop";
            file = "\x\tmf\addons\teleport\functions\fnc_paradropWaypoint.sqf";
            icon = "\a3\air_f_beta\Parachute_01\Data\UI\map_parachute_01_ca.paa";
            class Attributes
            {
            };
        };
    };
};
