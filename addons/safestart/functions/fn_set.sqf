#include "\x\tmf\addons\safeStart\script_component.hpp"

params [["_duration", -1],["_isGlobal",false]];

if (_isGlobal) exitWith {
    [_duration, false] remoteExecCall [QFUNC(set),0,'ADDON'];
};

if (isNil 'ADDON') then {
    ADDON = [_duration] call FUNC(init);
} else {
    ADDON setVariable ["timer", _duration];
};

LOG_1("SafeStart set to %1", _duration);
