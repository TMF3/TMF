#include "\x\tmf\addons\spectator\script_component.hpp"
params["_unit","_parentIndex"];

disableSerialization;

GVAR(allunits) pushBackUnique _unit;

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
