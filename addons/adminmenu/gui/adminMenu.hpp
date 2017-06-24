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
class RscEdit;
class RscPicture;
class RscToolbox;

class GVAR(RscButtonMenu): RscButtonMenu {
	style = "0x02 + 0x0C";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
	h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};

class ADDON
{
	idd = IDD_TMF_ADMINMENU;
	movingEnable = 0;
	enableDisplay = 1;
    enableSimulation = 1;
	
    onLoad = QUOTE(_this call FUNC(onLoad););
    onUnload = QUOTE([false] remoteExec [ARR_2(QUOTE(QFUNC(fpsHandlerServer)),2)]; uiNamespace setVariable [ARR_2(QUOTE(QGVAR(display)),nil)];);
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
		
		class TitleFPS: Title
		{
			idc = IDC_TMF_ADMINMENU_FPS;
			text = "";
			style = 1;
			x = "16 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			w = "23 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		
		class TabDashboard: RscButtonMenu
		{
			idc = IDC_TMF_ADMINMENU_DASH;
			text = "Dashboard";
			tooltip = "";
			onButtonClick = QUOTE([ARR_2(ctrlParent param [0],IDC_TMF_ADMINMENU_G_DASH)] call FUNC(selectTab));
			colorBackground[] = {0, 0, 0, 0};
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "2.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class TabPlayerManagement: TabDashboard
		{
			idc = IDC_TMF_ADMINMENU_PMAN;
			text = "Player Management";
			tooltip = "Perform actions on players";
			onButtonClick = QUOTE([ARR_2(ctrlParent param [0],IDC_TMF_ADMINMENU_G_PMAN)] call FUNC(selectTab));
			x = "6.9 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			w = "9 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class TabRespawnPlayers: TabDashboard
		{
			idc = IDC_TMF_ADMINMENU_RESP;
			text = "Respawn";
			tooltip = "Respawn dead players back in the game";
			onButtonClick = QUOTE([ARR_2(ctrlParent param [0],IDC_TMF_ADMINMENU_G_RESP)] call FUNC(selectTab));
			x = "16 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			w = "4.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class TabEndMission: TabDashboard
		{
			idc = IDC_TMF_ADMINMENU_ENDM;
			text = "End Mission";
			tooltip = "Select and execute a mission ending";
			onButtonClick = QUOTE([ARR_2(ctrlParent param [0],IDC_TMF_ADMINMENU_G_ENDM)] call FUNC(selectTab));
			x = "20.9 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			w = "5.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
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
			idc = IDC_TMF_ADMINMENU_G_DASH;
			w = "37.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "20.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			#include "dashboard.hpp"
		};
		
		class GroupPlayerManagement: GroupBase 
		{
			idc = IDC_TMF_ADMINMENU_G_PMAN;
			w = "37.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "20.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			#include "playerManagement.hpp"
		};
		
		class GroupRespawn: GroupBase 
		{
			idc = IDC_TMF_ADMINMENU_G_RESP;
			w = "37.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "20.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			#include "respawn.hpp"
		};
		
		class GroupEndMission: GroupBase
		{
			idc = IDC_TMF_ADMINMENU_G_ENDM;
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