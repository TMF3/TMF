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
        params ["unit"];
        if (_unit isKindOf QGVAR(unit)) then { deleteVehicle _unit; };
        false;
    }];
};

if (hasInterface) then {
    // Hide ST HUD if spectator is OPEN
    if (isClass (configfile >> "CfgPatches" >> "STUI_GroupHUD")) then {
        [{!isNil "STUI_Canvas_ShownHUD"}, {
            STUI_Canvas_ShownHUD_old = STUI_Canvas_ShownHUD;
            STUI_Canvas_ShownHUD = {
                if !(call STUI_Canvas_ShownHUD_old) exitWith {false};
                !(call FUNC(isOpen));
            };
        }, []] call CBA_fnc_waitUntilAndExecute;
    };
};
