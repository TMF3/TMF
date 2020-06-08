#include "\x\tmf\addons\safeStart\script_component.hpp"

params [["_duration", -1]];

if (_duration > 0) then {
    ADD(_duration,CBA_missionTime);
};

if (isNil 'ADDON') then {
    ADDON = [_duration] call FUNC(init);
} else {
    ADDON setVariable ["timer", _duration];
};

ADDON
