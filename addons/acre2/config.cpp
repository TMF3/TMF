#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: ACRE2";
        author = "Snippers";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common", "acre_main"};
        VERSION_CONFIG;
    };
};

#include "Cfg3DEN.hpp"
#include "CfgEventHandlers.hpp"

/*#include "CfgLoadouts.hpp"*/

#include "display3DEN.hpp"
