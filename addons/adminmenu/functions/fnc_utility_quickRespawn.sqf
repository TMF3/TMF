#include "\x\tmf\addons\adminmenu\script_component.hpp"

systemChat "[TMF Admin Menu] Quick Respawn:";
private _parts = GVAR(utilityData) apply {
    [QGVAR(quickRespawn), 0, _x] call CBA_fnc_targetEvent;
    format ["[%1: %2]", name _x, str ((_x getVariable [QEGVAR(spectator,unitData), false]) isEqualType [])]
};
private _str = _parts joinString "";
systemChat _str;

[format ["%1 Quick Respawned %2",profileName,_str],false,"Admin Menu"] call FUNC(log);
