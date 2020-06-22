#include "script_component.hpp"

LOG("Client PostInit started");

[{
    // Check if JIP is allowed, if not then kill the JIP player.
    private _isJIPAllowed = switch (GVAR(isJIPAllowed)) do {
        case 0: {false};
        case 1: {true};
        case 2: {[] call EFUNC(safestart,isActive)};
    };
    private _templateActive = "TMF_Spectator" in getMissionConfigValue ["respawnTemplates",[]];

    TRACE_4("Check JIP conditions",_templateActive, _isJIPAllowed, CBA_missionTime, didJIP);
    TRACE_1("Check JIP conditions 2",(_templateActive && !_isJIPAllowed && CBA_missionTime > 1 && didJIP));

    if (_templateActive && !_isJIPAllowed && CBA_missionTime > 1 && didJIP) then {
        LOG("JIP: True");

        [{!isNull player && {!([] call BIS_fnc_isLoading)}},{
            LOG_1("JIP: killing unit.", player);
            [player, objNull, true] spawn {
                private _oldObject = _this # 0;
                _this call FUNC(init);
                systemChat "You joined the mission in progress. Entering spectator.";
                [["Player JIP to spectator: %1", profileName],true,"[TMF Spectator] "] call EFUNC(adminmenu,log);
                deleteVehicle _oldObject;
            };
        }] call CBA_fnc_waitUntilAndExecute;

    };

// Add a small delay for things to synchronize
},[], 0.1] call CBA_fnc_waitAndExecute;
