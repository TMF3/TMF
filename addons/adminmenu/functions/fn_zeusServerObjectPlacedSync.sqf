#include "\x\tmf\addons\adminmenu\script_component.hpp"

params["_curator", "_placed"];

{   
    if (_x getVariable [QGVAR(zeus), false]) then {
        _x addCuratorEditableObjects [[_placed], true];
    };
} forEach (allCurators);

nil