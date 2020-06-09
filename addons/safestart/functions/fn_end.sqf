#include "\x\tmf\addons\safeStart\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_safestart_fnc_end

Description:
    Ends safestart

Parameters:
    _isGlobal - Whether to execute globally [Boolean, default false]

Returns:
    nil
Examples:
    (begin example)
        [true] call TMF_safestart_fnc_end
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */
params [["_isGlobal",false]];

if (_isGlobal) exitWith {[false] remoteExecCall [QFUNC(end),0,'ADDON']};

if !(isNil 'ADDON') then {
    LOG("Ending safestart");
    ADDON call CBA_fnc_deletePerFrameHandlerObject;
};

nil
