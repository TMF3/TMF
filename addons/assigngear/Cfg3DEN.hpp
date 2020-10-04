#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\resincl.inc"
class ctrlCombo;
class ctrlStatic;
class ctrlToolbox;
class ctrlListNBox;
class ctrlButton;
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
                        defaultValue = "false";
                        wikiType = "[[Bool]]";
                    };
                    class TMF_assignGear_Side
                    {
                        property = "TMF_assignGear_side";
                        displayName = "Category";
                        tooltip = "Select a faction category.";
                        condition = "objectBrain";
                        control = "TMF_Side";
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
                        defaultValue = "'r'";
                        value = "''";
                        wikiType = "[[String]]";
                    };
                    class TMF_assignGear_full
                    {
                        property = "TMF_assignGear_full";
                        condition = "objectBrain";
                        control = "None";
                        expression = QUOTE([ARR_2(_this, _value)] call FUNC(helper));
                        defaultValue = "['r','',false]";
                    };
                };
            };
            class GVAR(vehicleGear) {
                displayName = "TMF: Vehicle Gear";
                collapsed = 0;
                class Attributes 
                {
                    class GVAR(vehicle)
                    {
                        property = QGVAR(vehicleContents);
                        condition = "objectHasInventoryCargo";
                        defaultValue = "['','',[ [], [], [] ]]";
                        expression = QUOTE([ARR_2(_this, _value)] call FUNC(vehicleGear_init));
                        control = QGVAR(AmmoBox);
                    };
                }
            }
        };
    };
    class Attributes
    {
        class Default;
        class Title: Default {
            class Controls {
                class Title;
            };
        };
        class Combo: Title {
           class Controls: Controls {
               class Title: Title {};
               class Value;
           };
        };
        class Value;
        class TitleWide;
        class Controls;

        // AI Gear module controls
        class GVARMAIN(DOUBLES(aigear,faction)) : Combo {
            INIT_CONTROL(GVARMAIN(AttributesFaction),ADDON)
        };

        class GVARMAIN(loadout) : Combo {
            class Controls: Controls {
                class Title: Title {};
                class Value: Value {
                    delete Items;
                    class ItemsConfig {
                        path[] = {"CfgLoadouts"};
                        localConfig = true;
                        propertyText = "displayName";
                        sort = true;
                    };
                };
            };
        };

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
        class GVAR(AmmoBox): TitleWide {
            onLoad = QUOTE( [ARR_2('onLoad', _this)] call FUNC(gui_vehicleGear_selector) );
            attributeLoad = QUOTE([_value] call FUNC(gui_vehicleGear_load));
            attributeSave = QUOTE([] call FUNC(gui_vehicleGear_save));
            h = (22 * ATTRIBUTE_CONTENT_H + 1) * GRID_H;
            class Controls: Controls
            {
                class CategoryTitle: ctrlStatic {
                    x = 0;
                    y = 0;
                    w = ATTRIBUTE_TITLE_W * GRID_W;
                    h = SIZE_XL * GRID_H;
                    text = "Category"
                    style = ST_RIGHT;
                    colorBackground[] = {0,0,0,0};
                };
                class CategoryValue: ctrlCombo
                {
                    idc = IDC_VEHICLEGEAR_CATEGORY;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    y = 0;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    h = SIZE_M * GRID_H;
                };
                class FactionTitle : ctrlStatic {
                    text = "Faction"
                    style = ST_RIGHT;
                    x = 0;
                    y = 1 * SIZE_XL * GRID_H;
                    w = ATTRIBUTE_TITLE_W * GRID_W;
                    h = SIZE_XL * GRID_H;
                    colorBackground[] = {0,0,0,0};
                };
                class FactionValue: ctrlCombo
                {
                    idc = IDC_VEHICLEGEAR_FACTION;
                    x = ATTRIBUTE_TITLE_W * GRID_W;
                    y = 1 * SIZE_XL * GRID_H;
                    w = ATTRIBUTE_CONTENT_W * GRID_W;
                    h = SIZE_M * GRID_H;
                };
                class Title2: Title
                {
                    text = "$STR_3den_attributes_ammobox_title2_text";
                    y = 2 * ATTRIBUTE_CONTENT_H * GRID_H;
                };
                class Filter: ctrlToolbox
                {
                    idc = IDC_VEHICLEGEAR_FILTER;
                    style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                    x = ATTRIBUTE_CONTENT_H * GRID_W;
                    y = 3 * ATTRIBUTE_CONTENT_H * GRID_H;
                    w = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - 5) * GRID_W;
                    h = 2 * ATTRIBUTE_CONTENT_H * GRID_H;
                    rows = 1;
                    columns = 3;
                    onToolBoxSelChanged = QUOTE( [ARR_2('filterChanged', _this)] call FUNC(gui_vehicleGear_selector) );
                    strings[] = {"\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_1_ca.paa", "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_8_ca.paa", "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_6_ca.paa" };
                };
                class ListBackground: ctrlStatic
                {
                    x = ATTRIBUTE_CONTENT_H * GRID_W;
                    y = 5 * ATTRIBUTE_CONTENT_H * GRID_H;
                    w = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - ATTRIBUTE_CONTENT_H) * GRID_W;
                    h = 13 * ATTRIBUTE_CONTENT_H * GRID_H;
                    colorBackground[] = {1,1,1,0.1};
                };
                class List: ctrlListNBox
                {
                    idc = IDC_VEHICLEGEAR_LIST;
                    x = ATTRIBUTE_CONTENT_H * GRID_W;
                    y = 5 * ATTRIBUTE_CONTENT_H * GRID_H;
                    w = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - 5) * GRID_W;
                    h = 13 * ATTRIBUTE_CONTENT_H * GRID_H;
                    drawSideArrows = 1;
                    idcLeft = IDC_VEHICLEGEAR_SUBTRACT;
                    idcRight = IDC_VEHICLEGEAR_ADD;
                    columns[] = {0.05,0.15,0.85};
                    disableOverflow = 1;
                };
                class ButtonClear: ctrlButton
                {
                    idc = IDC_VEHICLEGEAR_CLEAR;
                    text = "Clear";
                    x = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - 25) * GRID_W;
                    y = 19 * ATTRIBUTE_CONTENT_H * GRID_H;
                    w = 25 * GRID_W;
                    h = ATTRIBUTE_CONTENT_H * GRID_H;
                };
                class ArrowLeft: ctrlButton
                {
                    idc = IDC_VEHICLEGEAR_SUBTRACT;
                    text = "-";
                    font = "RobotoCondensedBold";
                    x = -1;
                    y = -1;
                    w = ATTRIBUTE_CONTENT_H * GRID_W;
                    h = ATTRIBUTE_CONTENT_H * GRID_H;
                };
                class ArrowRight: ArrowLeft
                {
                    idc = IDC_VEHICLEGEAR_ADD;
                    text = "+";
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
