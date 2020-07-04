#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

params ["_ctrlComboFaction", "_index"];
private _faction = _ctrlComboFaction lbData _index;

private _factionConfig = configNull;
if ((_ctrlComboFaction lbValue _index) isEqualTo 1) then {
    _factionConfig = (missionConfigFile >> "CfgLoadouts" >> _faction);
} else {
    _factionConfig = (configFile >> "CfgLoadouts" >> _faction);
};

private _roles = ("true" configClasses _factionConfig) apply {[format ["%1 [%2]", getText (_x >> "displayName"), configName _x], toLower configName _x]};
_roles sort true;
private _rolesSimple = _roles apply {_x select 1};
private _tickCheckbox = false;

{
    (_x getVariable [QGVAR(association), [objNull, controlNull]]) params ["_player", "_ctrlComboRole"];

    private _playerRole = toLower (_player getVariable [QEGVAR(assigngear,role), ""]);
    if (_playerRole isEqualTo "" || !(_playerRole in _rolesSimple)) then {
        _playerRole = "r";
        _tickCheckbox = true;
    };

    while {(count _roles) < (lbSize _ctrlComboRole)} do {
        _ctrlComboRole lbDelete ((lbSize _ctrlComboRole) - 1);
    };

    {
        if (_forEachIndex >= (lbSize _ctrlComboRole)) then {
            _ctrlComboRole lbAdd (_x select 0);
        } else {
            _ctrlComboRole lbSetText [_forEachIndex, _x select 0];
        };

        _ctrlComboRole lbSetData [_forEachIndex, _x select 1];
        if ((_x select 1) isEqualTo _playerRole) then {
            _ctrlComboRole lbSetCurSel _forEachIndex;
        };
    } forEach _roles;

    if (_tickCheckbox) then {
        _x cbSetChecked true;
        _tickCheckbox = false;
    };
} forEach GVAR(utility_assigngear_rolectrls);
