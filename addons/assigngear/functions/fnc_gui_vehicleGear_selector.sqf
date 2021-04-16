#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_vehicleGear_selector
 * Author = Head
 *
 * Description:
 * Internal Use Only
 */
#include "\a3\3den\UI\dikCodes.inc"
#include "\a3\3den\UI\resincl.inc"
disableSerialization;
params ["_mode", "_args"];
TRACE_2("UI", _mode, _args);
private _currentFilter = (uiNamespace getVariable [QGVAR(filter), FILTER_WEAPON]);
private _data = (missionNamespace getVariable [QGVAR(vehicleGear_data), [ '', '', [ [],[],[] ] ]]);
_data params [ ['_currentCategory', '', ['']], ['_currentFaction', '', ['']], ['_cache', [ [], [], [] ], [[]], 3] ];
private _ctrlGroup = ctrlParentControlsGroup (_args # 0);
private _fnc_getFactionItems = {
    params ["_cfg", "_filter"];
    private _output = [];
    {
        if(_filter == FILTER_WEAPON) then {
            _output append ((_x >> 'primaryWeapon') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'magazines') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'scope') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'bipod') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'attachment') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'silencer') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'secondaryWeapon') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'secondaryAttachments') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'sidearmWeapon') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'sidearmAttachments') call BIS_fnc_getCfgDataArray);
        };
        if(_filter == FILTER_GEAR) then {
            _output append ((_x >> 'uniform') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'vest') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'backpack') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'headgear') call BIS_fnc_getCfgDataArray);
        };
        if(_filter == FILTER_ITEMS) then {
            _output append ((_x >> 'linkedItems') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'items') call BIS_fnc_getCfgDataArray);
            _output append ((_x >> 'backpackItems') call BIS_fnc_getCfgDataArray);
        };
    } forEach ("true" configClasses _cfg);
    _output = _output arrayIntersect _output;
    _output apply { [_x, 0] };
};



switch _mode do {
    case 'onLoad': {
        LOG("ON LOAD");
        uiNamespace setVariable[QGVAR(vehicleGear_control), _args # 0];
        uiNamespace setVariable [QGVAR(filter), FILTER_WEAPON];

        GVAR(vehicleGear_shift) = false;
        GVAR(vehicleGear_alt) = false;
        GVAR(vehicleGear_ctrl) = false;

        (_ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_CLEAR) ctrlAddEventHandler ["buttonClick", {
            ['clear', _this ] call FUNC(gui_vehicleGear_selector);
        }];

        // Add -/+ evenhandlers
        private _addButton = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_ADD;
        private _subButton = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_SUBTRACT;
        _addButton ctrlAddEventHandler ["buttonClick", {
            ['modifyRow', [(_this # 0), 1] ] call FUNC(gui_vehicleGear_selector);
        }];
        _subButton ctrlAddEventHandler ["buttonClick", {
            ['modifyRow', [(_this # 0), -1] ] call FUNC(gui_vehicleGear_selector);
        }];

        // We can only use the buttonClick event on the buttons, so this is a workaround for not getting the state of the modifier keys
        GVAR(vehicleGear_keyDown) = _ctrlGroup ctrlAddEventHandler ["KeyDown", {
            params ["_display", "_key", "_shift", "_ctrl", "_alt"];
            switch _key do {
                case DIK_LSHIFT: {
                    GVAR(vehicleGear_shift) = true;
                };
                case DIK_LCONTROL: {
                    GVAR(vehicleGear_ctrl) = true;
                };
                case DIK_LALT: {
                    GVAR(vehicleGear_alt) = true;
                };
            };
        }];
        GVAR(vehicleGear_keyUp) = _ctrlGroup ctrlAddEventHandler ["KeyUp", {
            params ["_display", "_key", "_shift", "_ctrl", "_alt"];
            switch _key do {
                case DIK_LSHIFT: {
                    GVAR(vehicleGear_shift) = false;
                };
                case DIK_LCONTROL: {
                    GVAR(vehicleGear_ctrl) = false;
                };
                case DIK_LALT: {
                    GVAR(vehicleGear_alt) = false;
                };
            };
        }];
        // fill them up.
        private _categoryCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_CATEGORY;
        private _factionCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;
        [_categoryCtrl] call FUNC(loadFactionCategories);
        for [{ _i = 0 }, { _i < (lbSize  _categoryCtrl) }, { _i = _i + 1 }] do {
            private _cat = _categoryCtrl lbData _i;
            if(_cat == _currentCategory) exitWith {
                _categoryCtrl lbSetCurSel _i;
            };
        };
        [_factionCtrl, _currentCategory] call FUNC(loadFactions);
        for [{ _i = 0 }, { _i < (lbSize  _factionCtrl) }, { _i = _i + 1 }] do {
            private _cat = _factionCtrl lbData _i;
            if(_cat == _currentFaction) exitWith {
                _factionCtrl lbSetCurSel _i;
            };
        };
    };
    case 'attributeLoaded': {
        private _categoryCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_CATEGORY;
        private _factionCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;

        // We add the selection eventhandler after we loaded the data from EDEN
        _categoryCtrl ctrlAddEventHandler ["LBSelChanged", {
            params ['_control', '_index'];
            GVAR(vehicleGear_data) set [0, _control lbData _index];
            ['categoryChanged', [ _control ]] call FUNC(gui_vehicleGear_selector);
        }];
        _factionCtrl ctrlAddEventHandler ["LBSelChanged",   {
            params ['_control', '_index'];
            GVAR(vehicleGear_data) set [1, _control lbData _index];
            ['filterChanged', [ _control, (uiNamespace getVariable [QGVAR(filter), FILTER_WEAPON]) ]] call FUNC(gui_vehicleGear_selector);
        }];
        GVAR(vehicleGear_data) set [0, _categoryCtrl lbData (lbCurSel _categoryCtrl)];
        GVAR(vehicleGear_data) set [1, _factionCtrl lbData (lbCurSel _factionCtrl)];
        TRACE_1("Updated vehicleData", GVAR(vehicleGear_data));
        ['filterChanged', [ _ctrlGroup,FILTER_WEAPON ]] call FUNC(gui_vehicleGear_selector);
    };
    case 'categoryChanged': {
        _args params ["_control", "_category"];
        private _factionCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;
        [_factionCtrl, _currentCategory] call FUNC(loadFactions);
        _factionCtrl lbSetCurSel 0;
    };
    case 'filterChanged': {
        _args params ["_control", "_newFilter"];

        uiNamespace setVariable [QGVAR(filter), _newFilter];
        private _factionCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;
        private _faction = _factionCtrl lbData (lbCurSel _factionCtrl);
        private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction)) then [
            {missionConfigFile},
            {configFile}
        ];

        _cfg = (_cfg >> "CfgLoadouts" >> _faction);
        private _ctrlList = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_LIST;
        private _rows = [_cfg, _newFilter] call _fnc_getFactionItems;
        private _currentCachePage = (_cache # _newFilter);


        lnbClear _ctrlList;
        {
            _x params ["_className", "_value"];
            private _index = _currentCachePage findIf { (_x # 0) == _className };
            if(_index >= 0) then {
                _x set [1, (_currentCachePage # _index) # 1];
                _value = (_currentCachePage # _index) # 1;
            };
            private _itemCfg = configNull;
            switch true do {
                case (isClass (configFile >> "CfgWeapons" >> _className)): { _itemCfg = (configFile >> "CfgWeapons") };
                case (isClass (configFile >> "CfgVehicles" >> _className)): { _itemCfg = (configFile >> "CfgVehicles") };
                case (isClass (configFile >> "CfgMagazines" >> _className)): { _itemCfg = (configFile >> "CfgMagazines") };
            };
            private _displayName = (_itemCfg >> _className >> "displayName") call BIS_fnc_getCfgData;
            private _rowIndex = _ctrlList lnbAddRow ["",_displayName, str _value,""];
            _ctrlList lnbSetData [[_rowIndex, 0], _className];
            _ctrlList lnbSetValue [[_rowIndex, 0], _value];
            _ctrlList lnbSetPicture [[_rowIndex, 0], (_itemCfg >> _className >> "picture") call BIS_fnc_getCfgData];
        } forEach _rows;

        _cache set [_newFilter, _rows];
    };
    case 'modifyRow': {
        _args params ['_control', '_baseAmount'];
        private _amount = switch true do {
            case GVAR(vehicleGear_shift) : {
                5 * _baseAmount
            };
            case GVAR(vehicleGear_ctrl) : {
                10 * _baseAmount
            };
            case GVAR(vehicleGear_alt) : {
                20 * _baseAmount
            };
            default {
                _baseAmount
            };
        };
        private _ctrlList = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_LIST;
        private _rowIndex = lnbCurSelRow _ctrlList;
        private _value = ((_ctrlList lnbValue [_rowIndex, 0]) + _amount) max 0;

        _ctrlList lnbSetValue  [[_rowIndex, 0], _value];
        _ctrlList lnbSetText [[_rowIndex, 2], str _value];

        private _className = _ctrlList lnbData [_rowIndex, 0];

        private _currentCachePage = (_cache # _currentFilter);
        private _itemIndex = _currentCachePage findIf { (_x # 0) == _className };
        private _item = _currentCachePage # _itemIndex;
        _item set [1, _value];
    };

    case 'clear': {
        _cache set [0, []];
        _cache set [1, []];
        _cache set [2, []];
        ['filterChanged', [ _ctrlGroup, _currentFilter ]] call FUNC(gui_vehicleGear_selector);
    };
};
