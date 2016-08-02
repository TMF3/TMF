#include "\x\tmf\addons\debrief\script_component.hpp"
params ["_display","_side"];
_display = ctrlParent _display;
_deadAssets = GVAR(destroyedUnits) select {_x select 1 == _side};

_listbox = _display displayCtrl 106;
_men = 0;
_units = [];
{
  _class = (configFile >> "CfgVehicles" >> (_x select 0));
  _parents = [_class,true] call BIS_fnc_returnParents;
  if("Man" in _parents) then {
    _men = _men + 1;
  }
  else {
    _units pushback getText (_class >> "displayName");
  };
} foreach _deadAssets;

{
  _listbox lbAdd _x;
} foreach _units;
