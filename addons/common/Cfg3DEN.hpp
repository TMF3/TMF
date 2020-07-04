#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\resincl.inc"

class Cfg3DEN
{
    class Mission
    {
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
                            expression = "[_value] call tmf_common_fnc_intro";
                            defaultValue = "true";
                            condition = "1";
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
};
