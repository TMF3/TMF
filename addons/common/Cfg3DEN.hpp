#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\resincl.inc"

class Cfg3DEN
{
    class Mission
    {
        class TMF_Settings
        {
            displayName = "TMF Settings";
            class AttributeCategories
            {
                class Debug
                {
                    displayName = "Debug Settings";
                    collapsed = 0;
                    class Attributes
                    {
                        class TMF_Debug_Enabled
                        {
                            property = "TMF_Debug_Enabled";
                            displayName = "Debug Enabled";
                            tooltip = "Toggle debug mode.";
                            control = "Checkbox";
                            expression = "true";
                            defaultValue = "true";
                            condition = "true";
                        };
                        class TMF_Debug_Diag_log
                        {
                            property = "TMF_Debug_Diag_log";
                            displayName = "Log to RPT";
                            tooltip = "Log errors in the ARMA .rpt file.";
                            control = "Checkbox";
                            expression = "true";
                            defaultValue = "true";
                            condition = "true";
                        };
                        class TMF_Debug_SystemChat
                        {
                            property = "TMF_Debug_SystemChat";
                            displayName = "Log to chat";
                            tooltip = "Toggle debug mode.";
                            control = "Checkbox";
                            expression = "true";
                            defaultValue = "false";
                            condition = "true";
                        };
                    };
                };
            };
        };
        class Scenario
        {
            class AttributeCategories
            {
                class Presentation
                {
                    class Attributes
                    {
                        class GVAR(introText)
                        {
                            property = QGVAR(introText);
                            displayName = "Display intro text";
                            tooltip = "Display some intro text shortly after the game loads.";
                            control = "Checkbox";
                            expression = "\
                                [{time > 5 && {player == player}},\
                                {[] spawn {\
                                    if !(hasInterface) exitWith {};\
                                    private _msg = (getPos player) call BIS_fnc_locationDescription;\
                                    _msg = _msg + format ['<br/>%1/%2/%3', (date select 0), (date select 1), (date select 2)];\
                                    _msg = _msg + format ['<br/>%1', ([dayTime, 'HH:MM'] call BIS_fnc_timeToString)];\
                                    [\
                                        _msg,\
                                        [safezoneX + safezoneW - 0.8,0.50],\
                                        [safezoneY + safezoneH - 0.8,0.8],\
                                        5,\
                                        0.5\
                                    ] spawn BIS_fnc_dynamicText;\
                                };\
                                },nil] call CBA_fnc_waitUntilAndExecute;\
                            ";
                            defaultValue = "true";
                            condition = "true";
                        };
                    };
                };
            };
        };
    };
    class Attributes
    {
        class CheckboxNumber;
        class None {
            idc = -1;
            type = 0; style = 0;
            w = 0; h = 0; y = 0; x = 0;
            attributeLoad = "";
            attributeSave = "";
            show = 0;
            tooltip = "";
            fade = 0;
            access = 0;
            default = 0;
            blinkingPeriod = 0;
            deletable = 0;
            shadow = 0;
            color[] = {1,1,1};
            colorBackground[] = {0.1,0.1,0.95};
            colorPreview[] = {1,1,1};
            colorPreviewBackground[] = {0.1,0.1,0.95};
            sizeEx = SIZEEX_PURISTA(SIZEEX_M); // Text size
            font = FONT_NORMAL; // Font from CfgFontFamilies
            text = "";
            lineSpacing = 1; // When ST_MULTI style is used, this defines distance between lines (1 is text height)
            fixedWidth = 0; // 1 (true) to enable monospace
            colorText[] = {1,1,1,1}; // Text color
            colorShadow[] = {0,0,0,1}; // Text shadow color (used only when shadow is 1)

            moving = 0; // 1 (true) to allow dragging the whole display by the control

            autoplay = 0; // Play video automatically (only for style ST_PICTURE with text pointing to an .ogv file)
            loops = 0; // Number of video repeats (only for style ST_PICTURE with text pointing to an .ogv file)

            tileW = 1; // Number of tiles horizontally (only for style ST_TILE_PICTURE)
            tileH = 1; // Number of tiles vertically (only for style ST_TILE_PICTURE)

            onCanDestroy = "";
            onDestroy = "";
            onMouseEnter = "";
            onMouseExit = "";
            onSetFocus = "";
            onKillFocus = "";
            onKeyDown = "";
            onKeyUp = "";
            onMouseButtonDown = "";
            onMouseButtonUp = "";
            action = "";
            onMouseButtonDblClick = "";
            onMouseZChanged = "";
            onMouseMoving = "";
            onMouseHolding = "";

            onVideoStopped = "";
        };
    };
    class Object
    {
        class Draw
        {
            class 3D
            {

                fadeDistance = "(getObjectViewDistance select 0)";
            };
        };
    };
    class EventHandlers
    {
        class ADDON
        {
            onMissionLoad = QUOTE([] call FUNC(mouseOverInit));
            onMissionNew = QUOTE([] call FUNC(mouseOverInit));
            onMissionPreviewEnd = QUOTE([] call FUNC(mouseOverInit));
        };
    };
};