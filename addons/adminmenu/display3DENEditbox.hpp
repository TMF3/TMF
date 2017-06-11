// Overload classes
class RscText;
class RscTitle;
class RscListbox;
class RscControlsGroupNoScrollbars;
class RscPicture;
class RscButtonMenu;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscStandardDisplay;
class RscVignette;
class RscMap;

// Defines
#include "\a3\3den\UI\dikCodes.inc"
#include "\a3\3den\UI\macros.inc"
#include "\a3\3den\UI\macroExecs.inc"
#include "\a3\3den\UI\resincl.inc"


#define MSGBOX_W    100
#define MSGBOX_H    50
#define MSGBOX_X    0.25
#define MSGBOX_Y    0.25

class ctrlDefault;
class ctrlDefaultText;// : ctrlDefault;
class ctrlStatic;// : ctrlDefaultText;
class ctrlListNBox;// : ctrlDefaultText;
class ctrlTree;// : ctrlDefaultText;
class ctrlEdit;// : ctrlDefaultText;
class ctrlToolBox;// : ctrlDefaultText;
class ctrlStaticBackgroundDisableTiles;
class ctrlStaticTitle;
class ctrlStaticBackground;
class ctrlStaticFooter;
class ctrlButtonOK;
class ctrlButtonCancel;
class ctrlStructuredText;
class ctrlCheckbox;

class GVAR(editBox)
{
    idd = -1;
    movingEnable = 0;
    enableSimulation = 1;
    enableDisplay = 1;
    onUnload = "_this call tmf_patrol_fnc_3denPatrol";
    class Controls
    {
        class Back : ctrlStaticBackgroundDisableTiles
        {
            x = SafeZoneX; y = SafeZoneY;
            w = SafeZoneW; h = SafeZoneH;
        };
        class Title: ctrlStaticTitle
        {
            idc = IDC_DISPLAY3DENMSGBOX_TITLE;
            x = (MSGBOX_X);
            y = (MSGBOX_Y);
            w = (MSGBOX_W) * GRID_W;
            h = 5 * GRID_H;
            text = "Patrol generator";
        };
        class Background: ctrlStaticBackground
        {
            idc = IDC_DISPLAY3DENMSGBOX_BACKGROUND;
            x = (MSGBOX_X);
            y = (MSGBOX_Y) + SIZE_M * GRID_H;
            w = (MSGBOX_W) * GRID_W;
            h =  MSGBOX_H * GRID_H;
        };
        class BottomBackground: ctrlStaticFooter
        {
            idc = IDC_DISPLAY3DENMSGBOX_BOTTOMBACKGROUND;
            x = (MSGBOX_X);
            y = (MSGBOX_Y) + (MSGBOX_H * GRID_H);
            w = (MSGBOX_W) * GRID_W;
            h = 5 * GRID_H;
        };
        class ButtonOK: ctrlButtonOK
        {
            idc = 3434;
            x = MSGBOX_X + (MSGBOX_W * 1/3) * GRID_W;
            y = (MSGBOX_Y) + (MSGBOX_H * GRID_H);
            w = (MSGBOX_W * 1/3 - 1) * GRID_W;
            h = 5 * GRID_H;
            onButtonDown = "(ctrlParent (_this select 0)) closeDisplay 1;";
        };
        class ButtonCancel: ctrlButtonCancel
        {
            idc = 3432;
            x = MSGBOX_X + (MSGBOX_W * 2/3) * GRID_W;
            y = (MSGBOX_Y) + (MSGBOX_H * GRID_H);
            w = (MSGBOX_W * 1/3 - 1) * GRID_W;
            h = 5 * GRID_H;
            onButtonDown = "(ctrlParent (_this select 0)) closeDisplay 2;";
        };
        class PatrolShapeLabel : ctrlStructuredText
        {
            x = (MSGBOX_X);
            y = (MSGBOX_Y)+ (SIZE_M) * GRID_H;
            w = (MSGBOX_W) * GRID_W;
            h = 10 * GRID_H;
            text = "Shape of patrol path";
        };
        class PatrolShape : ctrlToolbox
        {
            IDC  = 1337;
            x = (MSGBOX_X);
            y = (MSGBOX_Y)+ (SIZE_M+5) * GRID_H;
            w = (MSGBOX_W) * GRID_W;
            h = 15 * GRID_H;
            rows = 1;
            columns = 2;
            tooltips[] = {
                $STR_3den_attributes_shapetrigger_ellipse,
                $STR_3den_attributes_shapetrigger_rectangle
            };
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            strings[] = {
                "\a3\3DEN\Data\Attributes\Shape\ellipse_ca.paa",
                "\a3\3DEN\Data\Attributes\Shape\rectangle_ca.paa"
            };
            values[] = {0,1};
        };
        class PatrolRadiusLabel : ctrlStructuredText
        {
            x = (MSGBOX_X);
            y = (MSGBOX_Y)+ (SIZE_M+23) * GRID_H;
            w = (MSGBOX_W) * GRID_W;
            h = 5 * GRID_H;
            text = "Radius:";
        };
        class PatrolRadiusText : ctrlEdit
        {
            IDC  = 1338;
            x = (MSGBOX_X)+0.08;
            y = (MSGBOX_Y)+ (SIZE_M+23) * GRID_H;
            w = (MSGBOX_W-14) * GRID_W;
            h = 5 * GRID_H;
            text = "100";
        };
        class PatrolPointsLabel : ctrlStructuredText
        {
            x = (MSGBOX_X);
            y = (MSGBOX_Y)+ (SIZE_M+30) * GRID_H;
            w = (MSGBOX_W) * GRID_W;
            h = 5 * GRID_H;
            text = "Points:";
        };
        class PatrolPointsText : ctrlEdit
        {
            IDC  = 1339;
            x = (MSGBOX_X)+0.08;
            y = (MSGBOX_Y)+ (SIZE_M+30) * GRID_H;
            w = (MSGBOX_W-14) * GRID_W;
            h = 5 * GRID_H;
            text = "8";
        };
        class onRoad : ctrlCheckbox
        {
            IDC  = 1340;
            x = (MSGBOX_X)+0.005;
            y = (MSGBOX_Y)+ (SIZE_M+35) * GRID_H;
            w = 7 * GRID_W;
            h = 7 * GRID_H;
            text = "Yeah";
        };
        class onRoadLabel : ctrlStructuredText
        {
            x = (MSGBOX_X)+0.005+0.04;
            y = (MSGBOX_Y)+ (SIZE_M+35+0.7) * GRID_H;
            w = (MSGBOX_W) * GRID_W;
            h = 5 * GRID_H;
            text = "Force waypoint to road";
        };
    };
};
