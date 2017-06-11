class RscText;
class RscTitle: RscText {};
class RscShortcutButton;
class RscButtonMenu: RscShortcutButton {};
class RscButtonMenuCancel: RscButtonMenu {};
class RscButtonMenuOK: RscButtonMenu {};
class RscControlsGroup;

class ADDON
{
	idd = 56100;
	movingEnable = 0;
	enableDisplay = 1;
    enableSimulation = 1;
	
    onLoad = "systemChat str ['adminMenu load', _this];";
    onUnload = "systemChat str ['adminMenu unload', _this];";
	
	class controls
	{
		class Title: RscTitle //title left
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
		
		class PlayersName: Title // title right
		{
			idc = 56105;
			text = "right";
			style = 1;
			x = "16 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			w = "23 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		
		class TabDashboard: RscButtonMenu
		{
			idc = 56102;
			text = "Dashboard";
			tooltip = "";
			colorBackground[] = {0, 0, 0, 0};
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "2.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class TabEndMission: TabDashboard
		{
			idc = 56103;
			text = "End Mission";
			tooltip = "Select and execute a mission ending";
			x = "9 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
		};
		
		class TabRespawnPlayers: TabDashboard
		{
			idc = 56104;
			text = "Respawn";
			tooltip = "Respawn dead players back in the game";
			x = "17 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
		};
		
		class ButtonClose: RscButtonMenu
		{
			idc = 56101;
			text = "Close";
			action = "closeDialog 1;";
			x = "32.75 *(((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "24.1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "6.25 *(((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class GroupBase: RscControlsGroup 
		{
			idc = -1;
			enabled = 0;
			colorBackground[] = {0, 0, 0, 0};
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "38 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class Controls {};
		};
		
		class GroupDashboard: GroupBase 
		{
			idc = 56200;
			class Controls
			{
				#include "dashboard.hpp"
			};
		};
		
		class GroupEndMission: GroupBase
		{
			idc = 56300;
			class Controls
			{
				#include "endMission.hpp"
			};
		};
		
		class GroupRespawn: GroupBase 
		{
			idc = 56400;
			class Controls
			{
				#include "respawn.hpp"
			};
		};
	};
	
	class ControlsBackground
	{
		class TitleBackground: RscText
		{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "38 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class TabsBackgroundLeft: TitleBackground
		{
			idc = -1;
			colorBackground[] = {0, 0, 0, 1};
			y = "2.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
		};
		
		class MainBackground: TabsBackgroundLeft
		{
			idc = -1;
			colorBackground[] = {0, 0, 0, 0.7};
			y = "3.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			h = "20.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};