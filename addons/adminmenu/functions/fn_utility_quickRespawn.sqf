#include "\x\tmf\addons\adminmenu\script_component.hpp"

systemChat "[TMF Admin Menu] Quick Respawn:";
private _str = "";
{
    _str = _str + format ["[%1: ]", name _x, str ((_x getVariable [QEGVAR(spectator,unitData), false]) isEqualType [])];
} forEach GVAR(utilityData);
