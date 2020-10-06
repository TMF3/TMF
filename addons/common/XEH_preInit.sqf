#include "\x\tmf\addons\common\script_component.hpp"

#include "XEH_PREP.sqf"
#include "initSettings.sqf"

if is3DEN call {
    call FUNC(edenInit);
};

isTMF = ((getMissionConfigValue ["tmf_version",[0,0,0]] select 0) > 0);

// Rig up server event handler for variable sync requests.
if (isServer) then {
    [QGVAR(requestServerSync), {
        // Delay a frame.
        [{
            params ["_clientOwnerId"];
            [QGVAR(serverVariableSyncResponse), [], _clientOwnerId] call CBA_fnc_ownerEvent;
        }, _this] call CBA_fnc_execNextFrame;
    }] call CBA_fnc_addEventHandler;
};
