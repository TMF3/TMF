#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

params["_fullmapWindow","_type","_x","_y"];
        
if (_type == 0) then { // left click
	private _i = 1;
	private _found = false;
	private _var = missionNamespace getVariable[format["tmf_respawnPoint%1",_i],objNull];
	while {!(isNull _var)} do {
		private _pos = (position _var);
		if (([_x,_y] distance (_fullmapWindow posWorldToScreen _pos)) < 0.1) then {
			GVAR(respawnMousePos) = _i;
			_found = true;
		};
		_i = _i + 1;
		_var = missionNamespace getVariable[format["tmf_respawnPoint%1",_i],objNull];
	};
	if (!_found) then {
		GVAR(respawnMousePos) = _fullmapWindow posScreenToWorld [_x,_y];
	};
};
