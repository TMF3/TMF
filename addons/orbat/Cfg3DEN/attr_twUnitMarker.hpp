class twUnitMarker: Toolbox
{
    scriptName = "UnitMarker";
    scriptPath = "TMF_orbat";
    onLoad = "['onLoad',_this,'UnitMarker','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
    onUnload = "['onUnload',_this,'UnitMarker','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');";

    attributeLoad = "['attributeLoad',_this] call (uinamespace getvariable 'UnitMarker_script');";
    attributeSave = "['attributeSave',_this] call (uinamespace getvariable 'UnitMarker_script');";

    h = QUOTE((9+0.2) * SIZE_M * GRID_H);
    class Controls
    {
        // ICON
        class GmTitle: ctrlStatic
        {
            x = 0;
            w = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
            y = 0;
            colorBackground[] = {0,0,0,0};
            style = ST_RIGHT;
            text = "Specialist unit marker";
            tooltip = "Choose icon to use for this unit. Use the empty icon to not use an icon";
        };
        class Icon: ctrlToolBox
        {
            idc = 100;
            x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            h = QUOTE(6 * SIZE_M * GRID_H);
            rows = 3;
            columns = 7;
            strings[] = {UNIT_MARKER_PREVIEW};
            tooltips[] = {UNIT_MARKER_DESCRIPTIONS};
            values[] = {UNIT_MARKER_POSTFIX};

            onToolboxSelChanged = "";
        };


        // Colours
        class ColourTitle: GmTitle
        {
            y = QUOTE((6+0.15) * SIZE_M * GRID_H);
            text = "Marker colour";
            tooltip = "Select the colour to use for the marker";
        };
        class ColourValue: ctrlToolBox
        {
            idc = 101;
            x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            y = QUOTE((6+0.15) * SIZE_M * GRID_H);
            h = QUOTE(1.75 * SIZE_M * GRID_H);
            rows = 1;
            columns = 7;
            strings[] = {
                "x\tmf\addons\orbat\textures\yellow_blank.paa",
                "x\tmf\addons\orbat\textures\blue_blank.paa",
                "x\tmf\addons\orbat\textures\green_blank.paa",
                "x\tmf\addons\orbat\textures\red_blank.paa",
                "x\tmf\addons\orbat\textures\orange_blank.paa",
                "x\tmf\addons\orbat\textures\gray_blank.paa",
                "x\tmf\addons\orbat\textures\purple_blank.paa"
            };
            tooltips[] = {
                "Yellow",
                "Blue",
                "Green",
                "Red",
                "Orange",
                "Gray",
                "Purple"
            };
            values[] = {
                "yellow",
                "blue",
                "green",
                "red",
                "orange",
                "gray",
                "purple"
            };

            onToolboxSelChanged = "";
        };
        // MARKER TEXT
        class MarkerTitle: GmTitle
        {
            y = QUOTE(8 * SIZE_M * GRID_H);
            text = "Marker text";
            tooltip = "Text to display alongside the icon";
        };
        class EditValue : ctrlEdit
        {
            y = QUOTE(8 * SIZE_M * GRID_H);
            idc = 102;
            x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
        };
    };
};
