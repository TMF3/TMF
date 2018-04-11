
#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\resincl.inc"

class ctrlDefault;
class ctrlDefaultText;// : ctrlDefault;
class ctrlStatic;// : ctrlDefaultText;
class ctrlListNBox;// : ctrlDefaultText;
class ctrlTree;// : ctrlDefaultText;
class ctrlEdit;// : ctrlDefaultText;

class RscButtonMenu;
class RscText;


class cfgScriptPaths 
{
    TMF_briefing = "x\tmf\addons\briefing\ui_scripts\"; //" - Escape for VS code linter
};

class Cfg3DEN
{
    class Mission
    {
        class TMF_MissionBriefingAttributes // Custom section class, everything inside will be opened in one window (MySection)
        {
            displayName = "TMF Briefing settings"; // Text visible in the window title as "Edit <displayName>"
            //display = "Display3DENEditAttributesPreview"; // Optional - display for attributes window. Must have the same structure and IDCs as the default Display3DENEditAttributes
            class AttributeCategories
            {
                class TMF_BriefingSettings
                {
                    displayName = "TMF: Briefing settings"; // Category name visible in Edit Attributes window
                    collapsed = 0; // When 1, the category is collapsed by default
                    class Attributes
                    {
                        class TMF_Briefing_Loadout
                        {
                            property = "TMF_Briefing_Loadout";
                            displayName = "Create loadout page";
                            tooltip = "Create briefing section that contains a list of all equipment of everyone in the players group and theirself.";
                            control = "Checkbox";
                            //expression = "missionNamespace setVariable ['TMF_Briefing_Loadout',_value];";
                            defaultValue = "true";
                            condition = "true";
                        };
                        class TMF_Briefing
                        {
                            property = "TMF_Briefing";
                            displayName = "";
                            control = "BriefingSettings";
                            //expression = "missionNamespace setVariable ['TMF_BriefingArray',_value];";
                            //tooltip = "How much should terrain affect radio signal strength? (0 disables)";
                            defaultValue = "[]";
                            condition = "true";
                        };
                    };
                };
            };
        };
    };
    class Group
    {
        // Categories collapsible in "Edit Attributes" window
        class AttributeCategories
        {
            // Category class, can be anything
            class TeamworkMarker
            {
                class Attributes
                {
                    class TMF_Briefinglist
                    {
                        displayName = ""; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_Briefinglist"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression =  "[_this,'TMF_Briefinglist',_value] call tmf_common_fnc_initGroupVar;";// "_this setVariable ['TMF_Briefinglist',_value],true;";
                        defaultValue = "[]";
                        wikiType = "[[String]]";
                    };
                };
            };
            
        };
    };
    // Configuration of all objects
    class Object
    {
        // Categories collapsible in "Edit Attributes" window
        class AttributeCategories
        {
            // Category class, can be anything
            class TeamworkMarker
            {
                class Attributes
                {
                    class TMF_Briefinglist
                    {
                        displayName = ""; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_Briefinglist"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression = "_this setVariable ['TMF_Briefinglist',_value,true];";
                        defaultValue = "[]";
                        wikiType = "[[String]]";
                        condition = "objectBrain"; // Condition for attribute to appear (see the table below)
                    };
                };
            };
        };
    };
    // Zeus Entities
    class Logic
    {
        // Categories collapsible in "Edit Attributes" window
        class AttributeCategories
        {
            // Category class, can be anything
            class TeamworkMarker
            {
                class Attributes
                {
                    class TMF_Briefinglist
                    {
                        displayName = ""; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_Briefinglist"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression = "_this setVariable ['TMF_Briefinglist',_value,true];";
                        defaultValue = "[]";
                        wikiType = "[[String]]";
                        condition = "objectControllable"; // Condition for attribute to appear (see the table below)
                    };
                };
            };
        };
    };

    class Attributes
    {
        class Title;
        class Toolbox; //class Toolbox: Title
    
    
        class BriefingSettings : Toolbox
        {
            scriptName = "BriefingSettings";
            scriptPath = "TMF_briefing";
            onLoad = "['onLoad',_this,'BriefingSettings','TMF_briefing',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
            onUnload = "['onUnload',_this,'BriefingSettings','TMF_briefing',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');";

            attributeLoad = "['attributeLoad',_this] call (uinamespace getvariable 'BriefingSettings_script');";
            attributeSave = "['attributeSave',_this] call (uinamespace getvariable 'BriefingSettings_script');";
            
            w = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) * GRID_W;
            h = 16 * SIZE_M * GRID_H;
            class Controls
            {
                class BriefTitle : ctrlStatic
                {
                    text = "Briefings:";
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) * GRID_W;
                    h = 1 * SIZE_M * GRID_H;                    
                    y = 0;
                    x = SIZE_M * GRID_W;
                    colorBackground[] = {0,0,0,0};
                };                    
                class BriefeesTitle : BriefTitle
                {
                    text = "Those to be briefed:";
                    x = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W-SIZE_M)/2) * GRID_W;
                };
                class ButtonBriefeeMake : RscButtonMenu
                {
                    text = "Grant";
                    h = SIZE_M * GRID_H;
                    x = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W;
                    w = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/2;
                    y = 1 * SIZE_M * GRID_H;
                    action = "['BriefTreeGive',_this] call (uinamespace getvariable 'BriefingSettings_script');";
                    tooltip = "Make the selected element recieve selected briefing.";
                };
                class ButtonBriefeeRemove: ButtonBriefeeMake
                {
                    text = "Remove";
                    x = (((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - SIZE_M)/2) ) * GRID_W)/2) + (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W);
                    action = "['BriefTreeRemove',_this] call (uinamespace getvariable 'BriefingSettings_script');";
                    tooltip = "Remove the selected element from recieveing the selected briefing.";
                };
                class BriefeeTree : ctrlTree
                {
                    idc = 189437;
                    x = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - SIZE_M)/2)) * GRID_W; //(((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) * GRID_W)/2) - SIZE_M;
                    y = 2 * SIZE_M * GRID_H;
                    h = 14 * SIZE_M * GRID_H;
                    multiselectEnabled = 1;
                    disableKeyboardSearch = 1;
                    colorDisabled[] = {1,1,1,0.25};
                    action = "['treeClick',_this] call (uinamespace getvariable 'BriefingSettings_script');";
                    onTreeDblClick = "['treeDoubleClick',_this] call (uinamespace getvariable 'BriefingSettings_script');";
                };
                class ListBackground: ctrlStatic
                {
                    x = SIZE_M * GRID_W;
                    y = 2 * SIZE_M * GRID_H;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 14 * SIZE_M * GRID_H;
                    colorBackground[] = {1,1,1,0.1};
                };
                class ButtonBriefAdd : RscButtonMenu
                {
                    text = "Add";
                    h = SIZE_M * GRID_H;
                    x = SIZE_M * GRID_W;
                    w = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3;
                    y = 1 * SIZE_M * GRID_H;
                    action = "['BriefAddClick',_this] call (uinamespace getvariable 'BriefingSettings_script');";
                    tooltip = "Add a new briefing.";
                };
                class ButtonBriefEdit: ButtonBriefAdd
                {
                    text = "Edit";
                    x = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3 + SIZE_M * GRID_W;
                    action = "['BriefEditClick',_this] call (uinamespace getvariable 'BriefingSettings_script');";
                    tooltip = "Edit the selected briefing.";
                };
                class ButtonBriefDel : ButtonBriefAdd
                {
                    text = "Delete";
                    x = (((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3) *2 + SIZE_M * GRID_W;
                    action = "['BriefDelClick',_this] call (uinamespace getvariable 'BriefingSettings_script');";
                    tooltip = "Delete the selected briefing.";
                };
                class BriefList: ctrlListNBox
                {
                    idc = 101;
                    x = SIZE_M * GRID_W;
                    y = 2 * SIZE_M * GRID_H;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 14 * SIZE_M * GRID_H;
                    drawSideArrows = 0;//1;
                    idcLeft = -1;
                    idcRight = -1;
                    columns[] = {0,0,0}; //0.05,0.15,0.85};
                    disableOverflow = 1;
                    onLBSelChanged = "with uiNamespace do {  ['refreshBriefTree',_this] call (uinamespace getvariable 'BriefingSettings_script'); };";
                };
                // Edit Briefing Box
                class EditBriefingBackgroundS: ctrlStatic
                {
                    idc = 313208;
                    x = SIZE_M * GRID_W;
                    y = 1 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 15 * SIZE_M * GRID_H;
                    colorBackground[] = {0.33,0.33,0.33,1};
                };
                class EditBriefingButtonOk : ButtonBriefeeMake
                {
                    idc = 313209;
                    text = "Okay";
                    y = 12.25 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 6;
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 6)*1.5 + SIZE_M * GRID_W;
                    action = "['BriefingEditClickOkay',_this] call (uinamespace getvariable 'BriefingSettings_script');";
                };
                class EditBriefingButtonCancel : EditBriefingButtonOk
                {
                    idc = 313210;
                    text = "Cancel";
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 6)*3.5 + SIZE_M * GRID_W;
                    action = "['BriefingDelClickCancel',_this] call (uinamespace getvariable 'BriefingSettings_script');";
                };
                
                class EditBriefingTitle : BriefTitle
                {
                    idc = 313201;
                    text = "Add/Edit Briefing";
                    y = 1 * SIZE_M * GRID_H;
                    x = SIZE_M * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W;
                    colorBackground[] = {0.1,0.1,0.1,1};
                };
                
                class EditBriefingShortTitle : BriefTitle
                {
                    idc = 313202;
                    text = "Briefing Name:";
                    y = 3 * SIZE_M * GRID_H;
                    x = 2 * SIZE_M * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W;
                };
                class EditBriefingShort : ctrlEdit
                {
                    idc = 313206;
                    type = CT_EDIT; // Type
                    colorBackground[] = {COLOR_OVERLAY_RGBA}; // Background color

                    text = ""; // Displayed text
                    colorText[] = {COLOR_TEXT_RGBA}; // Text and frame color
                    colorDisabled[] = {COLOR_TEXT_RGB,0.25}; // Disabled text and frame color
                    colorSelection[] = {COLOR_ACTIVE_RGBA}; // Text selection color

                    canModify = 1; // True (1) to allow text editing, 0 to disable it
                    autocomplete = ""; // Text autocomplete, can be "scripting" (scripting commands) or "general" (previously typed text)
                    y = 4.15 * SIZE_M * GRID_H;
                    x = 2 * SIZE_M * GRID_W;
                    h = SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - (4 * SIZE_M) ) * GRID_W;
                };
                
                class EditBriefingSciptName : EditBriefingShortTitle 
                {
                    idc = 313207;
                    text = "Script location:";
                    tooltip = "Script location to mission root e.g. briefings\briefing_orbat.sqf";
                    y = 5.3 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W;
                };
                
                class EditBriefingScript : EditBriefingShort
                {
                    idc = 313211;
                    y = 6.45 * SIZE_M * GRID_H;
                };

            };
        };
        
    };
};
