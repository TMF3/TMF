
#include "\a3\3DEN\UI\resincl.inc"
#include "\a3\3DEN\UI\macros.inc"

#define GROUP_MARKER_PREVIEW "x\tmf\addons\orbat\textures\empty.paa", \
"x\tmf\addons\orbat\textures\yellow_inf.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_airmobile.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_mech.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_mech_wheeled.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_motor.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_para.paa", \
"x\tmf\addons\orbat\textures\yellow_amphi.paa", \
"x\tmf\addons\orbat\textures\yellow_amphi_mech_inf.paa", \
"x\tmf\addons\orbat\textures\yellow_airdef.paa", \
"x\tmf\addons\orbat\textures\yellow_airdef_not_a_nipple.paa", \
"x\tmf\addons\orbat\textures\yellow_antitank.paa", \
"x\tmf\addons\orbat\textures\yellow_antitank_rocket.paa", \
"x\tmf\addons\orbat\textures\yellow_armor.paa", \
"x\tmf\addons\orbat\textures\yellow_armor_wheeled.paa", \
"x\tmf\addons\orbat\textures\yellow_arm_airdef.paa", \
"x\tmf\addons\orbat\textures\yellow_arm_spaag.paa", \
"x\tmf\addons\orbat\textures\yellow_artillery.paa", \
"x\tmf\addons\orbat\textures\yellow_rotarywing.paa", \
"x\tmf\addons\orbat\textures\yellow_helo_attack.paa", \
"x\tmf\addons\orbat\textures\yellow_helo_cargo.paa", \
"x\tmf\addons\orbat\textures\yellow_fixedwing.paa", \
"x\tmf\addons\orbat\textures\yellow_hq.paa", \
"x\tmf\addons\orbat\textures\yellow_logistics.paa", \
"x\tmf\addons\orbat\textures\yellow_mg.paa", \
"x\tmf\addons\orbat\textures\yellow_mg_m.paa", \
"x\tmf\addons\orbat\textures\yellow_mg_h.paa", \
"x\tmf\addons\orbat\textures\yellow_mortar.paa", \
"x\tmf\addons\orbat\textures\yellow_motor.paa", \
"x\tmf\addons\orbat\textures\yellow_para.paa", \
"x\tmf\addons\orbat\textures\yellow_para_mech.paa", \
"x\tmf\addons\orbat\textures\yellow_recon.paa", \
"x\tmf\addons\orbat\textures\yellow_recon_mech.paa", \
"x\tmf\addons\orbat\textures\yellow_recon_mech_wheeled.paa", \
"x\tmf\addons\orbat\textures\yellow_recon_motor.paa", \
"x\tmf\addons\orbat\textures\yellow_engineer.paa", \
"x\tmf\addons\orbat\textures\yellow_service.paa", \
"x\tmf\addons\orbat\textures\yellow_sf.paa", \
"x\tmf\addons\orbat\textures\yellow_signal.paa", \
"x\tmf\addons\orbat\textures\yellow_spaag.paa", \
"x\tmf\addons\orbat\textures\yellow_transport.paa", \
"x\tmf\addons\orbat\textures\yellow_uav.paa", \
"x\tmf\addons\orbat\textures\yellow_blank.paa"

#define GROUP_MARKER_DESCRIPTIONS "No Marker",\
"Infantry",\
"Infantry Air Mobile",\
"Infantry Mechanized",\
"Infantry Mechanized Wheeled",\
"Infantry Motorized",\
"Infantry Para",\
"Amphibious",\
"Amphibious Mechanized Infantry",\
"Air Defense",\
"Air Defense Missle",\
"Anti-tank",\
"Anti-tank Rocket",\
"Armour",\
"Armour wheeled",\
"Armoured Air Defense",\
"Armoured Air Defense SPAAG",\
"Artillery",\
"Helicopter",\
"Attack helicopter",\
"Cargo helicopter",\
"Fixed wing",\
"HQ",\
"Logistics",\
"Machinegun (Light ~5.56mm)",\
"Machinegun (Medium ~7.62mm)",\
"Machinegun (Heavy ~12.7mm)",\
"Mortar",\
"Motor",\
"Para",\
"Para Mechanized",\
"Recon",\
"Recon Mechanized",\
"Recon Mechanized Wheeled",\
"Recon Motorized",\
"Engineer",\
"Service",\
"Special Forces",\
"Signal (communications)",\
"SPAAG",\
"Transport",\
"UAV",\
"Plain"

#define GROUP_MARKER_POSTFIX "",\
"_inf.paa",\
"_inf_airmobile.paa",\
"_inf_mech.paa",\
"_inf_mech_wheeled.paa",\
"_inf_motor.paa",\
"_inf_para.paa",\
"_amphi.paa",\
"_amphi_mech_inf.paa",\
"_airdef.paa",\
"_airdef_not_a_nipple.paa",\
"_antitank.paa",\
"_antitank_rocket.paa",\
"_armor.paa",\
"_armor_wheeled.paa",\
"_arm_airdef.paa",\
"_arm_spaag.paa",\
"_artillery.paa",\
"_rotarywing.paa",\
"_helo_attack.paa",\
"_helo_cargo.paa",\
"_fixedwing.paa",\
"_hq.paa",\
"_logistics.paa",\
"_mg.paa",\
"_mg_m.paa",\
"_mg_h.paa",\
"_mortar.paa",\
"_motor.paa",\
"_para.paa",\
"_para_mech.paa",\
"_recon.paa",\
"_recon_mech.paa",\
"_recon_mech_wheeled.paa",\
"_recon_motor.paa",\
"_engineer.paa",\
"_service.paa",\
"_sf.paa",\
"_signal.paa",\
"_spaag.paa",\
"_transport.paa",\
"_uav.paa",\
"_blank.paa"

#define UNIT_MARKER_PREVIEW "x\tmf\addons\orbat\textures\empty.paa", \
"x\tmf\addons\orbat\textures\yellow_cross.paa", \
"x\tmf\addons\orbat\textures\yellow_chevrons.paa", \
"x\tmf\addons\orbat\textures\yellow_sl_flag.paa"

#define UNIT_MARKER_DESCRIPTIONS "No Marker",\
"Medic",\
"Plt Sgt",\
"Squad Leader"

#define UNIT_MARKER_POSTFIX "_blank.paa",\
"_cross.paa",\
"_chevrons.paa",\
"_sl_flag.paa"


class ctrlDefault;
class ctrlDefaultText;// : ctrlDefault;
class ctrlStatic;// : ctrlDefaultText;
class ctrlListNBox;// : ctrlDefaultText;
class ctrlTree;// : ctrlDefaultText;
class ctrlEdit;// : ctrlDefaultText;
class ctrlToolBox;// : ctrlDefaultText;

class RscButtonMenu;
class RscText;

class cfgScriptPaths
{
    TMF_orbat = "x\tmf\addons\orbat\ui_scripts\";
};

class Cfg3DEN
{
    class Mission
    {
        class TMF_ORBAT_Settings
        {
            displayName = "TMF ORBAT attributes"; // Text visible in the window title as "Edit <displayName>"
            //display = "Display3DENEditAttributesPreview"; // Optional - display for attributes window. Must have the same structure and IDCs as the default Display3DENEditAttributes
            class AttributeCategories
            {
                class TMF_ORBATSettings
                {
                    displayName = "TMF: ORBAT"; // Category name visible in Edit Attributes window
                    collapsed = 0; // When 1, the category is collapsed by default
                    class Attributes
                    {
                        class TMF_ORBATTracker
                        {
                            property = "TMF_ORBATTracker";
                            displayName = "Enable map markers for ORBAT";
                            control = "Checkbox";
                            //expression = "missionNamespace setVariable ['TMF_ORBAT_Tracker',_value];";
                            tooltip = "Use this option to disable elements of the ORBAT being displayed on the map.";
                            defaultValue = false;
                            condition = "true";
                            wikiType = "[[String]]";
                        };
                        class TMF_ORBATTrackerCondition
                        {
                            property = "TMF_ORBATTrackerCondition";
                            displayName = "Map markers display condition";
                            control = "Edit";
                            //expression = "missionNamespace setVariable ['TMF_ORBAT_Tracker',_value];";
                            tooltip = "[Advanced] Use this text box to specify a code condition to evaluate to check if the orbat should be drawn. Must return a boolean. e.g. ('ItemGPS' in (assignedItems player)). Do not edit this if you do understand this description. Default value: true";
                            defaultValue = "true";
                            condition = "true";
                            wikiType = "[[String]]";
                        };
                        class TMF_ORBATMarkersFT
                        {
                            property = "TMF_ORBATMarkersFT";
                            displayName = "Enable fireteam map markers";
                            control = "Checkbox";
                            //expression = "missionNamespace setVariable ['TMF_ORBAT_MarkersFT',_value];";
                            tooltip = "Use this option to disable drawing members of the current player's fireteam on the map.";
                            defaultValue = false;
                            condition = "true";
                            wikiType = "[[String]]";
                        };
                        class TMF_ORBATMarkersFT_Directional
                        {
                            property = "TMF_ORBATMarkersFT_Directional";
                            displayName = "Directional fireteam map markers";
                            control = "Checkbox";
                            expression = "missionNamespace setVariable ['TMF_ORBAT_MarkersFT_Directional',_value,true];";
                            tooltip = "Set whether fireteam map markers are directional or not.";
                            defaultValue = false;
                            condition = "true";
                            wikiType = "[[String]]";
                        };
                        class TMF_ORBATSettings
                        {
                            property = "TMF_ORBATSettings";
                            control = "ORBATSettings";
                            //expression = "missionNamespace setVariable ['TMF_ORBAT_Array',_value];";
                            tooltip = "";
                            defaultValue = "[]";
                            condition = "true";
                            wikiType = "[[String]]";
                        };
                        class TMF_ORBATRenameFakeAttribute
                        {
                            property = "TMF_ORBATRenameFakeAttribute";
                            control = "TMF_ORBAT_Renamer";
                            tooltip = "";
                            defaultValue = "true";
                            condition = "true";
                            wikiType = "[[String]]";
                        };
                    };
                };
            };
        };
    };
    class Object
    {
        // Categories collapsible in "Edit Attributes" window
        class AttributeCategories
        {
            // Category class, can be anything
            class TeamworkMarker
            {
                displayName = "TMF: Specialist Unit Marker"; // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes
                {
                    // Attribute class, can be anything
                    class TMF_SpecialistMarker
                    {
                        displayName = "Specialist unit icon"; // Name assigned to UI control class Title
                        tooltip = "Pick icon to use for this unit. It is recommended to not overly use markers on individual units."; // Tooltip assigned to UI control class Title
                        property = "TMF_SpecialistMarker"; // Unique config property name saved in SQM
                        control = "twUnitMarker"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        condition = "objectBrain"; // Condition for attribute to appear (see the table below)
                        expression = "_this setVariable ['TMF_SpecialistMarker',_value,true];";
                        defaultValue = "["""",""""]";
                        wikiType = "[[String]]";
                    };
                    class TMF_OrbatParent
                    {
                        property = "TMF_OrbatParent"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        condition = "objectBrain"; // Condition for attribute to appear (see the table below)
                        expression = "_this setVariable ['TMF_OrbatParent',_value,true];";
                        defaultValue = "-1";
                    };
                };
            };
            class TMF_orbat_vehicleCallsign
            {
                displayName = "TMF Vehicle Callsign";
                collapsed = 0;
                class Attributes
                {
                    class TMF_orbat_vehicleCallsign
                    {
                        property = "TMF_orbat_vehicleCallsign";
                        displayName = "Callsign";
                        tooltip = "Give vehicle a callsign.";
                        condition = "objectVehicle";
                        control = "Edit";
                        defaultValue = "''";
                        expression = "_this setVariable ['TMF_orbat_vehicleCallsign',_value,true];";
                        wikiType = "[[String]]";
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
                displayName = "TMF: Group Marker"; // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes
                {
                    class TMF_groupMarker
                    {
                        property = "TMF_groupMarker"; // Unique config property name saved in SQM
                        control = "twGroupMarker"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        condition = "object"; // Condition for attribute to appear (see the table below)
                        expression = "[_this,'TMF_groupMarker',_value] call tmf_common_fnc_initGroupVar;";//"[_this,['TMF_groupMarker',_value]] remoteExecCall ['setVariable',0,true];" //"_this setVariable ['TMF_groupMarker',_value,true];";
                        defaultValue = "'[]'";
                        wikiType = "[[String]]";
                    };
                    class TMF_OrbatParent
                    {
                        property = "TMF_OrbatParent"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        condition = "object"; // Condition for attribute to appear (see the table below)
                        expression = "[_this,'TMF_OrbatParent',_value] call tmf_common_fnc_initGroupVar;";//"[_this,['TMF_OrbatParent',_value]] remoteExecCall ['setVariable',0,true];"; //_this setVariable ['TMF_OrbatParent',_value,true];";
                        defaultValue = "-1";
                    };
                };
            };
        };
    };
    class Attributes
    {
        class Toolbox; //class Toolbox: Title
        
        class Default;
        class Title : Default
        {
            class Controls
            {
                class Title;
            };
        };
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
        
        class twGroupMarker: Toolbox
        {
            scriptName = "GroupMarker";
            scriptPath = "TMF_orbat";
            onLoad = "['onLoad',_this,'GroupMarker','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
            onUnload = "['onUnload',_this,'GroupMarker','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');";

            attributeLoad = "['attributeLoad',_this] call (uinamespace getvariable 'GroupMarker_script');";
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
                        "x\tmf\addons\orbat\textures\gray_blank.paa"
                    };
                    tooltips[] = {
                        "Yellow",
                        "Blue",
                        "Green",
                        "Red",
                        "Orange",
                        "Gray"
                    };
                    values[] = {
                        "yellow",
                        "blue",
                        "green",
                        "red",
                        "orange",
                        "gray"
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

        class twUnitMarker: Toolbox
        {
            scriptName = "UnitMarker";
            scriptPath = "TMF_orbat";
            onLoad = "['onLoad',_this,'UnitMarker','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
            onUnload = "['onUnload',_this,'UnitMarker','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');";

            attributeLoad = "['attributeLoad',_this] call (uinamespace getvariable 'UnitMarker_script');";
            attributeSave = "['attributeSave',_this] call (uinamespace getvariable 'UnitMarker_script');";

            h = (9+0.2) * SIZE_M * GRID_H;
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
                    text = "Specialist unit marker";
                    tooltip = "Choose icon to use for this unit. Use the empty icon to not use an icon";
                };
                class Icon: ctrlToolbox
                {
                    idc = 100;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                    h = 6 * SIZE_M * GRID_H;
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
                    y = (6+0.15) * SIZE_M * GRID_H;
                    text = "Marker colour";
                    tooltip = "Select the colour to use for the marker";
                };
                class ColourValue: ctrlToolbox
                {
                    idc = 101;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                    y = (6+0.15) * SIZE_M * GRID_H;
                    h = 1.75 * SIZE_M * GRID_H;
                    rows = 1;
                    columns = 7;
                    strings[] = {
                        "x\tmf\addons\orbat\textures\yellow_blank.paa",
                        "x\tmf\addons\orbat\textures\blue_blank.paa",
                        "x\tmf\addons\orbat\textures\green_blank.paa",
                        "x\tmf\addons\orbat\textures\red_blank.paa",
                        "x\tmf\addons\orbat\textures\orange_blank.paa",
                        "x\tmf\addons\orbat\textures\gray_blank.paa"
                    };
                    tooltips[] = {
                        "Yellow",
                        "Blue",
                        "Green",
                        "Red",
                        "Orange",
                        "Gray"
                    };
                    values[] = {
                        "yellow",
                        "blue",
                        "green",
                        "red",
                        "orange",
                        "gray"
                    };

                    onToolboxSelChanged = "";
                };
                // MARKER TEXT
                class MarkerTitle: GmTitle
                {
                    y = 8 * SIZE_M * GRID_H;
                    text = "Marker text";
                    tooltip = "Text to display alongside the icon";
                };
                class EditValue : ctrlEdit
                {
                    y = 8 * SIZE_M * GRID_H;
                    idc = 102;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    h = SIZE_M * GRID_H;
                };
            };
        };


        // ORBATSettings

        class ORBATSettings : Toolbox
        {
            scriptName = "ORBATSettings";
            scriptPath = "TMF_orbat";
            onLoad = "['onLoad',_this,'ORBATSettings','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
            onUnload = "['onUnload',_this,'ORBATSettings','TMF_orbat',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');";

            attributeLoad = "['attributeLoad',_this] call (uinamespace getvariable 'ORBATSettings_script');";
            attributeSave = "['attributeSave',_this] call (uinamespace getvariable 'ORBATSettings_script');";

            w = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) * GRID_W;
            h = 25 * SIZE_M * GRID_H; //20
            class Controls
            {
                class LangTitle : ctrlStatic
                {
                    text = "Split ORBATs by:";
                    style = ST_RIGHT;
                    w = ATTRIBUTE_TITLE_W * GRID_W;
                    h = 1 * SIZE_M * GRID_H;
                    y = 0;
                    x = 0;
                    colorBackground[] = {0,0,0,0};
                    tooltip = "Use this to control whether group markers are shared with everyone on the same faction or instead on the same side. Changing this system will erase the previous heirarchy.";
                };
                class Value: ctrlToolbox
                {
                    idc = 100;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    style = ST_CENTER + ST_KEEP_ASPECT_RATIO; //ST_PICTURE +
                    y = 0;
                    h = 1 * SIZE_M * GRID_H;
                    rows = 1;
                    columns = 2;
                    strings[] = {"Side", "Faction"};
                    tooltips[] = {"Side", "Faction"};
                    values[] = {0, 1};

                    onToolboxSelChanged = "['orbatBinChanged',_this] call (uinamespace getvariable 'ORBATSettings_script');"; // missionnamespace setvariable ['Rank_value',_this select 1];
                };
                class orbatToggleButton : RscButtonMenu
                {
                    idc = 101;
                    class Attributes {
                        align = "center";
                    };
                    text = "&lt; Configure X &gt;";
                    h = SIZE_M * GRID_H;
                    x = SIZE_M * GRID_W;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W);
                    y = 2 * SIZE_M * GRID_H;
                    action = "['orbatToggleButton',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Toggle through the various sides/factions (Only toggles through sides/factions with playable units)";
                };
                class OrbatTitle : LangTitle
                {
                    idc = 103;
                    text = "Orbat hierarchy:";
                    x = SIZE_M * GRID_W;
                    style = ST_LEFT;
                    y = 3 * SIZE_M * GRID_H;
                    tooltip = "Hierarchy tree of ORBAT";
                };

                /*class OrbatTreeBackground: ctrlStatic
                {
                    x = SIZE_M * GRID_W;
                    y = 5 * SIZE_M * GRID_H;
                    w = (ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) * GRID_W;
                    h = 14 * SIZE_M * GRID_H;
                    colorBackground[] = {0,0,0,0.1};
                };*/
                class TreeMove : RscButtonMenu
                {
                    idc = 104;
                    text = "Move";
                    h = SIZE_M * GRID_H;
                    x = SIZE_M * GRID_W;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W)/4;
                    y = 4 * SIZE_M * GRID_H;
                    action = "['treeMoveClick',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Move the selected element";
                };
                class TreeAdd : TreeMove
                {
                    idc = 105;
                    text = "Add";
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W)/4 + SIZE_M * GRID_W;
                    action = "['treeAddClick',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Add a new virtual element as a child of the selected element. You can not create a virtual element on a real group.";
                };
                class TreeEdit : TreeMove
                {
                    idc = 106;
                    text = "Edit";
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W)/4 *2 + SIZE_M * GRID_W;
                    action = "['treeEditClick',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Edit the orbat settings for the selected element";
                };
                class TreeDel : TreeMove
                {
                    idc = 107;
                    text = "Delete";
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W)/4 *3 + SIZE_M * GRID_W;
                    action = "['treeDelClick',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Delete the virtual element. This will not delete real groups";
                };
                class OrbatTree : ctrlTree
                {
                    idc = 102;
                    x = SIZE_M * GRID_W;
                    w = (ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - (3.5*SIZE_M)) * GRID_W;
                    y = 5 * SIZE_M * GRID_H;
                    h = 19 * SIZE_M * GRID_H;
                    multiselectEnabled = 1;
                    disableKeyboardSearch = 1;
                    colorDisabled[] = {1,1,1,0.25};
                    action = "['treeClick',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    onTreeDblClick = "['treeDoubleClick',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    colorBackground[] = {0,0,0,0.3};
                };

                class TreeTop : RscButtonMenu
                {
                    idc = 124;
                    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;

                    animTextureNormal = "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
                    animTextureDisabled =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
                    animTextureOver =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
                    animTextureFocused =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
                    animTexturePressed =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
                    animTextureDefault =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";

                    color[] = {0,0,0,0.6};
                    color2[] = {0,0,0,1};
                    colorDisabled[] = {0,0,0,0.3};
                    colorBackground[] = {1,1,1,1};
                    colorBackground2[] = {1,1,1,0.5};

                    text = "";
                    h = 1*SIZE_M * GRID_H;//(ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W  - SIZE_M) * GRID_W * 0.1; //SIZE_M * GRID_H; //keep square
                    x = (ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - (2.5*SIZE_M)) * GRID_W;
                    w = 2.5*SIZE_M * GRID_W; //(ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W  - SIZE_M) * GRID_W * 0.1;
                    y = 8.3 * SIZE_M * GRID_H;
                    action = "['moveTop',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Move the current entry to the top.";
                };
                class TreeUp : TreeTop
                {
                    idc = 125;
                    y = 10.45* SIZE_M * GRID_H;

                    animTextureNormal = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
                    animTextureDisabled = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
                    animTextureOver = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
                    animTextureFocused = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
                    animTexturePressed = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
                    animTextureDefault = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";

                    action = "['moveUp',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Move the current entry up.";
                };
                class TreeDown : TreeTop
                {
                    idc = 126;
                    animTextureNormal = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
                    animTextureDisabled = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
                    animTextureOver = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
                    animTextureFocused = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
                    animTexturePressed = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
                    animTextureDefault = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
                    y = 12.6 * SIZE_M * GRID_H;
                    action = "['moveDown',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Move the current entry down.";
                };
                class TreeBottom : TreeDown
                {
                    animTextureNormal = "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
                    animTextureDisabled =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
                    animTextureOver =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
                    animTextureFocused =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
                    animTexturePressed =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
                    animTextureDefault =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";

                    idc = 127;
                    y = 14.75 * SIZE_M * GRID_H;
                    action = "['moveBottom',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Move the current entry to the bottom.";
                };

                //Move GUI
                class MoveTitle : LangTitle
                {
                    idc = 120;
                    text = "Select the new parent (double click)";
                    w = (ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W-SIZE_M) * GRID_W;
                    x = SIZE_M * GRID_W;
                    style = ST_LEFT;
                    y = 3.25 * SIZE_M * GRID_H;
                    tooltip = "Hierarchy tree of ORBAT";
                };

                class MoveTree : ctrlTree
                {
                    idc = 108;
                    x = 1 * SIZE_M * GRID_W;
                    w = (ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W-SIZE_M) * GRID_W;
                    y = 4.5 * SIZE_M * GRID_H;
                    h = 19 * SIZE_M * GRID_H;
                    multiselectEnabled = 1;
                    disableKeyboardSearch = 1;
                    colorDisabled[] = {1,1,1,0.25};
                    //action = "['treeClick',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    onTreeDblClick = "['moveTreeDoubleClick',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    colorBackground[] = {0,0,0,0.3};
                };
                class moveOrbatCancel : TreeMove
                {
                    idc = 121;
                    text = "Cancel";
                    y = 24 * SIZE_M * GRID_H;
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 8)*4.5 + SIZE_M * GRID_W;
                    action = "['editOrbatEntryClickCancel',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                    tooltip = "Cancel moving the element.";
                };

                //Edit/Add GUI
                class EditTitle : LangTitle
                {
                    idc = 109;
                    text = "Add/Edit heirarchy piece:";
                    x = SIZE_M * GRID_W;
                    style = ST_LEFT;
                    y = 3 * SIZE_M * GRID_H;
                    tooltip = "Hierarchy tree of ORBAT";
                };
                class GmTitle: ctrlStatic
                {
                    idc = 110;
                    x = 0;
                    w = ATTRIBUTE_TITLE_W * GRID_W;
                    h = SIZE_M * GRID_H;
                    y = 4 * SIZE_M * GRID_H;
                    colorBackground[] = {0,0,0,0};
                    style = ST_RIGHT;
                    text = "Marker icon";
                    tooltip = "Choose icon to use for this group. Use the empty icon to not use an icon";
                };
                class Icon: ctrlToolbox
                {
                    idc = 111;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                    h = 12.25 * SIZE_M * GRID_H;
                    y = 4 * SIZE_M * GRID_H;
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
                    idc = 112;
                    y = (4+12.25+0.15) * SIZE_M * GRID_H;
                    text = "Marker colour";
                    tooltip = "Select the colour to use for the marker";
                };
                class ColourValue: ctrlToolbox
                {
                    idc = 113;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                    y = (4+12.25+0.15) * SIZE_M * GRID_H;
                    h = 1.75 * SIZE_M * GRID_H;

                    rows = 1;
                    columns = 7;
                    strings[] = {
                        "x\tmf\addons\orbat\textures\yellow_blank.paa",
                        "x\tmf\addons\orbat\textures\blue_blank.paa",
                        "x\tmf\addons\orbat\textures\green_blank.paa",
                        "x\tmf\addons\orbat\textures\red_blank.paa",
                        "x\tmf\addons\orbat\textures\orange_blank.paa",
                        "x\tmf\addons\orbat\textures\gray_blank.paa"
                    };
                    tooltips[] = {
                        "Yellow",
                        "Blue",
                        "Green",
                        "Red",
                        "Orange",
                        "Gray"
                    };
                    values[] = {
                        "yellow",
                        "blue",
                        "green",
                        "red",
                        "orange",
                        "gray"
                    };

                    onToolboxSelChanged = ""; // missionnamespace setvariable ['Rank_value',_this select 1];
                };
                // MARKER TEXT
                class MarkerTitle: GmTitle
                {
                    idc = 114;
                    y = (4+14+0.3) * SIZE_M * GRID_H;
                    text = "Marker text";
                    tooltip = "Text to display alongside the marker. This should ideally be a short string e.g. 'A'";
                };
                class EditMarkerTitleValue : ctrlEdit
                {
                    y = (4+14+0.3) * SIZE_M * GRID_H;
                    idc = 115;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    h = SIZE_M * GRID_H;
                };
                class FullTitle: MarkerTitle
                {
                    idc = 122;
                    y = (4+15+0.45) * SIZE_M * GRID_H;
                    text = "Briefing text";
                    tooltip = "Text to display for this entry in the briefing. E.g. 'Alpha Squad', '1st Platoon'";
                };
                class EditFullTitleValue : EditMarkerTitleValue
                {
                    y = (4+15+0.45) * SIZE_M * GRID_H;
                    idc = 123;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                };
                // Size
                class sizeTitle: GmTitle
                {
                    idc = 116;
                    y = (4+16+0.6) * SIZE_M * GRID_H;
                    text = "Marker size modifier";
                    tooltip = "Size modifier";
                };
                class sizeValue: ctrlToolbox
                {
                    idc = 117;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                    y = (4+16+0.6) * SIZE_M * GRID_H;
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

                class EditOrbatEntryOk : RscButtonMenu
                {
                    idc = 118;
                    text = "Ok";
                    y = 23.5 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 6;
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 6)*1.5 + SIZE_M * GRID_W;
                    h = SIZE_M * GRID_H;
                    action = "['editOrbatEntryClickOkay',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                };
                class EditOrbatEntryCancel : EditOrbatEntryOk
                {
                    idc = 119;
                    text = "Cancel";
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 6)*3.5 + SIZE_M * GRID_W;
                    action = "['editOrbatEntryClickCancel',_this] call (uinamespace getvariable 'ORBATSettings_script');";
                };

            };
        };


    };

};