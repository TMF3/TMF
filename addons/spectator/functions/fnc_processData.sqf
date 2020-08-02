#include "\x\tmf\addons\spectator\script_component.hpp"

[] call FUNC(handleUnitList);
{
    [_x] call FUNC(updateGroupCache);
} forEach allGroups;

GVAR(vehicles) = GVAR(vehicles) select {!isNull _x};