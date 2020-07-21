class TMF_ORBAT_Renamer : Title
{
    onLoad = "uiNamespace setVariable ['TMF_OrbatRenamer_ctrlGroup', (_this select 0)];";
    attributeLoad = "";
    attributeSave = "true";
    h = 5 * SIZE_M * GRID_H;
    class Controls : Controls
    {
        class renamerTitle: ctrlStatic
        {
            x = SIZE_M * GRID_W * 2;
            w = (ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) * GRID_W;
            h = SIZE_M * GRID_H;
            y = 0;
            colorBackground[] = {0,0,0,0};
            text = "Find & Replace - Group & unit descriptions.";
            tooltip = "Use this tool to easily rename group and unit's. E.g. 'NATO...' to 'US Army...'";
        };
        class renamerFindTitle: ctrlStatic
        {
            x = 0;
            w = ATTRIBUTE_TITLE_W * GRID_W;
            h = SIZE_M * GRID_H;
            y = SIZE_M * GRID_H;
            colorBackground[] = {0,0,0,0};
            style = ST_RIGHT;
            text = "Find what:";
            tooltip = "";
        };
        class renamerReplaceTitle : renamerFindTitle
        {
            y = 2.15 * SIZE_M * GRID_H;
            text = "Replace with:";
        };
        class Value : ctrlEdit
        {
            idc = 100;
            type = CT_EDIT; // Type
            colorBackground[] = {COLOR_OVERLAY_RGBA}; // Background color

            text = ""; // Displayed text
            colorText[] = {COLOR_TEXT_RGBA}; // Text and frame color
            colorDisabled[] = {COLOR_TEXT_RGB,0.25}; // Disabled text and frame color
            colorSelection[] = {COLOR_ACTIVE_RGBA}; // Text selection color
            canModify = 1; // True (1) to allow text editing, 0 to disable it
            autocomplete = ""; // Text autocomplete, can be "scripting" (scripting commands) or "general" (previously typed text)
            y = 1 * SIZE_M * GRID_H;
            x = ATTRIBUTE_TITLE_W * GRID_W;
            h = SIZE_M * GRID_H;
            w = (ATTRIBUTE_CONTENT_W -(3.5* SIZE_M)) * GRID_W;
        };
        class Value2 : Value
        {
            idc = 101;
            y = 2.15 * SIZE_M * GRID_H;
        };
        class orbatRenamerButton : RscButtonMenu
        {
            idc = 102;
            class Attributes {
                align = "center";
            };
            text = "Replace all";
            h = SIZE_M * GRID_H;
            x = (8*SIZE_M * GRID_W);
            w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - (16*SIZE_M) ) * GRID_W);
            y = 3.5 * SIZE_M * GRID_H;
            action = "[] call (missionNamespace getVariable 'tmf_orbat_fnc_renameUnitAndGroups');";
            //action = "['orbatToggleButton',_this] call (uinamespace getvariable 'ORBATSettings_script');";
        };

    };
};
