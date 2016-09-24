
#include "\x\tmf\addons\spectator\script_component.hpp"
params["_unit","_parentIndex"];

disableSerialization;

GVAR(allunits) pushBackUnique _unit;
/*
private _enabled = _unit getVariable [QGVAR(fired_enabled),nil];
if (isNil "_enabled") then {
		_unit addEventHandler ["fired", "_this call tmf_spectator_fnc_onFired"];
};
_unit setVariable [QGVAR(fired_enabled), true];


if(vehicle _unit != _unit) then { // issue here when they leave and someone takes the vehicle...
	_enabled = (vehicle _unit) getVariable [QGVAR(fired_enabled),nil];
	if(isNil "_enabled") then {
		(vehicle _unit) addEventHandler ["fired", "_this call tmf_spectator_fnc_onFired"];
	};
	(vehicle _unit) setVariable [QGVAR(fired_enabled), true];
	GVAR(vehicles) pushBack (vehicle _unit);
};
*/


private _name = name _unit;
if ((_unit getVariable ["tmf_list_name",0]) isEqualTo 0) then {
    _unit setVariable ["tmf_list_name",name _unit]
};


private _unitListControl = (uiNamespace getVariable [QGVAR(unitlist),controlNull]);
private _index = _unitListControl tvAdd [[_parentIndex],_name];
_unitListControl tvSetData [[_parentIndex,_index],netId _unit];


private _icon = getText (configFile >> "CfgVehicles" >> typeof (vehicle _unit) >> "icon");
if (isText (configfile >> "CfgVehicleIcons" >> _icon )) then {
	_icon = getText (configfile >> "CfgVehicleIcons" >> _icon );
};
_unitListControl tvSetPicture [[_parentIndex,_index],_icon];
