#include "script_component.hpp"

LOG("Client PostInit started");

if (CBA_missionTime < 5 || ([] call EFUNC(safestart,isActive))) then {
    // Mark player as JIPable on mission start
    // This is kept if the player is DC'd and controlled by AI
    player setVariable [QGVAR(isJIPable),true,true];
};

[{
    // Check if JIP is allowed, if not then kill the JIP player.
    private _isAIunit = player getVariable [QGVAR(isJIPable),false];
    private _isJIPAllowed = switch (GVAR(isJIPAllowed)) do {
        case 0: {false};
        case 1: {true};
        case 2: {[] call EFUNC(safestart,isActive)};
    };
    private _templateActive = "TMF_Spectator" in getMissionConfigValue ["respawnTemplates",[]];

    TRACE_4("Check JIP conditions",_templateActive, _isJIPAllowed, CBA_missionTime, didJIP);
    TRACE_1("Check JIP conditions 2",(_templateActive && !_isJIPAllowed && CBA_missionTime > 5 && didJIP));

    if (_templateActive && !(_isJIPAllowed || _isAIunit) && CBA_missionTime > 5 && didJIP) then {
        LOG("JIP: True");

        [{!isNull player && {!([] call BIS_fnc_isLoading)}},{
            LOG_1("JIP: killing %1", player);
            [player, objNull, true] spawn {
                private _oldObject = _this # 0;
                _this call FUNC(init);
                systemChat "You joined the mission in progress. Entering spectator.";
                [format ["Player JIP to spectator: %1", profileName],true,"Spectator"] call EFUNC(adminmenu,log);
                deleteVehicle _oldObject;
            };
        }] call CBA_fnc_waitUntilAndExecute;

    };

// Add a small delay for things to synchronize
},[], 0.1] call CBA_fnc_waitAndExecute;
