#include "\x\tmf\addons\adminmenu\script_component.hpp"

{
	if (local _x) then {
		["ace_medical_treatmentAdvanced_fullHealLocal", [player, _x]] call CBA_fnc_localEvent;
		systemChat "[TMF Admin Menu] Your health was restored";
	} else {
		["ace_medical_treatmentAdvanced_fullHealLocal", [player, _x], _x] call CBA_fnc_targetEvent;
		(format ["[TMF Admin Menu] Your health was restored by '%1'", profileName]) remoteExec ["systemChat", _x];
	};
} forEach GVAR(utility_data);

systemChat format ["[TMF Admin Menu] %1 players had their health restored", count GVAR(utility_data)];