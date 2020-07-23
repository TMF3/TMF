#include "\x\tmf\addons\spectator\script_component.hpp"
#include "\x\tmf\addons\spectator\functions\defines.hpp"


if (!isNil "ace_common_fnc_addCanInteractWithCondition") then {
    [QGVAR(spectatingCondition), {isNull (findDisplay IDC_SPECTATOR_TMF_SPECTATOR_DIALOG)}] call ace_common_fnc_addCanInteractWithCondition;
};

if (isServer) then {
    GVAR(radioChannel) = radioChannelCreate [[0.96, 0.34, 0.13, 0.8],"Spectator Chat","[SPECTATOR] %UNIT_NAME",[]];
    publicVariable QGVAR(radioChannel);

    createCenter sideLogic;
    GVAR(group) = createGroup sideLogic;

    if (isNull GVAR(group)) then {
        createCenter civilian;
        GVAR(group) = createGroup civilian;
    };

    publicVariable QGVAR(group);

    // Clean up disconnected spectator units.
    private _spectator_disconnect_eh = addMissionEventHandler ["HandleDisconnect",{
        params ["_unit"];
        if (_unit isKindOf QGVAR(unit)) then { deleteVehicle _unit; };
        false;
    }];

    [{
        {
            // Mark player as JIPable on mission start
            // This is kept if the player is DC'd and controlled by AI
            _x setVariable [QGVAR(isJIPable),true,true];
        } forEach playableUnits;
    },[],0.01] call CBA_fnc_waitAndExecute;

};
