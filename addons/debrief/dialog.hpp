class RscText;
class RscListbox;
class RscControlsGroup;
class IGUIBack;
class RscFrame;
class GVAR(text) : RscText
{
	colorBackground[] = {0.8,0.5,0,1};

};

#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)


class SideGroup: RscControlsGroup
{
	x = 0.206094 * safezoneW + safezoneX;
	y = 0.181124 * safezoneH + safezoneY;
	w = 0.125 * safezoneW;
	h = 0.62 * safezoneH;
	colorBackground[] = {0.4,0.4,0.4,1};
	class controls
	{
		/*
		class Frame: RscFrame
		{
				x = 0.0003 * safezoneW;
				y = 0.00219948 * safezoneH;
				w = (0.125-0.0005) * safezoneW;
				h = 0.6 * safezoneH;
	colorText[] = {0,0,1,1};
			};*/
    class SideName: RscText
    {
      	idc = 100;
      	text = "BLUFOR"; //--- ToDo: Localize;
				style = 0x02;
      	x = 0.0003 * safezoneW;
      	y = 0.00219948 * safezoneH;
				w = (0.120-0.0005) * safezoneW;
      	h = 0.0219914 * safezoneH;
      };
      class UnitCount: RscText
      {
      	idc = 101;
      	text = "Units in AO: 120"; //--- ToDo: Localize;
				x = 0.0003 * safezoneW;
      	y = ((0.0219914 * safezoneH))+(0.00219948 * safezoneH);
				w = (0.120-0.0005) * safezoneW;
      	h = 0.0219914 * safezoneH;
      };
      class UnitKilled: RscText
      {
      	idc = 102;
      	text = "KIA UNITS: 90"; //--- ToDo: Localize;
				x = 0.0003 * safezoneW;
      	y = ((0.0219914 * safezoneH)*2)+(0.00219948 * safezoneH);
				w = (0.120-0.0005) * safezoneW;
      	h = 0.0219914 * safezoneH;
      };
      class RoundsUsed: RscText
      {
      	idc = 103;
      	text = "Rounds expended: 300"; //--- ToDo: Localize;
				x = 0.0003 * safezoneW;
      	y = ((0.0219914 * safezoneH)*3)+(0.00219948 * safezoneH);
				w = (0.120-0.0005) * safezoneW;
      	h = 0.0219914 * safezoneH;
      };
      class GrenadesUsed: RscText
      {
      	idc = 104;
      	text = "Grenades Thrown: 3"; //--- ToDo: Localize;
				x = 0.0003 * safezoneW;
      	y = ((0.0219914 * safezoneH)*4)+(0.00219948 * safezoneH);
				w = (0.120-0.0005) * safezoneW;
      	h = 0.0219914 * safezoneH;
      };
      class Assets: GVAR(text)
      {
      	idc = 105;
      	text = "ASSETS LOST"; //--- ToDo: Localize;
				x = 0.001 * safezoneW;
      	y = ((0.0219914 * safezoneH)*10)+(0.00219948 * safezoneH);
				w = (0.1225) * safezoneW;
      	h = 0.04 * safezoneH;
				style = 0x02;
      };
      class AssetsList: RscListbox
      {
      	idc = 106;
				x = 0.001 * safezoneW;
      	y = ((0.04 * safezoneH))+((0.0219914 * safezoneH)*10)+(0.00219948 * safezoneH);
				w = (0.1225) * safezoneW;
      	h = 0.45 * safezoneH;
      };
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
#define DIALOG_X 0.24875
#define DIALOG_Y 0.1
#define DIALOG_WIDTH 0.5
class GVAR(dialog)
{
	idd = 5454;
  movingEnable = 1;
  enableSimulation = 1;
  enableDisplay = 1;
  fadein = 0;
  fadeout = 0;
  duration = 2147483647;
  class controlsBackground
  {
    class background : IGUIBack
    {
      x = DIALOG_X * safezoneW + safezoneX;
      y = DIALOG_Y * safezoneH + safezoneY;
    	w = DIALOG_WIDTH * safezoneW;
    	h = 0.6 * safezoneW;
      colorBackground[] = {0.2,0.2,0.2,1};
    };
  };
  class controls
  {
      class GVAR(title): GVAR(text)
      {
      	idc = 1000;
      	text = "DEBREIF"; //--- ToDo: Localize;
				x = DIALOG_X * safezoneW + safezoneX;
      	y = DIALOG_Y * safezoneH + safezoneY;
      	w = DIALOG_WIDTH * safezoneW;
      	h = 0.02 * safezoneH;
      };
      class GVAR(missionName): GVAR(text)
      {
      	idc = 1001;
      	text = "MissionName"; //--- ToDo: Localize;
      	x = DIALOG_X * safezoneW + safezoneX;
      	y = 0.16 * safezoneH + safezoneY;
      	w = DIALOG_WIDTH * safezoneW;
      	h = 0.02 * safezoneH;
      };
      class GVAR(roleT): GVAR(text)
      {
      	idc = 1002;
      	text = "Your Role"; //--- ToDo: Localize;
      	x = DIALOG_X * safezoneW + safezoneX;
      	y = 0.12 * safezoneH + safezoneY;
      	w = DIALOG_WIDTH * safezoneW;
      	h = 0.02 * safezoneH;
					style = 0x02;
      };
      class GVAR(role): GVAR(text)
      {
      	idc = 1003;
      	text = "Alpha 1 FTL"; //--- ToDo: Localize;
      	x = DIALOG_X * safezoneW + safezoneX;
      	y = 0.14 * safezoneH + safezoneY;
      	w = DIALOG_WIDTH * safezoneW;
      	h = 0.02 * safezoneH;
				style = 0x02;
      };
      class GVAR(duration): GVAR(text)
      {
      	idc = 1004;
      	text = "Duration:  01:30"; //--- ToDo: Localize;
				x = DIALOG_X * safezoneW + safezoneX;
      	y = DIALOG_Y * safezoneH + safezoneY;
      	w = DIALOG_WIDTH * safezoneW;
      	h = 0.02 * safezoneH;
				style = 0x01;
	      colorBackground[] = {0.2,0.2,0.2,0};
      };
			class GVAR(west) : SideGroup
			{
				x = DIALOG_X * safezoneW + safezoneX;
				y = 0.181124 * safezoneH + safezoneY;
				w = 0.125 * safezoneW;
				h = 0.715 * safezoneH;
				onLoad = "[_this select 0,west] call TMF_debreif_fnc_initSideDisplay;";
			};
			class GVAR(east) : SideGroup
			{
				x = (DIALOG_X+(0.125*1)) * safezoneW + safezoneX;
				y = 0.181124 * safezoneH + safezoneY;
				w = 0.125 * safezoneW;
				h = 0.715 * safezoneH;
			};
			class GVAR(independent) : SideGroup
			{
				x = (DIALOG_X+(0.125*2)) * safezoneW + safezoneX;
				y = 0.181124 * safezoneH + safezoneY;
				w = 0.125 * safezoneW;
				h = 0.715 * safezoneH;
			};
			class GVAR(civilian) : SideGroup
			{
				x = (DIALOG_X+(0.125*3)) * safezoneW + safezoneX;
				y = 0.181124 * safezoneH + safezoneY;
				w = 0.125 * safezoneW;
				h = 0.715 * safezoneH;
			};
  };
};
