#include "\x\tmf\addons\spectator\script_component.hpp"

if (isServer) then {
    GVAR(radioChannel) = radioChannelCreate [[0.96, 0.34, 0.13, 0.8],"Spectator Chat","[SPECTATOR] %UNIT_NAME",[]];
    publicVariable QGVAR(radioChannel);
};