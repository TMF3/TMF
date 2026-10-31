#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_deadMan","_killer","_instigator"];

if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill

if(count (_deadMan getVariable [QGVAR(tagControl),[]]) > 0) then {
    ctrlDelete ((_deadMan getVariable [QGVAR(tagControl),[controlNull]]) select 0);
};

if(!(side _deadMan in [blufor,opfor,independent,civilian]) || !(_deadMan isKindOf "CAManBase" || _deadMan isKindOf "AllVehicles") ) exitwith {};
if(isNull _instigator || _instigator == _deadMan) then {
    _instigator = _deadMan getVariable [QGVAR(lastDamage),objNull];
};

private _kName = "";
private _dName = "";
private _isPlayer = isPlayer _deadMan;
if(_isPlayer) then {_dName = name (_deadMan);};
if(isPlayer _instigator) then {_kName = name (_instigator);};
if(_dName == "") then { _dName = getText (configFile >> "CfgVehicles" >> typeOf _deadMan >> "displayName"); };
if(_kName == "") then { _kName = getText (configFile >> "CfgVehicles" >> typeOf _instigator >> "displayName"); };
private _weapon = getText (configFile >> "CfgWeapons" >> currentWeapon _instigator >> "displayName");
if (!isNull (objectParent _instigator)) then { _weapon = getText (configFile >> "CfgVehicles" >> typeOf (vehicle _instigator) >> "displayName");};
GVAR(killList_forceUpdate) = true;
GVAR(killedUnits) pushback [_deadMan,time,_instigator,side group _deadMan,side group _instigator,_dName,_kName,_weapon,_isPlayer];
