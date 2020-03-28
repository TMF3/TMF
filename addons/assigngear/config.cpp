#include "script_component.hpp"
#include "\a3\3den\UI\macros.inc"
#include "\a3\3DEN\UI\macroexecs.inc"

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
class RscStandardDisplay;
class RscText;
class RscTitle;
class RscCombo;
class RscButtonMenu;
class RscButtonMenuCancel: RscButtonMenu {};
class RscButtonMenuOK: RscButtonMenu {};
class RscBackgroundGUI;
class RscBackgroundGUITop;
class RscPicture;
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
#include "CfgRemoteExec.hpp"
#include "display3DEN.hpp"
#include "gui\gearSelector.hpp"
