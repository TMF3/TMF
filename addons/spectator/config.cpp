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
        displayName = "TMF Spectator";
        onPlayerRespawn  = "tmf_spectator_fnc_init";
        onPlayerKilled = "";
    };
};




#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "Cfg3DEN.hpp"
#include "display3DEN.hpp"
#include "dialog.hpp"
#include "CfgVehicles.hpp"
#include "tags.hpp"
class ctrlStaticBackgroundDisableTiles;
class RscTitles {
    class GVAR(escDisplay) {    
        idd = -1;
        fadein = 0;
        fadeout = 0;
        duration = 1e+011;
        onLoad = "call TMF_spectator_fnc_onLoadTitle";
        class controls {
            class Background : ctrlStaticBackgroundDisableTiles {
                x = safeZoneX;
                y = safeZoneY;
                w = safeZoneW;
                h = safeZoneH;
            };
            class Text : RscText {
                x = (0.5 * safezoneW + safezoneX) - (0.25 * safezoneW);
                y = (0.5 * safezoneH + safezoneY) - (0.15 * safezoneH);
                w = 0.50 * safezoneW;
                h = 0.30 * safezoneH;
                shadow = 2;
                font = "RobotoCondensedBold"
                colorText[] = {1,1,1,1};
                sizeEx = 0.05 * safeZoneW;
                text = "PRESS ENTER TO RETURN TO SPECTATOR";
            };
        };
    };
};

// ,"","","