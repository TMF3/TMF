#define DEBUG_MODE_FULL
#include "\x\tmf\addons\assignGear\script_component.hpp"
#include "\a3\3den\UI\dikCodes.inc"
#include "\a3\3DEN\UI\resincl.inc"
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
        LOG("ON LOAD")
        uiNamespace setVariable[QGVAR(vehicleGear_control), _args # 0];
        uiNamespace setVariable [QGVAR(filter), FILTER_WEAPON];

        private _categoryCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_CATEGORY;
        private _factionCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;

        private _addButton = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_ADD;
		private _subButton = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_SUBTRACT;

        GVAR(vehicleGear_shift) = false;
        GVAR(vehicleGear_alt) = false;
        GVAR(vehicleGear_ctrl) = false;
        private _ctrlList = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_LIST;
        _addButton ctrlAddEventHandler ["buttonClick", {
            params ['_control'];
            private _value = switch true do {
                case GVAR(vehicleGear_shift) : {
                    5
                };
                case GVAR(vehicleGear_ctrl) : {
                    10
                };
                case GVAR(vehicleGear_alt) : {
                    20
                };
                default {
                    1
                };
            };
            ['modifyRow', [_control, _value] ] call FUNC(gui_vehicleGear_selector);
        }];
        _subButton ctrlAddEventHandler ["buttonClick", {
            params ['_control'];
            private _value = switch true do {
                case GVAR(vehicleGear_shift): {
                    5
                };
                case GVAR(vehicleGear_ctrl): {
                    10
                };
                case GVAR(vehicleGear_alt): {
                    20
                };
                default {
                    1
                };
            };
            ['modifyRow', [_control, -_value] ] call FUNC(gui_vehicleGear_selector);
        }];
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
    case 'attributedLoaded': {
        private _categoryCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_CATEGORY;
        private _factionCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;
        _categoryCtrl ctrlAddEventHandler ["LBSelChanged", {
            params ['_control', '_index'];
            GVAR(vehicleGear_data) set [0, _control lbData _index];
            ['filterChanged', [ _control, (uiNamespace getVariable [QGVAR(filter), FILTER_WEAPON]) ]] call FUNC(gui_vehicleGear_selector);
        }];
        _factionCtrl ctrlAddEventHandler ["LBSelChanged", {
            params ['_control', '_index'];
            GVAR(vehicleGear_data) set [1, _control lbData _index];
            ['filterChanged', [ _control, (uiNamespace getVariable [QGVAR(filter), FILTER_WEAPON]) ]] call FUNC(gui_vehicleGear_selector);
        }];
        GVAR(vehicleGear_data) set [0, _categoryCtrl lbData (lbCurSel _categoryCtrl)];
        GVAR(vehicleGear_data) set [1, _factionCtrl lbData (lbCurSel _factionCtrl)];
        TRACE_1("Updated vehicleData", GVAR(vehicleGear_data));
        ['filterChanged', [ _ctrlGroup,FILTER_WEAPON ]] call FUNC(gui_vehicleGear_selector);
    };
    case 'filterChanged': {
        _args params ["_control", "_mode"];

        uiNamespace setVariable [QGVAR(filter), _mode];
        _currentFilter = (uiNamespace getVariable [QGVAR(filter), FILTER_WEAPON]);
        private _categoryCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_CATEGORY;
        private _factionCtrl = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_FACTION;
        private _faction = _factionCtrl lbData (lbCurSel _factionCtrl);
        private _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction)) then [
            {missionConfigFile},
            {configFile}
        ];

        _cfg = (_cfg >> "CfgLoadouts" >> _faction);
        private _ctrlList = _ctrlGroup controlsGroupCtrl IDC_VEHICLEGEAR_LIST;
        private _rows = [_cfg, _currentFilter] call _fnc_getFactionItems;
        private _currentCachePage = (_cache # _currentFilter);


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

        _cache set [_currentFilter, _rows];
    };
    case 'modifyRow': {
        _args params ['_control', '_amount'];
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
};