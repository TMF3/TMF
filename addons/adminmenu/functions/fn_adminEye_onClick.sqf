#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

params["_fullmapWindow","_type","_x","_y"];

private _mousePos = [_x,_y];	   


if (_type == 0) then { // left click
	GVAR(adminEyeSelectedObj) = objNull;
	{
		private _pos = (position _x);
		if (_mousePos distance (_fullmapWindow posWorldToScreen _pos) < 0.1) exitWith {
			
			GVAR(adminEyeSelectedObj) = _x;
			
		};

	} forEach GVAR(Triggers);

	{
		private _pos = (position _x);
		if (_mousePos distance (_fullmapWindow posWorldToScreen _pos) < 0.1) exitWith {
			GVAR(adminEyeSelectedObj) = _x;
		};
	} forEach GVAR(WaveSpawners);
};
