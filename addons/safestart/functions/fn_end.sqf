#include "\x\tmf\addons\safeStart\script_component.hpp"

if !(isNil 'ADDON') then {
    ADDON call CBA_fnc_deletePerFrameHandlerObject;
};
