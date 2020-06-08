#include "\x\tmf\addons\safeStart\script_component.hpp"

if (isNil 'ADDON') then [{-1}, {(ADDON getVariable ["timer", -1]) - CBA_missionTime}];
