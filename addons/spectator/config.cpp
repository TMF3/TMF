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



#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "Cfg3DEN.hpp"
#include "display3DEN.hpp"

#include "dialog.hpp"

#include "CfgModules.hpp"



class GVAR(EntityTag): RscControlsGroup
{
	idc = -1;
	x = 0 * safezoneW + safezoneX;
	y = 0 * safezoneH + safezoneY;
	w = 0.05 * safezoneW;
	h = 0.06 * safezoneH;
	class controls
	{
		class GVAR(Icon): RscPicture
		{
			idc = 1;
			text = "\A3\ui_f\data\map\markers\military\triangle_CA.paa";
			x = 0 * safezoneW;
			y = 0 * safezoneH;
			w = 0.05 * safezoneW;
			h = 0.02 * safezoneH;
            style = 48 + 0x800 + 0x02; // picture + no stretch + center (not sure if works)
			sizeEx = 0.1 * GUI_GRID_H;
		};
		class GVAR(Name): RscText
		{
			idc = 2;
			text = "Head"; //--- ToDo: Localize;
            style = 0x02; // single + center align
            colorBackground[] = { 1, 1, 1, 0 };
    		colorText[] = { 1, 1, 1, 1 };
			x = 0.00 * safezoneW;
			y = 0.02 * safezoneH;
			w = 0.05 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.018 * safeZoneH;
		};
		class GVAR(Detail): GVAR(Name)
		{
			idc = 3;
			text = "Alpha 1"; //--- ToDo: Localize;
			x = 0.00 * safezoneW;
			y = 0.04 * safezoneH;
			w = 0.05 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.013 * safeZoneH;
		};
	};
};
