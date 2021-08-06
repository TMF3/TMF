#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_vehicleGear_selector
 * Author = Head
 *
 * Description:
 * Internal Use Only
 */
#include "\a3\3den\UI\dikCodes.inc"
#include "\a3\3DEN\UI\resincl.inc"

disableSerialization;

TRACE_1("Vehicle Gear Selector run with",_this);

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_mode", '', ['']],
    "_args"
];

ASSERT_FALSE(isNull _ctrlGroup,"Failed loading ammobox UI");
private _ctrlCategory = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_CATEGORY;
private _ctrlFaction = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;
private _ctrlListSort = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_LISTSORT;
private _ctrlList = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_LIST;
private _ctrlFilter = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FILTER;
private _gearHash = _ctrlList getVariable QGVAR(gear);

private _fnc_getFactionItems = {
    params [
        ["_cfg", configNull, [configNull]],
        ["_filter", -1, [-1]]
    ];

    // Get cached data from namespace
    private _namespace = [] call FUNC(initNamespace);
    private _namespaceVarName = format ["ammobox_%1_%2", _faction, _newFilter];
    private _cachedData = _namespace getVariable _namespaceVarName;
    if !(isNil "_cachedData") exitWith {_cachedData};

    private _output = [];
    {
        switch _filter do {
            #define GET(t) ((getArray (_x >> t)) apply {[_x,t]})
            case FILTER_WEAPON: {
                _output append GET('primaryWeapon');
                _output append GET('magazines');
                _output append GET('scope');
                _output append GET('bipod');
                _output append GET('attachment');
                _output append GET('silencer');
                _output append GET('secondaryWeapon');
                _output append GET('secondaryAttachments');
                _output append GET('sidearmWeapon');
                _output append GET('sidearmAttachments');
            };
            case FILTER_GEAR: {
                _output append GET('uniform');
                _output append GET('vest');
                _output append GET('backpack');
                _output append GET('headgear');
                _output append GET('goggles');
            };
            case FILTER_ITEMS: {
                _output append GET('linkedItems');
                _output append GET('items');
                _output append GET('hmd');
                _output append GET('radios');
                _output append GET('backpackItems');
            };
            #undef GET
        };
    } forEach ("true" configClasses _cfg);
    UNIQUE(_output);
    _output = _output select {!((toLower (_x # 0)) in ["default", ""])};

    {
        _x params ["_class", "_type"];
        private _itemCfg = [_class] call CBA_fnc_getItemConfig;

        private _cfgSrcMod = configSourceMod _itemCfg;
        private _logo = "";
        private _name = "";
        if (_cfgSrcMod != "") then {
            private _modParams = modParams [_cfgSrcMod, ['logoSmall', 'name']];
            _logo = _modParams # 0;
            _name = _modParams # 1;
        };

        _x pushBack getText (_itemCfg >> "displayName");
        _x pushBack getText (_itemCfg >> "picture");
        _x pushBack _logo;
        _x pushBack _name;
    } forEach _output;

    [_output, 1] call CBA_fnc_sortNestedArray;

    TRACE_2("Cached vehiclegear data to namespace",_namespaceVarName,_output);
    _namespace setVariable [_namespaceVarName, _output];
    _output
};

switch _mode do {
    case 'onLoad': {
        if (isNil "_gearHash") then {
            // Gear hash not initialized
            _ctrlList setVariable [QGVAR(gear), createHashMap];
        };

        private _addButton = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_ADD;
        private _subButton = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_SUBTRACT;

        _ctrlFilter lbSetCurSel (uiNamespace getVariable [QGVAR(filter), FILTER_WEAPON]);
        _ctrlListSort lnbAddRow ["Item", "Type", "", "Mod"];
        _ctrlListSort lnbSetData [[0, 2], "SortByValue"];
        systemChat str lnbGetColumnsPosition _ctrlList;
        [
            _ctrlListSort,
            _ctrlList,
            [
                IDX_VG_NAME,
                IDX_VG_TYPE,
                IDX_VG_VALUE,
                IDX_VG_MOD
            ],
            IDC_VEHICLEGEAR_LISTSORT + 1
        ] call BIS_fnc_initListNBoxSorting;

        // Add -/+ evenhandlers
        _addButton ctrlAddEventHandler ["buttonClick", {
            params ["_ctrlButton"];
            [ctrlParentControlsGroup _ctrlButton, 'modifyRow', [1] ] call FUNC(gui_vehicleGear_selector);
        }];
        _subButton ctrlAddEventHandler ["buttonClick", {
            params ["_ctrlButton"];
            [ctrlParentControlsGroup _ctrlButton, 'modifyRow', [-1] ] call FUNC(gui_vehicleGear_selector);
        }];

        // We can only use the buttonClick event on the buttons, so this is a workaround for not getting the state of the modifier keys
        _ctrlGroup ctrlAddEventHandler ["KeyDown", {
            params ["_control", "_key", "_shift", "_ctrl", "_alt"];
            switch _key do {
                case DIK_LSHIFT: {
                    _control setVariable [QGVAR(shift), true];
                };
                case DIK_LCONTROL: {
                    _control setVariable [QGVAR(ctrl), true];
                };
                case DIK_LALT: {
                    _control setVariable [QGVAR(alt), true];
                };
            };
        }];
        _ctrlGroup ctrlAddEventHandler ["KeyUp", {
            params ["_control", "_key", "_shift", "_ctrl", "_alt"];
            switch _key do {
                case DIK_LSHIFT: {
                    _control setVariable [QGVAR(shift), false];
                };
                case DIK_LCONTROL: {
                    _control setVariable [QGVAR(ctrl), false];
                };
                case DIK_LALT: {
                    _control setVariable [QGVAR(alt), false];
                };
            };
        }];

        TRACE_2("Onload finished, created event handlers for",_addButton,_subButton);
    };

    case 'categoryChanged': {
        _args params ["_category"];
        TRACE_2("Ammobox Category Changed",_ctrlCategory,_category);
        [_ctrlFaction, _category] call FUNC(loadFactions);
        _ctrlFaction lbSetCurSel 0;
    };

    case 'filterChanged': {
        _args params [["_newFilter", FILTER_WEAPON, [0]]];

        lnbClear _ctrlList;

        uiNamespace setVariable [QGVAR(filter), _newFilter];
        private _faction = _ctrlFaction lbData (lbCurSel _ctrlFaction);
        private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction)) then [
            {missionConfigFile},
            {configFile}
        ];

        _cfg = (_cfg >> "CfgLoadouts" >> _faction);

        {
            _x params ["_className", "_type", "_displayName", "_picture", "_modLogo", "_modName"];

            private _value = _gearHash getOrDefault [toLower _className, 0];

            _ctrlList lnbAddRow ["", _displayName, _type, str _value, ""];
            _ctrlList lnbSetPicture [[_forEachIndex, IDX_VG_DATA], _picture];
            _ctrlList lnbSetTooltip [[_forEachIndex, IDX_VG_NAME], _className];
            _ctrlList lnbSetData [[_forEachIndex, IDX_VG_NAME], _className];
            _ctrlList lnbSetData [[_forEachIndex, IDX_VG_TYPE], _type];
            _ctrlList lnbSetValue [[_forEachIndex, IDX_VG_VALUE], _value];
            _ctrlList lnbSetPicture [[_forEachIndex, IDX_VG_MOD], _modLogo];
            _ctrlList lnbSetText [[_forEachIndex, IDX_VG_MOD], _modName];
            _ctrlList lnbSetColor [[_forEachIndex, IDX_VG_MOD], [0,0,0,0]]; // Transparent text for sorting

            // TRACE_6("Adding row to vehicle gear list",_forEachIndex,_className,_displayName,_picture,_logo,_value);
        } forEach ([_cfg, _newFilter] call _fnc_getFactionItems);
    };
    case 'modifyRow': {
        _args params ['_baseAmount'];

        private _amount = switch true do {
            case (_ctrlGroup getVariable [QGVAR(shift), false]): {5 * _baseAmount};
            case (_ctrlGroup getVariable [QGVAR(ctrl), false]): {10 * _baseAmount};
            case (_ctrlGroup getVariable [QGVAR(alt), false]): {20 * _baseAmount};
            default {_baseAmount};
        };
        private _rowIndex = lnbCurSelRow _ctrlList;
        private _class = _ctrlList lnbData [_rowIndex, IDX_VG_NAME];
        private _value = (_ctrlList lnbValue [_rowIndex, IDX_VG_VALUE]) + _amount;

        _gearHash set [
            _class,
            _value max 0
        ];

        _ctrlList lnbSetValue [[_rowIndex, IDX_VG_VALUE], _gearHash get _class];
        _ctrlList lnbSetText [[_rowIndex, IDX_VG_VALUE], str (_gearHash get _class)];

        TRACE_3("Ammobox modified row",_class,_value,_gearHash);
    };

    case 'clear': {
        _ctrlList setVariable [QGVAR(gear), createHashMap];
        [
            _ctrlGroup,
            'filterChanged',
            uiNamespace getVariable [QGVAR(filter), FILTER_WEAPON]
        ] call FUNC(gui_vehicleGear_selector);
    };

    default {
        ERROR_1("Invalid ammobox UI selector mode: %1",_mode);
    };
};
