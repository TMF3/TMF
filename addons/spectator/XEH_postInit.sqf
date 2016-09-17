#include "\x\tmf\addons\spectator\script_component.hpp"

if (!isNil "ace_common_fnc_addCanInteractWithCondition") then {
	[QGVAR(spectatingCondition), {!([] call FUNC(isOpen))}] call ace_common_fnc_addCanInteractWithCondition;
};

if (isServer) then {
    GVAR(radioChannel) = radioChannelCreate [[0.96, 0.34, 0.13, 0.8],"Spectator Chat","[SPECTATOR] %UNIT_NAME",[],false];
    publicVariable QGVAR(radioChannel);
};