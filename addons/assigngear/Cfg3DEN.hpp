#include "\a3\3DEN\UI\macros.inc"

//TODO: modify enabled to hook into save attributes (for multi-unit edit)
//TODO: investigate removing the need for enabled/side/faction/role attributes in mission.sqm
//   By keeping them on defaults and modifying attributesave/attributeload to modify the full instead.

class ctrlCombo;
class ctrlStatic;
class Cfg3DEN
{
    class Object
    {
        class AttributeCategories
        {
            class TMF_assignGear
            {
                displayName = "TMF: Assign Gear";
                collapsed = 0;
                class Attributes
                {
                    class TMF_assignGear_enabled
                    {
                        property = "TMF_assignGear_enabled";
                        displayName = "Enabled";
                        tooltip = "Toggle assignGear.";
                        condition = "objectBrain";
                        control = "Checkbox";
                        //expression = "_this setVariable ['TMF_assignGear_enabled',_value,true];";
                        defaultValue = "false";
                        wikiType = "[[Bool]]";
                    };
                    class TMF_assignGear_Side
                    {
                        /* assignGear_side was traditionally used as an attribute for storing the side in the old assign gear spec. It is now a dummy for the category.*/
                        //if (!([[1,0,1]] call EFUNC(common,checkTMFVersion))) exitWith {};
                        // getMissionConfigValue ["tmf_version",-1]
                        property = "TMF_assignGear_side";
                        displayName = "Category";
                        tooltip = "Select a faction category.";
                        condition = "objectBrain";
                        control = "TMF_Side";
                        //expression = "_this setVariable ['TMF_assignGear_side',_value,true];";
                        defaultValue = "-1"; /* (side _this) call BIS_fnc_sideID;*/
                        wikiType = "[[Number]]";
                    };
                    class TMF_assignGear_faction
                    {
                        property = "TMF_assignGear_faction";
                        displayName = "Faction";
                        tooltip = "Select a faction.";
                        condition = "objectBrain";
                        control = "TMF_Faction";
                        //expression = "_this setVariable ['TMF_assignGear_faction',_value,true];";
                        defaultValue = "toLower(faction _this)";
                        wikiType = "[[String]]";
                    };
                    class TMF_assignGear_role
                    {
                        property = "TMF_assignGear_role";
                        displayName = "Role";
                        tooltip = "Select a role.";
                        condition = "objectBrain";
                        control = "TMF_Role";
                        //expression = "_this setVariable ['TMF_assignGear_role',_value,true];";
                        defaultValue = "'r'";
                        value = "''";
                        wikiType = "[[String]]";
                    };
                    class TMF_assignGear_full
                    {
                        property = "TMF_assignGear_full";
                        condition = "objectBrain";
                        control = "None";
                        expression = "[_this,_value] call tmf_assignGear_fnc_helper;";
                        defaultValue = "['r','',false]";
                    };
                };
            };
        };
    };
    class Attributes
    {
        class Title;
        class Combo;
        class Value;
        class Controls;
        // The commented below worked well for single units, but for multi-units does not work.
        /*class None;
        class TMF_assignGear_None : None
        {
            attributeLoad = "Sniper_test = [_value,_this]";

            attributeSave = "private _objects = get3DENSelected 'object'; \
                private _array = []; \
                if (count _objects > 0) then { \
                    private _x = _objects select 0; \
                    _array = [(_x get3DENAttribute 'TMF_assignGear_role') select 0, \
                    (_x get3DENAttribute 'TMF_assignGear_faction') select 0, \
                    (_x get3DENAttribute 'TMF_assignGear_side') select 0, \
                    (_x get3DENAttribute 'TMF_assignGear_enabled') select 0]; \
                }; \
                (str _array)";
            /
        };*/
        class TMF_Side : Combo
        {
            /* TMF_Side is a faction category chooser - name renames for backwards compatabiliy */
            onLoad = "uiNamespace setVariable ['AttributeTMF_Side',(_this select 0) controlsGroupCtrl 100]; [(_this select 0) controlsGroupCtrl 100] call TMF_assignGear_fnc_loadFactionCategories;";
            attributeLoad = "";
            attributeSave = "-1";
            class Controls : Controls
            {
                class Title : Title {};
                class ValueSide : Value
                {
                    idc = 100;
                    onLBSelChanged = "\
                        _ctrlFaction = (uiNamespace getVariable ['AttributeTMF_Faction',controlNull]) controlsGroupCtrl 100;\
                        [_ctrlFaction,(_this select 0) lbData (_this select 1)] call TMF_assignGear_fnc_loadFactions;\
                    ";
                };
            };
        };
        class TMF_Faction: Combo
        {
            onLoad = "uiNamespace setVariable ['AttributeTMF_Faction',_this select 0]; [(_this select 0) controlsGroupCtrl 100] call TMF_assignGear_fnc_loadFactions;";
            attributeLoad = "";
            attributeSave = "\
                _ctrlFaction = _this controlsGroupCtrl 100;\
                private _output = _ctrlFaction lbData lbCurSel _ctrlFaction;\
                private _objects = get3DENSelected 'object'; \
                { \
                    private _array = [(_x get3DENAttribute 'TMF_assignGear_role') select 0, \
                    _output, \
                    (_x get3DENAttribute 'TMF_assignGear_enabled') select 0]; \
                    _x set3DENAttribute ['TMF_assignGear_full',(str _array)]; \
                } forEach _objects; \
                _output; \
            ";
            class Controls : Controls
            {
                class Title : Title {};
                class ValueFaction: Value
                {
                    idc = 100;
                    // TYPE
                    onLBSelChanged = "\
                        _ctrlRole = uiNamespace getVariable ['AttributeTMF_Role',controlNull];\
                        [\
                            _ctrlRole,\
                            _ctrlRole lbData (lbCurSel _ctrlRole),\
                            (_this select 0) lbData (_this select 1)\
                        ] call (missionNamespace getVariable 'TMF_assignGear_fnc_loadRoles');\
                    ";
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    h = SIZE_M * GRID_H;
                };
            };
        };
        class TMF_Role: Combo
        {
            onLoad = "uiNamespace setVariable ['AttributeTMF_Role',(_this select 0) controlsGroupCtrl 100];";
            attributeLoad = "\
                _ctrlRole = _this controlsGroupCtrl 100 ;\
                [_ctrlRole,_value] call TMF_assignGear_fnc_loadRoles;\
            ";
            attributeSave = "\
                _ctrlRole = _this controlsGroupCtrl 100;\
                private _output = _ctrlRole lbData lbCurSel _ctrlRole;\
                private _objects = get3DENSelected 'object'; \
                { \
                    _array = [_output, \
                    (_x get3DENAttribute 'TMF_assignGear_faction') select 0, \
                    (_x get3DENAttribute 'TMF_assignGear_enabled') select 0]; \
                    _x set3DENAttribute ['TMF_assignGear_full',(str _array)]; \
                } forEach _objects;  \
                _output; \
            ";
            class Controls
            {
                class Title: ctrlStatic {
                    style = 0x01;
                    x = 0;
                    w = ATTRIBUTE_TITLE_W * GRID_W;
                    h = SIZE_M * GRID_H;
                    colorBackground[] = {0,0,0,0};
                };
                class ValueRole: ctrlCombo
                {
                    idc = 100;
                    onLoad = "uiNamespace setVariable ['AttributeTMF_Role',_this select 0];";
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    h = SIZE_M * GRID_H;
                };
            };
        };
    };
    class EventHandlers
    {
        class ADDON
        {
            onMessage = QUOTE(_this call FUNC(onEdenMessageRecieved));
        };
    };
};
