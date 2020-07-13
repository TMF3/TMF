#include "script_component.hpp"

LOG("Preinit");

#include "XEH_PREP.sqf"

if (is3DEN) then {
    [] call FUNC(onEdenMissionChange);
    {
        (_x get3DENAttribute QGVAR(full)) params ["_value"];
        [_x,_value] call FUNC(helper);
    } forEach (allUnits);
};
