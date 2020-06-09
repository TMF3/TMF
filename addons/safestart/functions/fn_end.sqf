#include "\x\tmf\addons\safeStart\script_component.hpp"

params [["_isGlobal",false]];

if (_isGlobal) exitWith {[false] remoteExecCall [QFUNC(end),0,'ADDON']};

if !(isNil 'ADDON') then {
    LOG("Ending safestart");
    ADDON call CBA_fnc_deletePerFrameHandlerObject;
};
