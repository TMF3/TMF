
#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\resincl.inc"

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
    TMF_acre2 = "x\\tmf\\addons\\acre2\\ui_scripts\\";
};

class Cfg3DEN
{
    class Mission
    {
        class TMF_MissionAcre2Attributes // Custom section class, everything inside will be opened in one window (MySection)
        {
            displayName = "ACRE2 attributes"; // Text visible in the window title as "Edit <displayName>"
            //display = "Display3DENEditAttributesPreview"; // Optional - display for attributes window. Must have the same structure and IDCs as the default Display3DENEditAttributes
            class AttributeCategories
            {
                class TMF_AcreGeneralSettings
                {
                    displayName = "TMF: General ACRE2 settings"; // Category name visible in Edit Attributes window
                    collapsed = 0; // When 1, the category is collapsed by default
                    class Attributes
                    {
                        class Network_Enabled
                        {
                            property = "TMF_AcreNetworkEnabled";
                            displayName = "Enable custom networks";
                            control = "Checkbox";
                            //expression = "missionNamespace setVariable ['TMF_NetworkEnabled',_value];";
                            tooltip = "Enable the custom ACRE network and channel feature. Configure this in the 'Radios' section below. If disabled the below networks and channels will not be created.";
                            defaultValue = false;
                            condition = "1";
                        };
                        class Babel_Enabled
                        {
                            property = "TMF_AcreBabelEnabled";
                            displayName = "Babel enabled:";
                            control = "Checkbox";
                            //expression = "missionNamespace setVariable ['TMF_BabelEnabled',_value];";
                            tooltip = "Enable ACRE's Babel feature? Configure this is in the next section";
                            defaultValue = false;
                            condition = "1";
                        };
                        class Action_Radios
                        {
                            property = "TMF_AcreAddRadioActions";
                            displayName = "Action radios:";
                            control = "TMF_AcreAddRadioActions";
                            //expression = "missionNamespace setVariable ['TMF_AcreAddRadioActions',_value];";
                            tooltip = "These radios will be available for selection (via scroll wheel action) for the first 5 minutes after the player has spawned.";
                            defaultValue = "['ACRE_PRC343','ACRE_PRC148']";
                            condition = "1";
                        };
                    };
                };
                class TMF_AcreBabelSettings
                {
                    displayName = "TMF: Languages (Babel System)"; // Category name visible in Edit Attributes window
                    collapsed = 1; // When 1, the category is collapsed by default
                    class Attributes
                    {
                        class Languages
                        {
                            property = "TMF_AcreBabelSettings";
                            control = "BabelSettings";
                            //expression = "missionNamespace setVariable ['TMF_BabelArray',_value];";
                            tooltip = "";
                            defaultValue = "[]";
                            condition = "1";
                            wikiType = "[[String]]";
                        };
                    };
                };
                // The following structure is the same as the one used for entity attributes
                class TMF_AcreSettings
                {
                    displayName = "TMF: Radios"; // Category name visible in Edit Attributes window
                    collapsed = 1; // When 1, the category is collapsed by default
                    class Attributes
                    {
                        class RadioChannels
                        {
                            property = "TMF_AcreSettings";
                            control = "RadioChannels";
                            displayName = "";
                            tooltip = "";
                            //expression = "missionNamespace setVariable ['TMF_RadioArray', _value];";
                            defaultValue = "[]";
                            condition = "1";
                            wikiType = "[[String]]";
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
                    class TMF_BabelLanguages
                    {
                        displayName = "Babel languages"; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_BabelLanguages"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression = "[_this,'TMF_BabelLanguages',_value] call tmf_common_fnc_initGroupVar;";// "_this setVariable ['TMF_BabelLanguages',_value,true];";
                        wikiType = "[[String]]";
                        defaultValue = "[]";
                    };
                    class TMF_Network
                    {
                        displayName = "Radio Network"; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_Network"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression = "[_this,'TMF_Network',_value] call tmf_common_fnc_initGroupVar;";// expression = "_this setVariable ['TMF_Network',_value,true];";
                        wikiType = "[[Number]]";
                        defaultValue = -1;                        
                    };
                    class TMF_Channellist
                    {
                        displayName = "Radio channel list"; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_Channellist"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression = "[_this,'TMF_Channellist',_value] call tmf_common_fnc_initGroupVar;";// expression = "_this setVariable ['TMF_Channellist',_value,true];";
                        defaultValue = "[]";
                        wikiType = "[[String]]";
                    };
                    class TMF_ChannellistLeader
                    {
                        displayName = "Leader radio channel list"; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_ChannellistLeader"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression = "[_this,'TMF_ChannellistLeader',_value] call tmf_common_fnc_initGroupVar;";// expression = "_this setVariable ['TMF_ChannellistLeader',_value,true];";
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
                //displayName = "TMF: Marker"; // Category name visible in Edit Attributes window
                //collapsed = 1; // When 1, the category is collapsed by default
                class Attributes
                {
                    class TMF_Network
                    {
                        displayName = "Radio Network"; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_Network"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression = "_this setVariable ['TMF_Network',_value,true];";
                        wikiType = "[[Number]]";
                        defaultValue = -1;
                        condition = "objectBrain"; // Condition for attribute to appear (see the table below)
                    };
                    class TMF_Channellist
                    {
                        displayName = "Radio channel list"; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_Channellist"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression = "_this setVariable ['TMF_Channellist',_value,true];";
                        defaultValue = "[]";
                        wikiType = "[[String]]";
                        condition = "objectBrain"; // Condition for attribute to appear (see the table below)
                    };
                    class TMF_BabelLanguages
                    {
                        displayName = "Babel languages"; // Name assigned to UI control class Title
                        tooltip = ""; // Tooltip assigned to UI control class Title
                        property = "TMF_BabelLanguages"; // Unique config property name saved in SQM
                        control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                        expression = "_this setVariable ['TMF_BabelLanguages',_value,true];";
                        wikiType = "[[String]]";
                        defaultValue = "[]";
                        condition = "objectBrain"; // Condition for attribute to appear (see the table below)
                    };
                };
            };
        };
    };

    class Attributes
    {
        class Title;
        class Toolbox; //class Toolbox: Title
        
        class TMF_AcreAddRadioActions : Toolbox {
            scriptName = "AcreAddRadioActions";
            scriptPath = "TMF_acre2";
            onLoad = "['onLoad',_this,'AcreAddRadioActions','TMF_acre2',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
            onUnload = "['onUnload',_this,'AcreAddRadioActions','TMF_acre2',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');";
            
            attributeLoad = "['attributeLoad',_this] call (uinamespace getvariable 'AcreAddRadioActions_script');";
            attributeSave = "['attributeSave',_this] call (uinamespace getvariable 'AcreAddRadioActions_script');";
            
            w = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) * GRID_W;
            h = 6 * SIZE_M * GRID_H;
            class Controls
            {
                class ActionTitle : ctrlStatic
                {
                    text = "Radios available via action:";
                    style = ST_RIGHT;
                    w = ATTRIBUTE_TITLE_W * GRID_W;
                    x = 0;
                    h = 1 * SIZE_M * GRID_H;                    
                    y = 0;
                    colorBackground[] = {0,0,0,0};
                    tooltip = "These radios will be available for selection (via scroll wheel action) for the first 5 minutes after the player has spawned.";
                };
                class ActionListBackground : ctrlStatic
                {
                    idc = 313208;
                    x = (ATTRIBUTE_TITLE_W) * GRID_W;
                    y = 0 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 6 * SIZE_M * GRID_H;
                    colorBackground[] = {0.33,0.33,0.33,1};
                };
                class ActionList: ctrlListNBox
                {
                    idc = 101;
                    x = (ATTRIBUTE_TITLE_W) * GRID_W;
                    y = 0 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 6 * SIZE_M * GRID_H;
                    drawSideArrows = 0;//1;
                    idcLeft = -1;
                    idcRight = -1;
                    columns[] = {0,0}; //0.05,0.15,0.85};
                    disableOverflow = 1;
                };

            };
        };
        
        class BabelSettings : Toolbox
        {
            scriptName = "BabelSettings";
            scriptPath = "TMF_acre2";
            onLoad = "['onLoad',_this,'BabelSettings','TMF_acre2',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
            onUnload = "['onUnload',_this,'BabelSettings','TMF_acre2',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');";

            attributeLoad = "['attributeLoad',_this] call (uinamespace getvariable 'BabelSettings_script');";
            attributeSave = "['attributeSave',_this] call (uinamespace getvariable 'BabelSettings_script');";
            
            w = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) * GRID_W;
            h = 16 * SIZE_M * GRID_H;
            class Controls
            {
                class LangTitle : ctrlStatic
                {
                    text = "Languages:";
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) * GRID_W;
                    h = 1 * SIZE_M * GRID_H;                    
                    y = 0;
                    x = SIZE_M * GRID_W;
                    colorBackground[] = {0,0,0,0};
                };                    
                class SpeakersTitle : LangTitle
                {
                    text = "Language speakers:";
                    x = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W-SIZE_M)/2) * GRID_W;
                };
                class ButtonSpeakerMake : RscButtonMenu
                {
                    text = "Grant";
                    h = SIZE_M * GRID_H;
                    x = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W;
                    w = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/2;
                    y = 1 * SIZE_M * GRID_H;
                    action = "['langTreeGive',_this] call (uinamespace getvariable 'BabelSettings_script');";
                    tooltip = "Make the selected element speak the selected language.";
                };
                class ButtonSpeakerRemove: ButtonSpeakerMake
                {
                    text = "Remove";
                    x = (((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - SIZE_M)/2) ) * GRID_W)/2) + (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W);
                    action = "['langTreeRemove',_this] call (uinamespace getvariable 'BabelSettings_script');";
                    tooltip = "Remove the selected element from speaking the selected language.";
                };
                class SpeakerTree : ctrlTree
                {
                    idc = 189437;
                    x = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - SIZE_M)/2)) * GRID_W; //(((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) * GRID_W)/2) - SIZE_M;
                    y = 2 * SIZE_M * GRID_H;
                    h = 14 * SIZE_M * GRID_H;
                    multiselectEnabled = 1;
                    disableKeyboardSearch = 1;
                    colorDisabled[] = {1,1,1,0.25};
                    action = "['treeClick',_this] call (uinamespace getvariable 'BabelSettings_script');";
                    onTreeDblClick = "['treeDoubleClick',_this] call (uinamespace getvariable 'BabelSettings_script');";
                };
                class ListBackground: ctrlStatic
                {
                    x = SIZE_M * GRID_W;
                    y = 2 * SIZE_M * GRID_H;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 14 * SIZE_M * GRID_H;
                    colorBackground[] = {1,1,1,0.1};
                };
                class ButtonLangAdd : RscButtonMenu
                {
                    text = "Add";
                    h = SIZE_M * GRID_H;
                    x = SIZE_M * GRID_W;
                    w = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3;
                    y = 1 * SIZE_M * GRID_H;
                    action = "['langAddClick',_this] call (uinamespace getvariable 'BabelSettings_script');";
                    tooltip = "Add a new language.";
                };
                class ButtonLangEdit: ButtonLangAdd
                {
                    text = "Edit";
                    x = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3 + SIZE_M * GRID_W;
                    action = "['langEditClick',_this] call (uinamespace getvariable 'BabelSettings_script');";
                    tooltip = "Edit the selected language.";
                };
                class ButtonLangDel : ButtonLangAdd
                {
                    text = "Delete";
                    x = (((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3) *2 + SIZE_M * GRID_W;
                    action = "['langDelClick',_this] call (uinamespace getvariable 'BabelSettings_script');";
                    tooltip = "Delete the selected language.";
                };
                class LangList: ctrlListNBox
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
                    onLBSelChanged = "with uiNamespace do {  ['refreshLangTree',_this] call (uinamespace getvariable 'BabelSettings_script'); };";
                };
                // Edit language Box
                class EditLanguageBackgroundS: ctrlStatic
                {
                    idc = 313208;
                    x = SIZE_M * GRID_W;
                    y = 1 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 15 * SIZE_M * GRID_H;
                    colorBackground[] = {0.33,0.33,0.33,1};
                };
                class EditLanguageButtonOk : ButtonSpeakerMake
                {
                    idc = 313209;
                    text = "Okay";
                    y = 12.25 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 7;
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 7)*2.1875 + SIZE_M * GRID_W;
                    action = "['languageEditClickOkay',_this] call (uinamespace getvariable 'BabelSettings_script');";
                };
                class EditLanguageButtonCancel : EditLanguageButtonOk
                {
                    idc = 313210;
                    text = "Cancel";
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 7)*3.9375 + SIZE_M * GRID_W;
                    action = "['languageDelClickCancel',_this] call (uinamespace getvariable 'BabelSettings_script');";
                };
                
                class EditLanguageTitle : LangTitle
                {
                    idc = 313201;
                    text = "Add/Edit Language";
                    y = 1 * SIZE_M * GRID_H;
                    x = SIZE_M * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W;
                    colorBackground[] = {0.1,0.1,0.1,1};
                };
                
                class EditLanguageShortTitle : LangTitle
                {
                    idc = 313202;
                    text = "Language Name:";
                    y = 3 * SIZE_M * GRID_H;
                    x = 2 * SIZE_M * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W;
                };
                class EditLanguageShort : ctrlEdit
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

            };
        };
        class RadioChannels : Toolbox
        {
            scriptName = "RadioChannels";
            scriptPath = "TMF_acre2";
            onLoad = "['onLoad',_this,'RadioChannels','TMF_acre2',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
            onUnload = "['onUnload',_this,'RadioChannels','TMF_acre2',false] call (uinamespace getvariable 'BIS_fnc_initDisplay');";

            attributeLoad = "['attributeLoad', _this, _value] call (uinamespace getvariable 'RadioChannels_script');";
            attributeSave = "['attributeSave',_this] call (uinamespace getvariable 'RadioChannels_script');";
            
            w = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) * GRID_W;
            h = (32 * SIZE_M + 1) * GRID_H;
                    
            //Attribute_Title_W = left side? Attribute_content_W = right Side?
            // SIZE_M <- size of margin (relatively big-ish)
            class Controls
            {
                
                class Title0: ctrlStatic
                {
                    text = "Radio network allocation:";
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) * GRID_W;
                    h = 1 * SIZE_M * GRID_H;                    
                    y = 0;
                    x = SIZE_M * GRID_W;
                    colorBackground[] = {0,0,0,0};
                    tooltip = "Each network is a collection of radio channels. The network number is displayed on the right side below. To assign a different network select the entity below and press the number on your keyboard for the network number you wish to assign.";
                };
                
                class NetworkTree : ctrlTree
                {
                    idc = 189438;
                    x = SIZE_M * GRID_W;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - SIZE_M))) * GRID_W; //(((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) * GRID_W)/2) - SIZE_M;
                    y = 2 * SIZE_M * GRID_H;
                    h = 10 * SIZE_M * GRID_H;
                    multiselectEnabled = 0;
                    disableKeyboardSearch = 1;
                    colorDisabled[] = {1,1,1,0.25};
                    action = "['presetTreeClick',_this] call (uinamespace getvariable 'RadioChannels_script');";
                    onTreeDblClick = "['presetTreeDoubleClick',_this] call (uinamespace getvariable 'RadioChannels_script');";
                };
                
                class MyLine:RscText
                {
                     style = ST_LINE;
                     colorText[] = {1,1,1,1.0}; // to whatever gives you a thrill
                     x = (SIZE_M * GRID_W);
                     h = (SIZE_M * GRID_H)/10;
                     y = SIZE_M * GRID_H * 12.4;
                     w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)) * GRID_W);
                };
                
                class networkButton : RscButtonMenu
                {
                    idc = 1502;
                    class Attributes {
                        align = "center";
                    };
                    text = "&lt; Configure Network 1 &gt;";
                    h = SIZE_M * GRID_H;
                    x = SIZE_M * GRID_W;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W);
                    y = SIZE_M * GRID_H * 13;
                    action = "['networkToggleButton',_this] call (uinamespace getvariable 'RadioChannels_script');";
                    tooltip = "Toggle through the radio networks.";
                };
                
                class Title1: Title0
                {
                    text = "Channels of selected network:";
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) * GRID_W;
                    h = 1 * SIZE_M * GRID_H;                    
                    y = SIZE_M * GRID_H * 14;
                    x = SIZE_M * GRID_W;
                    colorBackground[] = {0,0,0,0};
                    tooltip = "";
                };
                
                class Title2 : Title1
                {
                    text = "Entities present on selected channel:";
                    x = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W-SIZE_M)/2) * GRID_W;
                    tooltip = "";
                };
                class ButtonChannelGive : RscButtonMenu
                {
                    text = "Give";
                    h = SIZE_M * GRID_H;
                    x = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W;
                    w = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3;
                    y = 15 * SIZE_M * GRID_H;
                    action = "['channelTreeGive',_this] call (uinamespace getvariable 'RadioChannels_script');";
                    tooltip = "Put the selected element on the selected radio channel.";
                };
                class ButtonChannelLeader: ButtonChannelGive
                {
                    text = "Leader";
                    x = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - SIZE_M)/2) ) * GRID_W)/3 + (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W);
                    action = "['channelTreeLeader',_this] call (uinamespace getvariable 'RadioChannels_script');";
                    tooltip = "Make the leader of the group use the selected radio channel (Only avaiable on groups)";
                };
                class ButtonChannelRemove: ButtonChannelGive
                {
                    text = "Remove";
                    x = (((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - SIZE_M)/2) ) * GRID_W)/3) *2 + (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W);
                    action = "['channelTreeRemove',_this] call (uinamespace getvariable 'RadioChannels_script');";
                    tooltip = "Remove the selected radio channel from the selected element.";
                };
                class Value: ctrlTree
                {
                    idc = 189437;
                    x = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W+SIZE_M)/2) * GRID_W;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - SIZE_M)/2)) * GRID_W; //(((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) * GRID_W)/2) - SIZE_M;
                    y = 16 * SIZE_M * GRID_H;
                    h = 16 * SIZE_M * GRID_H;
                    multiselectEnabled = 1;
                    disableKeyboardSearch = 1;
                    colorDisabled[] = {1,1,1,0.25};
                    action = "['treeClick',_this] call (uinamespace getvariable 'RadioChannels_script');";
                    onTreeDblClick = "['treeDoubleClick',_this] call (uinamespace getvariable 'RadioChannels_script');";
                };
                class ListBackground: ctrlStatic
                {
                    x = SIZE_M * GRID_W;
                    y = 16 * SIZE_M * GRID_H;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 16 * SIZE_M * GRID_H;
                    colorBackground[] = {1,1,1,0.1};
                };
                class ButtonAdd2: RscButtonMenu
                {
                    text = "Add";
                    h = SIZE_M * GRID_H;
                    x = SIZE_M * GRID_W;
                    w = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3;
                    y = 15 * SIZE_M * GRID_H;
                    action = "['channelAddClick',_this] call (uinamespace getvariable 'RadioChannels_script');";
                    tooltip = "Add a radio channel to the present network";
                };
                class ButtonEdit: ButtonAdd2
                {
                    text = "Edit";
                    x = ((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3 + SIZE_M * GRID_W;
                    action = "['channelEditClick',_this] call (uinamespace getvariable 'RadioChannels_script');";
                    tooltip = "Edit the selected radio channel";
                };
                class ButtonDel: ButtonAdd2
                {
                    text = "Delete";
                    x = (((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W)/3) *2 + SIZE_M * GRID_W;
                    action = "['channelDelClick',_this] call (uinamespace getvariable 'RadioChannels_script');";
                    tooltip = "Delete the selected radio channel";
                };
                class List: ctrlListNBox
                {
                    idc = 101;
                    x = SIZE_M * GRID_W;
                    y = 16 * SIZE_M * GRID_H;
                    w = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W)/2) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 16 * SIZE_M * GRID_H;
                    drawSideArrows = 0;//1;
                    idcLeft = -1;
                    idcRight = -1;
                    columns[] = {0,0,0}; //0.05,0.15,0.85};
                    disableOverflow = 1;
                    onLBSelChanged = "with uiNamespace do {  ['refreshChannelTree',_this] call (uinamespace getvariable 'RadioChannels_script'); };";
                };
                class EditChannelBackgroundS: ctrlStatic
                {
                    idc = 313208;
                    x = SIZE_M * GRID_W;
                    y = 16 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 12.75 * SIZE_M * GRID_H;
                    colorBackground[] = {0.33,0.33,0.33,1};
                };
                class EditChannelButtonOk : ButtonAdd2
                {
                    idc = 313209;
                    text = "Okay";
                    y = 27.3 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 7;
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 7)*2.1875 + SIZE_M * GRID_W;
                    action = "['channelEditClickOkay',_this] call (uinamespace getvariable 'RadioChannels_script');";
                };
                class EditChannelButtonCancel : EditChannelButtonOk
                {
                    idc = 313210;
                    text = "Cancel";
                    x = (((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W / 7)*3.9375 + SIZE_M * GRID_W;
                    action = "['channelDelClickCancel',_this] call (uinamespace getvariable 'RadioChannels_script');";
                };
                
                class EditChannelTitle : Title1
                {
                    idc = 313201;
                    text = "Add/Edit Channel";
                    y = 16 * SIZE_M * GRID_H;
                    x = SIZE_M * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M ) * GRID_W;
                    colorBackground[] = {0.1,0.1,0.1,1};
                    tooltip = "";
                };
                
                class EditChannelShortTitle : Title1
                {
                    idc = 313202;
                    text = "Short channel name:";
                    y = 17 * SIZE_M * GRID_H;
                    x = 2*SIZE_M * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - (2*SIZE_M) ) * GRID_W;
                    tooltip = "";
                };
                class EditChannelShort : ctrlEdit
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
                    y = 18.15 * SIZE_M * GRID_H;
                    x = 2 * SIZE_M * GRID_W;
                    h = SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - (4 * SIZE_M) ) * GRID_W;
                };
                class EditChannelLongTitle : Title1
                {
                    idc = 313203;
                    text = "Long (Briefing) channel name:";
                    y = 19.3 * SIZE_M * GRID_H;
                    x = 2 * SIZE_M * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - (2* SIZE_M) ) * GRID_W;
                    tooltip = "";
                };
                class EditChannelLong: EditChannelShort
                {
                    idc = 313207;
                    text = "";
                    y = 20.45 * SIZE_M * GRID_H;
                };
                class EditChannelRadioTitle : Title1
                {
                    idc = 313204;
                    text = "Radio";
                    y = 21.6 * SIZE_M * GRID_H;
                    x = 2 *SIZE_M * GRID_W;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - (2*SIZE_M) ) * GRID_W;
                    tooltip = "";
                };
                class EditChannelRadioChooser: ctrlToolbox
                {
                    idc = 313205;
                    style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                    x = 2 * SIZE_M * GRID_W;
                    y = 22.75 * SIZE_M * GRID_H;
                    w = ((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - (4*SIZE_M) ) * GRID_W; //(ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - SIZE_M) * GRID_W;
                    h = 2 * SIZE_M * GRID_H;

                    rows = 1;
                    columns = 7;
                    strings[] = {
                        "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa", //+ static
                        "\idi\acre\addons\sys_prc148\Data\static\prc148_icon.paa",
                        "\idi\acre\addons\sys_prc152\Data\PRC152c_ico.paa",
                        "\idi\acre\addons\sys_prc117f\Data\PRC117F_ico.paa",
                        "\idi\acre\addons\sys_prc77\Data\prc77_icon.paa",
                        "\idi\acre\addons\sys_sem52sl\data\ui\sem52sl_icon.paa"
                    };
                    tooltips[] = {
                        "AN/PRC-343",
                        "AN/PRC-148",
                        "AN/PRC-152",
                        "AN/PRC-117F",
                        "AN/PRC-77",
                        "SEM52SL"
                    };
                };
                class SharedChannel : Title1
                {
                    idc = 313211;
                    text = "Share channel across networks:";
                    y = 24.9 * SIZE_M * GRID_H;
                    x = 2 *SIZE_M * GRID_W;
                    w = ATTRIBUTE_TITLE_W * GRID_W;
                    tooltip = "Mark this channel as shared. If a channel on another network has an identical shortname and is also a shared channel they will be linked together. Use this for channels that need that need to be cross-network.";
                };
                class SharedCheckBox : ctrlDefault {
                    idc = 313212;
                    y = 26.05 * SIZE_M * GRID_H;
                    x = 2 *SIZE_M * GRID_W;
                    w = SIZE_M * GRID_W;
                    h = SIZE_M * GRID_H;
                    text = "";
                    type = CT_CHECKBOX; // Type
                    //style = ST_LEFT + ST_MULTI; // Style

                    checked = 0; // Default state
                    
                    colorText[] = {COLOR_TEXT_RGBA}; // Text and frame color
                    colorSelect[] = {0,0,0,1}; // Text selection color
                    sizeEx = SIZEEX_PURISTA(SIZEEX_M); // Text size
                    font = FONT_NORMAL; // Font from CfgFontFamilies
                    shadow = 1; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)

                    colorPicture[] = {1,1,1,1}; // Picture color
                    colorPictureSelected[] = {1,1,1,1}; // Selected picture color
                    colorPictureDisabled[] = {1,1,1,0.25}; // Disabled picture color

                    colorPictureRight[] = {1,1,1,1}; //Color of picture on the right when item is unselected
                    colorPictureRightSelected[] = {1,1,1,1}; //Color of picture on the right when item is selected
                    colorPictureRightDisabled[] = {1,1,1,0.25}; //Color of picture on the right when ListBox is disabled

                    colorTextRight[] = {1,1,1,1}; //Color of text on the right when item is unselected
                    colorSelectRight[] = {1,1,1,0.25}; //First color of text on the right when item is selected
                    colorSelect2Right[] = {1,1,1,1}; //Second color of text on the right when item is selected

                    //Colors
                    color[] = {1,1,1,1}; // Texture color
                    colorFocused[] = {1,1,1,1}; // Focused texture color
                    colorHover[] = {1,1,1,1}; // Mouse over texture color
                    colorPressed[] = {1,1,1,1}; // Mouse pressed texture color
                    colorDisabled[] = {1,1,1,0.25}; // Disabled texture color

                    //Background colors
                    colorBackground[] = {0,0,0,0}; // Fill color
                    colorBackgroundFocused[] = {0,0,0,0}; // Focused fill color
                    colorBackgroundHover[] = {0,0,0,0}; // Mouse hover fill color
                    colorBackgroundPressed[] = {0,0,0,0}; // Mouse pressed fill color
                    colorBackgroundDisabled[] = {0,0,0,0}; // Disabled fill color

                    //Textures
                    textureChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureChecked_ca.paa";        //Texture of checked CheckBox.
                    textureUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureUnchecked_ca.paa";        //Texture of unchecked CheckBox.
                    textureFocusedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";    //Texture of checked focused CheckBox (Could be used for showing different texture when focused).
                    textureFocusedUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";    //Texture of unchecked focused CheckBox.
                    textureHoverChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
                    textureHoverUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
                    texturePressedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
                    texturePressedUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
                    textureDisabledChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
                    textureDisabledUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";

                    //Sounds
                    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1}; // Sound played after control is activated in format {file, volume, pitch}
                    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1}; // Sound played when mouse cursor enters the control
                    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1}; // Sound played when the control is pushed down
                    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1}; // Sound played when the control is released after pushing down

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
                    onMouseButtonClick = "";
                    onMouseButtonDblClick = "";
                    onMouseZChanged = "";
                    onMouseMoving = "";
                    onMouseHolding = "";

                    onCheckedChanged = "";
                    
                };
            };
        };
        
    };
};
