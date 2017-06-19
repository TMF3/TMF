class RscText;
class RscTitle: RscText {};
class RscShortcutButton;
class RscButtonMenu: RscShortcutButton {};
class RscButtonMenuCancel: RscButtonMenu {};
class RscButtonMenuOK: RscButtonMenu {};
class RscControlsGroup;
class RscListBox;
class RscListNBox;
class RscCheckBox;
class RscCombo;
class RscLineBreak;

class ADDON
{
	idd = 56100;
	movingEnable = 0;
	enableDisplay = 1;
    enableSimulation = 1;
	
    //onLoad = "uiNamespace setVariable ['tmf_adminMenu_display', _this select 0]; _this spawn tmf_adminMenu_fnc_open;";
    //onUnload = "[false] remoteExec ['tmf_adminMenu_fnc_fpsHandlerServer', 2];";
    //onLoad = QUOTE(uiNamespace setVariable [QGVAR(display), _this select 0]; _this call FUNC(onOpen));
    onLoad = QUOTE(_this call FUNC(onOpen););
    onUnload = QUOTE([false] remoteExec [ARR_2(QUOTE(QFUNC(fpsHandlerServer)), 2)]; uiNamespace setVariable [ARR_2(QUOTE(QGVAR(display)), nil)];);
	class controls
	{
		class Title: RscTitle
		{
			idc = -1;
			text = "TMF Admin Menu";
			style = 0;
			colorBackground[] = {0, 0, 0, 0};
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class TitleRight: Title
		{
			idc = 56105;
			text = "- SFPS";
			style = 1;
			x = "16 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			w = "23 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		
		class TabDashboard: RscButtonMenu
		{
			text = "Dashboard";
			default = 1;
			tooltip = "";
			//onButtonClick = "[_this, 56200] call tmf_adminMenu_fnc_selectTab;";
			onButtonClick = QUOTE([_this, 56200] call FUNC(selectTab));
			colorBackground[] = {0, 0, 0, 0};
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "2.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class TabPlayerManagement: TabDashboard
		{
			text = "Player Management";
			tooltip = "Perform various administrative actions on players";
			//onButtonClick = "[_this, 56300] call tmf_adminMenu_fnc_selectTab;";
			onButtonClick = QUOTE([_this, 56300] call FUNC(selectTab));
			x = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			w = "9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class TabRespawnPlayers: TabDashboard
		{
			text = "Respawn";
			tooltip = "Respawn dead players back in the game";
			//onButtonClick = "[_this, 56400] call tmf_adminMenu_fnc_selectTab;";
			onButtonClick = QUOTE([_this, 56400] call FUNC(selectTab));
			x = "16 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			w = "4.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class TabEndMission: TabDashboard
		{
			text = "End Mission";
			tooltip = "Select and execute a mission ending";
			//onButtonClick = "[_this, 56500] call tmf_adminMenu_fnc_selectTab;";
			onButtonClick = QUOTE([_this, 56500] call FUNC(selectTab));
			x = "20.9 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			w = "5.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		
		class ButtonClose: RscButtonMenu
		{
			idc = 56999999;
			text = "Close";
			//onButtonClick = "(uiNamespace getVariable ['tmf_adminMenu_display', displayNull]) closeDisplay 1; false";
			onButtonClick = QUOTE((uiNamespace getVariable [QGVAR(display), displayNull]) closeDisplay 1; false);
			x = "35.9 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "24.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "3.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class GroupBase: RscControlsGroup 
		{
			x = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "0";
			h = "0";
			class Controls {};
		};
		
		class GroupDashboard: GroupBase 
		{
			idc = 56200;
			w = "37.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "20.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			#include "dashboard.hpp"
		};
		
		class GroupPlayerManagement: GroupBase 
		{
			idc = 56300;
			w = "37.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "20.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			#include "playerManagement.hpp"
		};
		
		class GroupRespawn: GroupBase 
		{
			idc = 56400;
			w = "37.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "20.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			#include "respawn.hpp"
		};
		
		class GroupEndMission: GroupBase
		{
			idc = 56500;
			w = "37.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "20.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			#include "endMission.hpp"
		};
	};
	
	class ControlsBackground
	{
		class TitleBackground: RscText
		{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "38 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class TabsBackgroundLeft: TitleBackground
		{
			colorBackground[] = {0, 0, 0, 1};
			y = "2.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		};
		
		class MainBackground: TabsBackgroundLeft
		{
			colorBackground[] = {0, 0, 0, 0.7};
			y = "3.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			h = "20.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};