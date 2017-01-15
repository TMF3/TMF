#include "\x\tmf\addons\spectator\script_component.hpp"
waitUntil {!dialog};
if (isNil "bis_fnc_moduleRemoteControl_unit") then {
    createDialog QGVAR(dialog);
} else {
    waitUntil {sleep 0.1;isNil "bis_fnc_moduleRemoteControl_unit"};
    waitUntil {sleep 0.1;!isNull (findDisplay 312)}; // wait until open
    (findDisplay 312) displayAddEventHandler ["Unload",{_this spawn tmf_spectator_fnc_zeusUnload;}];
};
