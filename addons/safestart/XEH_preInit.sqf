#include "script_component.hpp"

#include "initSettings.sqf"

// Handle default safestart setting
if (isServer && isTMF && !is3DEN && GVAR(enableDefaultSS) && entities QGVAR(module) isEqualTo []) then {
    if (GVAR(defaultSS) <= 0) then {
        [GVAR(defaultSS), true] call FUNC(set);
        LOG("Default safestart set to infinite");
    } else {
        private _duration = GVAR(defaultSS) + CBA_missionTime;
        [_duration, true] call FUNC(set);
        LOG_1("Default safestart set to %1",_duration);
    };
};
