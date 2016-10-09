#include "\x\tmf\addons\spectator\script_component.hpp"
#include "\x\tmf\addons\spectator\functions\defines.hpp"


if (!isNil "ace_common_fnc_addCanInteractWithCondition") then {
	[QGVAR(spectatingCondition), {isNull (findDisplay IDC_SPECTATOR_TMF_SPECTATOR_DIALOG)}] call ace_common_fnc_addCanInteractWithCondition;
};

if (isServer) then {
    GVAR(radioChannel) = radioChannelCreate [[0.96, 0.34, 0.13, 0.8],"Spectator Chat","[SPECTATOR] %UNIT_NAME",[]];
    publicVariable QGVAR(radioChannel);
};
