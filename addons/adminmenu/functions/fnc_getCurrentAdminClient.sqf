#include "\x\tmf\addons\adminmenu\script_component.hpp"

//if (!isRemoteExecuted && isMultiplayer) exitWith {}; // ??

params ["_origin", "_adminLevel"];

GVAR(currentAdmin) = profileName;
if (_adminLevel isEqualTo 1) then {
    GVAR(currentAdmin) = GVAR(currentAdmin) + " (voted)";
};

_origin publicVariableClient QGVAR(currentAdmin);
