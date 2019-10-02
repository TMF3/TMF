#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Assign Gear";
        author = "Head [FA], Nick, Snippers";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};
class RscButtonMenu;
class RscDisplayArsenal
{
   class controls
   {
       class TMFexport : RscButtonMenu {
           x ="0.425079 * safezoneW + safezoneX";
           y = "0.951298 * safezoneH + safezoneY";
           w = "0.123399 * safezoneW";
           h ="0.0188041 * safezoneH";
           text = "Export as TMF Role";
           action = "[player,'test'] call tmf_assigngear_fnc_saveRole";
       };
   };
};
#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "CfgLoadouts.hpp"
#include "Cfg3DEN.hpp"
#include "CfgFaceSets.hpp"
#include "display3DEN.hpp"
#include "CfgModules.hpp"
