class twGroupMarker: Toolbox
{
    scriptName = "GroupMarker";
    scriptPath = "TMF_orbat";
    onLoad = "['onLoad',_this,'GroupMarker','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
    onUnload = "['onUnload',_this,'GroupMarker','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');";

    attributeLoad = "['attributeLoad',_this,_value] call (uinamespace getvariable 'GroupMarker_script');";
    attributeSave = "['attributeSave',_this] call (uinamespace getvariable 'GroupMarker_script');";

    h = (16.75+0.45) * SIZE_M * GRID_H;
    class Controls
    {
        // ICON
        class GmTitle: ctrlStatic
        {
            x = 0;
            w = ATTRIBUTE_TITLE_W * GRID_W;
            h = SIZE_M * GRID_H;
            y = 0;
            colorBackground[] = {0,0,0,0};
            style = ST_RIGHT;
            text = "Marker icon";
            tooltip = "Choose icon to use for this group. Use the empty icon to not use an icon";
        };
        class Icon: ctrlToolbox
        {
            idc = 100;
            x = ATTRIBUTE_TITLE_W * GRID_W;
            w = ATTRIBUTE_CONTENT_W * GRID_W;
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            h = 12.25 * SIZE_M * GRID_H;

            rows = 7;
            columns = 7;
            strings[] = {GROUP_MARKER_PREVIEW};
            tooltips[] = {GROUP_MARKER_DESCRIPTIONS};
            values[] = {GROUP_MARKER_POSTFIX};

            onToolboxSelChanged = ""; // missionnamespace setvariable ['Rank_value',_this select 1];
        };


        // Colours
        class ColourTitle: GmTitle
        {
            y = (12.25+0.15) * SIZE_M * GRID_H;
            text = "Marker colour";
            tooltip = "Select the colour to use for the marker";
        };
        class ColourValue: ctrlToolbox
        {
            idc = 101;
            x = ATTRIBUTE_TITLE_W * GRID_W;
            w = ATTRIBUTE_CONTENT_W * GRID_W;
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            y = (12.25+0.15) * SIZE_M * GRID_H;
            h = 1.75 * SIZE_M * GRID_H;

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

            onToolboxSelChanged = ""; // missionnamespace setvariable ['Rank_value',_this select 1];
        };
        // MARKER TEXT
        class MarkerTitle: GmTitle
        {
            y = (14+0.3) * SIZE_M * GRID_H;
            text = "Marker text";
            tooltip = "Text to display alongside the marker";
        };
        class EditValue : ctrlEdit
        {
            y = (14+0.3) * SIZE_M * GRID_H;
            idc = 102;
            x = ATTRIBUTE_TITLE_W * GRID_W;
            w = ATTRIBUTE_CONTENT_W * GRID_W;
            h = SIZE_M * GRID_H;
        };
        // Size
        class sizeTitle: GmTitle
        {
            y = (15+0.45) * SIZE_M * GRID_H;
            text = "Marker size modifier";
            tooltip = "Size modifier";
        };
        class sizeValue: ctrlToolbox
        {
            idc = 103;
            x = ATTRIBUTE_TITLE_W * GRID_W;
            w = ATTRIBUTE_CONTENT_W * GRID_W;
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            y = (15+0.45) * SIZE_M * GRID_H;
            h = 1.75 * SIZE_M * GRID_H;
            colorBackground[] = {1,1,1,0.3};

            rows = 1;
            columns = 6;
            strings[] = {
                "x\tmf\addons\orbat\textures\empty.paa",
                "x\tmf\addons\orbat\textures\modif_o.paa",
                "x\tmf\addons\orbat\textures\modif_dot.paa",
                "x\tmf\addons\orbat\textures\modif_2dot.paa",
                "x\tmf\addons\orbat\textures\modif_3dot.paa",
                "x\tmf\addons\orbat\textures\modif_company.paa"
            };
            tooltips[] = {"None",
                "Fireteam (~3-6 soldiers)",
                "Squad (~7-14 soldiers)",
                "Half Platoon (US Section) (~14-21 soldiers)",
                "Platoon (~22-50 soldiers)",
                "Company (~60-150 soldiers)"
            };
            values[] = {
                "",
                "x\tmf\addons\orbat\textures\modif_o.paa",
                "x\tmf\addons\orbat\textures\modif_dot.paa",
                "x\tmf\addons\orbat\textures\modif_2dot.paa",
                "x\tmf\addons\orbat\textures\modif_3dot.paa",
                "x\tmf\addons\orbat\textures\modif_company.paa"
            };

            onToolboxSelChanged = ""; // missionnamespace setvariable ['Rank_value',_this select 1];
        };
    };
};
