
class RscText;
class RscShortcutButton;
class RscMapControl;
class RscTree;
class RscControlsGroup;
class IGUIBack;
class RscButtonMenuOK;
class RscTitle;
class RscStructuredText;
class RscDebugConsole;
class RscProgress;
class RscPicture;

class RscSpectatorText : RscText
{
  type = 0;
  style = 0x02;
  shadow = 1;
};
class RscSpectatorShortcutButton : RscPicture
{
    type = 1;
    shadow = 0;
    colorBorder[] = {0,0,0,1};
    borderSize = 0;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    colorText[] = {1,1,1,1};
    colorFocused[] = {1,1,1,1};
    colorShadow[] = {1,1,1,1};
    colorDisabled[] = {0,0,0,1};
    colorBackground[] = {0,0,0,1};
    colorBackgroundDisabled[] = {0,0,0,1};
    colorBackgroundActive[] = {0,0,0,1};

    soundEnter[] = { "", 0, 1 };  // no sound
    soundPush[] = { "buttonpushed.ogg", 0.1, 1 };
    soundClick[] = { "", 0, 1 };  // no sound
    soundEscape[] = { "", 0, 1 };  // no sound
};

class RscXSliderH;
#define SETTINGS_WDITH 0.2 * safezoneW
#define SETTINGS_HEIGHT 0.5 * safezoneH
#define ROW(A) ((0.022) *safezoneH)+(((0.025) *safezoneH)*A)
class GVAR(settingControl) : RscControlsGroup
{
  x = 0.632322 * safezoneW + safezoneX;
  y = 0.225 * safezoneH + safezoneY;
  w = SETTINGS_WDITH;
  h = SETTINGS_HEIGHT;
    onLoad = "_this call tmf_spectator_fnc_onLoadSettings;";
  class Controls
  {
    class background : IGUIBACK
    {
        x = 0;
        y = 0;
        colorBackground[] = {0,0,0,0.7};
        w = SETTINGS_WDITH;
        h = SETTINGS_HEIGHT;
    }
    class title : RscTitle
    {
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
      text = "Settings"; //--- ToDo: Localize;
      x = 0;
      y = 0;
      w = SETTINGS_WDITH;
      h = 0.022 * safezoneH;
    };
        class camSpeedTitle : RscTitle
        {
            text = "Free camera speed"; //--- ToDo: Localize;
            x = 0;
            y = ROW(0);
            w = 0.19 * safezoneW;
            h = 0.022 * safezoneH;
        };
        class camSpeedSlider : RscXSliderH
        {
            idc = 100;
            x = 0;
            y = ROW(1);
            w = 0.2 * safezoneW;
            h = 0.022 * safezoneH;
            onSliderPosChanged = "hint format[""%1"",_this];";
        };
        class grpTagTitle : RscTitle
        {
            text = "Group tag size modifier"; //--- ToDo: Localize;
            x = 0;
            y = ROW(2);
            w = 0.19 * safezoneW;
            h = 0.022 * safezoneH;
        };
        class grpTagSlider : RscXSliderH
        {
            idc = 101;
            x = 0;
            y = ROW(3);
            w = 0.2 * safezoneW;
            h = 0.022 * safezoneH;
            onSliderPosChanged = "hint format[""%1"",_this];";
        };
        class unitTagTitle : RscTitle
        {
            text = "Unit tag size modifier"; //--- ToDo: Localize;
            x = 0;
            y = ROW(4);
            w = 0.19 * safezoneW;
            h = 0.022 * safezoneH;
        };
        class unitTagSlider : RscXSliderH
        {
            idc = 102;
            x = 0;
            y = ROW(5);
            w = 0.2 * safezoneW;
            h = 0.022 * safezoneH;
        };
  };
}











//--- Spectator
#define IDC_SPECTATOR_TMF_SPECTATOR_UNITLABEL  4945
#define IDC_SPECTATOR_TMF_SPECTATOR_UNITLIST  7171
#define IDC_SPECTATOR_TMF_SPECTATOR_VISION  5545
#define IDC_SPECTATOR_TMF_SPECTATOR_FILTER  5546
#define IDC_SPECTATOR_TMF_SPECTATOR_BUTTON  5547
#define IDC_SPECTATOR_TMF_SPECTATOR_TAGS  5548
#define IDC_SPECTATOR_TMF_SPECTATOR_VIEW  5549
#define IDC_SPECTATOR_TMF_SPECTATOR_COMPASS    5453
#define IDC_SPECTATOR_TMF_SPECTATOR_COMPASSLEFT    5454
#define IDC_SPECTATOR_TMF_SPECTATOR_COMPASSRight    5455
#define IDC_SPECTATOR_TMF_SPECTATOR_NOTIFICATION    5465
#define IDC_SPECTATOR_TMF_SPECTATOR_MUTE 5467
#define IDC_SPECTATOR_TMF_SPECTATOR_MAP 5468
#define IDC_SPECTATOR_TMF_SPECTATOR_SPEED_TEXT 5480
#define IDC_SPECTATOR_TMF_SPECTATOR_SPEED_BAR 5481
#define BUTTON_WIDTH 0.02 * safezoneW
#define BUTTON_HEIGHT 0.031 * safezoneH
#define COLUMN(V) (0.002 * safezoneW + safezoneX)+((0.0215 * safezoneW)  * V)

class tmf_spectator_dialog
{
  idd = 5454;
  movingEnable = 1;
  enableSimulation = 1;
  enableDisplay = 1;
  fadein = 0;
  fadeout = 0;
  duration = 2147483647;
  type = 0;
  controlsBackground[] = {TMF_SPECTATOR_MOUSE,TMF_SPECTATOR_UNITLABEL,TMF_SPECTATOR_Compass,TMF_SPECTATOR_CompassLeft,TMF_SPECTATOR_CompassRight,TMF_SPECTATOR_NOTIFICATION,TMF_SPECTATOR_SPEED,TMF_SPECTATOR_BAR,TMF_SPECTATOR_KILLLIST};
  onKeyDown = "[0,_this] call tmf_spectator_fnc_keyhandler";
  onKeyUp= "[1,_this] call tmf_spectator_fnc_keyhandler";
  onLoad = "_this call tmf_spectator_fnc_onLoad";
  onUnload = "TMF_spectator_camera cameraEffect ['TERMINATE','BACK']";
  class TMF_SPECTATOR_KILLLIST: RscControlsGroup
  {
  	idc = 2300;
  	x = 0.763544 * safezoneW + safezoneX;
  	y = 0 * safezoneH + safezoneY;
  	w = 0.233576 * safezoneW;
  	h = (0.020*6.5) * safezoneH;
    colorBackground[] = {0,0,0,0};
  	class controls
  	{
          class Label1: RscStructuredText
          {
            idc = 1;
            x = 0.00352533 * safezoneW;
            y = 0.005 * safezoneH;
            w = 0.230 * safezoneW;
            h = 0.020 * safezoneH;
            colorBackground[] = {0,0,0,0.0};
            text = "";
            style = 0x01;
            class Attributes {
              align = "right";
              valign = "middle";
            };
          };
          class Label2: Label1
          {
              idc = 2;
              x = 0.00352533 * safezoneW;
              y = (0.005+(0.020*1)) * safezoneH;
              w = 0.230 * safezoneW;
        	  h = 0.020 * safezoneH;
              colorBackground[] = {0,0,0,0.0};
              text = "";
          };
          class Label3: Label1
          {
              idc = 3;
              x = 0.00352533 * safezoneW;
              y = (0.005+(0.020*2)) * safezoneH;
              w = 0.230 * safezoneW;
              h = 0.020 * safezoneH;
              colorBackground[] = {0,0,0,0.0};
              text = "";
          };
          class Label4: Label1
          {
              idc = 4;
              x = 0.00352533 * safezoneW;
              y = (0.005+(0.020*3)) * safezoneH;
              w = 0.230 * safezoneW;
        	  h = 0.020 * safezoneH;
              colorBackground[] = {0,0,0,0.0};
              text = "";
          };
          class Label5: Label1
          {
              idc = 5;
              x = 0.00352533 * safezoneW;
              y = (0.005+(0.020*4)) * safezoneH;
              w = 0.230 * safezoneW;
        	  h = 0.020 * safezoneH;
              colorBackground[] = {0,0,0,0.0};
              text = "";
          };
          class Label6: Label1
          {
              idc = 6;
              x = 0.00352533 * safezoneW;
              y = (0.005+(0.020*5)) * safezoneH;
              w = 0.230 * safezoneW;
        	  h = 0.020 * safezoneH;
              colorBackground[] = {0,0,0,0.0};
              text = "";
          };
  	};
  };
  class TMF_SPECTATOR_UNITLABEL: RscSpectatorText
  {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_UNITLABEL;
    text = "Arnold McFuckFace"; //--- ToDo: Localize;
    x = (0.50-0.15/2) * safezoneW + safezoneX;
    y = 0.025 * safezoneH + safezoneY;
    w = 0.15 * safezoneW;
    h = 0.020 * safezoneH;
    font = "PuristaSemiBold";
  };
  class TMF_SPECTATOR_Compass: RscSpectatorText
  {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_COMPASS;
    text = "NW"; //--- ToDo: Localize;
    x = (0.5-(0.07/2)) * safezoneW + safezoneX;
    y = 0.005* safezoneH + safezoneY;
    w = 0.07 * safezoneW;
    h = 0.015 * safezoneH;
    font = "PuristaBold";
  };
  class TMF_SPECTATOR_CompassLeft: RscSpectatorText
  {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_COMPASSLEFT;
    text = "NW"; //--- ToDo: Localize;
    x = (0.5-(0.14)/2) * safezoneW + safezoneX;
    y = 0.005 * safezoneH + safezoneY;
    w = 0.07 * safezoneW;
    h = 0.015 * safezoneH;
    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
    colorText[] =
    {
      1,
      1,
      1,
      0.7
    };
    font = "PuristaBold";
  };
  class TMF_SPECTATOR_CompassRight: RscSpectatorText
  {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_COMPASSRight;
    text = "NE"; //--- ToDo: Localize;
    x = (0.5) * safezoneW + safezoneX;
    y = 0.005 * safezoneH + safezoneY;
    w = 0.07 * safezoneW;
    h = 0.015 * safezoneH;
    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
    colorText[] =
    {
      1,
      1,
      1,
      0.7
    };
    font = "PuristaBold";
  };

  class TMF_SPECTATOR_SPEED: RscSpectatorText
  {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_SPEED_TEXT;
    text = "CAMERA SPEED"; //--- ToDo: Localize;
    x = 0.45 * safezoneW + safezoneX;
    y = 0.9 * safezoneH + safezoneY;
    w = 0.1 * safezoneW;
    h = 0.015 * safezoneH;
    font = "PuristaSemiBold";
  };

  class TMF_SPECTATOR_BAR: RscProgress
  {
      colorFrame[] = {0,0,0,0};
      colorBar[] = {1,1,1,1};
      texture = "#(argb,8,8,3)color(1,1,1,1)";
      idc = IDC_SPECTATOR_TMF_SPECTATOR_SPEED_BAR;
      x = (0.50-0.15/2) * safezoneW + safezoneX;
      y = 0.93 * safezoneH + safezoneY;
      w = 0.15 * safezoneW;
      h = 0.015 * safezoneH;
  };

  class TMF_SPECTATOR_NOTIFICATION: RscSpectatorText
  {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_NOTIFICATION;
    text = ""; //--- ToDo: Localize;
    x = COLUMN(6);
    y = 0.00719998 * safezoneH + safezoneY;
    w = 0.135 * safezoneW;
    h = BUTTON_HEIGHT;
    style = 0;
    font = "PuristaBold";
    colorBackground[] = {0,0,0,0.8};
  };
  class controls {
    class TMF_SPECTATOR_FILTER: RscSpectatorShortcutButton
    {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_FILTER;
      x = COLUMN(1);
      y = 0.002 * safezoneH + safezoneY;
      w = BUTTON_WIDTH;
      h = BUTTON_HEIGHT;
      onButtonDown = "['disableAI',_this] call tmf_spectator_fnc_menuhandler;";
      text = "\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayerSetup\enabledai_ca.paa";
      tooltip = "PLAYERS + AI";
    };
    class TMF_SPECTATOR_BUTTON: RscSpectatorShortcutButton
    {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_BUTTON;
      x = COLUMN(0);
      y = 0.002 * safezoneH + safezoneY;
      w = BUTTON_WIDTH;
      h = BUTTON_HEIGHT;
      text = "\x\tmf\addons\spectator\images\flag_civil_empty_ca_64.paa";
      onButtonDown = "['sidefilter',_this] call tmf_spectator_fnc_menuhandler;";
      tooltip = "SHOWING ALL SIDES";
    };
    class TMF_SPECTATOR_TAGS: RscSpectatorShortcutButton
    {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_TAGS;
      x = COLUMN(3);
      y = 0.002 * safezoneH + safezoneY;
      w = BUTTON_WIDTH;
      h = BUTTON_HEIGHT;
      text = "\A3\ui_f\data\map\Diary\textures_ca.paa";
      onButtonDown = "['tags',_this] call tmf_spectator_fnc_menuhandler;";
      tooltip = "DISABLE TAGS";
    };
    class TMF_SPECTATOR_VISION: RscSpectatorShortcutButton
    {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_VISION;
      x = COLUMN(4);
      y = 0.002 * safezoneH + safezoneY;
      w = BUTTON_WIDTH;
      h = BUTTON_HEIGHT;
      onButtonDown = "['vision',_this] call tmf_spectator_fnc_menuhandler;";
      text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\nvgs_ca.paa";
      tooltip = "CHANGE VISION MODE";
    };
    class TMF_SPECTATOR_VIEW: RscSpectatorShortcutButton
    {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_VIEW;
      onButtonDown = "['camera',_this] call tmf_spectator_fnc_menuhandler;";
      x = COLUMN(2);
      y = 0.002 * safezoneH + safezoneY;
      w = BUTTON_WIDTH;
      h = BUTTON_HEIGHT;
      text = "\A3\ui_f\data\IGUI\Cfg\IslandMap\iconcamera_ca.paa";
      tooltip = "SWITCH TO FIRST PERSON";
    };
    class TMF_SPECTATOR_MUTE: RscSpectatorShortcutButton
    {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_MUTE;
      onButtonDown = "['mute',_this] call tmf_spectator_fnc_menuhandler;";
      x = COLUMN(5);
      y = 0.002 * safezoneH + safezoneY;
      w = BUTTON_WIDTH;
      h = BUTTON_HEIGHT;
      text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\voice_ca.paa";
      tooltip = "MUTE SPECTATORS";
    };
    class TMF_SPECTATOR_MAP : RscMapControl
    {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_MAP;
      x = 0 * safezoneW + safezoneX;
      y = 0 * safezoneH + safezoneY;
      w = 1 * safezoneW;
      h = 1 * safezoneH;
      onDraw = "_this call tmf_spectator_fnc_drawmap";
      onMouseButtonDown = "_this call tmf_spectator_fnc_onMapClick;";
    };
    class TMF_SPECTATOR_UNITLIST: RscTree
    {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_UNITLIST;
      x = 0.002 * safezoneW + safezoneX;
      y = 0.038 * safezoneH + safezoneY;
      w = 0.13 * safezoneW;
      h = 0.940001 * safezoneH;
      shadow = 2;
      colorBackground[] = {0,0,0,0};
      disableKeyboardSearch = 1;


      colorSelectText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 0)


      onTreeSelChanged = "_this call tmf_spectator_fnc_onChange";
      multiselectEnabled = 0;
      //onMouseZChanged = "[""MouseZChanged"",_this] call tmf_spectator_fnc_mouseHandler";
      // Scrollbar configuration
      class ScrollBar
      {
        width = 0; // width of ScrollBar
        height = 0; // height of ScrollBar
        scrollSpeed = 0.01; // scroll speed of ScrollBar

        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

        color[] = {1,1,1,0}; // Scrollbar color
      };
      maxHistoryDelay = 99999999999999999999999999999999999999999999999; // Time since last keyboard type search to reset it
    };
  };
  class TMF_SPECTATOR_MOUSE: RscControlsGroup {
      class ListScrollBar
      {
          color[] = {1,1,1,0.6};
          colorActive[] = {1,1,1,1};
          colorDisabled[] = {1,1,1,0.0};
          thumb = "";
          arrowFull = "";
          arrowEmpty = "";
          border = "";
      };
      onMouseButtonDown = "[""MouseButtonDown"",_this] call tmf_spectator_fnc_mouseHandler";
      onMouseButtonUp = "[""MouseButtonUp"",_this] call tmf_spectator_fnc_mouseHandler";
      onMouseZChanged = "[""MouseZChanged"",_this] call tmf_spectator_fnc_mouseHandler";
      onMouseMoving = "['MouseMoving',_this] call tmf_spectator_fnc_mouseHandler";
      idc = 123;
      x = SafeZoneX; y = SafeZoneY;
      w = SafeZoneW; h = SafeZoneH;
      colorBackground[] = {0.2, 0.0, 0.0, 0.0};
  };

};

#define HELP_WIDTH 0.2 * safezoneW
#define HELP_HEIGHT  0.478 * safezoneH

class tmf_spectator_exit
{
  idd = 5454;
  movingEnable = 1;
    enableSimulation = 1;
    enableDisplay = 1;
    onLoad = "['onLoad',_this] spawn tmf_spectator_fnc_escmenuHandler;";
//    onUnload = "['onUnload',_this] spawn tmf_spectator_fnc_escmenuHandler;"; // disabled, ate all the data for debug console
    class controlsBackground {
    class windowBackground: IGUIBack
      {
        idc = 2201;
        x = 0.4 * safezoneW + safezoneX;
        y = 0.225 * safezoneH + safezoneY;
        w = HELP_WIDTH;
        h = HELP_HEIGHT;
        colorBackground[] = {0,0,0,0.7};
      };
    };
  class controls {
    class AbortSpectator: RscButtonMenuOK
    {
      idc = 3424324;
      text = "Lobby"; //--- ToDo: Localize;
      x = 0.4 * safezoneW + safezoneX;
      y = (0.705) * safezoneH + safezoneY;
      w = 0.098 * safezoneW;
      h = 0.022 * safezoneH;
      sizeEx = (      (      (      ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * GUI_GRID_H;
      onButtonClick = "['abortClicked',_this] spawn tmf_spectator_fnc_escmenuHandler;";
    };
    class ContinueSpectator: RscButtonMenuOK
    {
      idc = 4234234;
      text = "Continue"; //--- ToDo: Localize;
      x = 0.5 * safezoneW + safezoneX;
      y = (0.705) * safezoneH + safezoneY;
      w = 0.1 * safezoneW;
      h = 0.022 * safezoneH;
      sizeEx = (      (      (      ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * GUI_GRID_H;
      onButtonClick = "['continueClicked',_this] spawn tmf_spectator_fnc_escmenuHandler;";

    };
    class Title: RscTitle
    {
      idc = 1000;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
      text = "Spectator"; //--- ToDo: Localize;
      x = 0.4 * safezoneW + safezoneX;
      y = 0.225 * safezoneH + safezoneY;
      w = 0.2 * safezoneW;
      h = 0.022 * safezoneH;
    };
    class InfoText: RscStructuredText
    {
      idc = 1100;
      x = 0.4 * safezoneW + safezoneX;
      y = 0.247 * safezoneH + safezoneY;
      w = HELP_WIDTH;
      h = 0.450 * safezoneH;
      text = "Hey there!";
    };
    class Debug : RscDebugConsole
    {
      x = 0.0306637 * safezoneW + safezoneX;
      y = 0.225 * safezoneH + safezoneY;
      w = 0.30 * safezoneW;
      h = 0.55 * safezoneH;
    };

    class Settings : GVAR(settingControl)
    {
    }
  };
};
