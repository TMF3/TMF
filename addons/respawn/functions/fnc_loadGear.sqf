#include "\x\tmf\addons\respawn\script_component.hpp"
 /*
 * Name = TMF_respawn_fnc_loadGear
 * Author = Nick
 *
 * Arguments:
 * 0: Number. Numeric value of side of unit
 *
 * Return:
 * 0: Array.
 *
 * Description:
 * UI function do not use
 */
params ["_side"];
_side = toLower([_side] call CFUNC(sideType));
private _return = [];
private _factions = [];
private _classes = [];

{
    private _faction = toLower(configName _x);
    private _name =  getText(_x >> "displayName");
    _factions pushBack [_faction,_name];
} forEach (configProperties [configFile >> "CfgLoadouts" >> _side,"isClass _x"]);

{
    private _faction = toLower(configName _x);
    private _name =  getText(_x >> "displayName");
    _factions pushBackUnique [_faction,_name];
} forEach (configProperties [missionConfigFile >> "CfgLoadouts" >> _side,"isClass _x"]);

{
    _x params ["_faction","_name"];
    private _roles = [];
    if (isClass (missionConfigFile >> "CfgLoadouts" >> _side >> _faction)) then {
        _roles = configProperties [missionConfigFile >> "CfgLoadouts" >> _side >> _faction,"isClass _x"];
    } else {
        _roles = configProperties [configFile >> "CfgLoadouts" >> _side >> _faction,"isClass _x"];
    };
    // turn roles cfg into string names
    {_roles set [_forEachIndex,[configName _x,getText(_x >> "displayName")]]} forEach _roles;
    _classes pushBack _roles;
} forEach _factions;

{  _return pushBack [_x,_classes select _forEachIndex] } forEach _factions;

_return