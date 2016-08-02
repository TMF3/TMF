/*
 * Name: TMF_common_fnc_handleLocalJIP
 * Author: Snippers
 *
 * Arguments:
 * 0: OBJECT: Unit to check for JIP.
 *
 * Return:
 * none
 *
 * Description:
 * This function is used as part of ensuring JIP players are killed. This function shouldn't be used outside of JIP code.
 */

// Check if this unit was respawned.
if (_this getVariable ['tmf_isRespawnUnit',false]) exitWith {};

_this spawn {
    waitUntil {!([] call BIS_fnc_isLoading)};
    sleep 2;
    if (_this isEqualTo player) then {
        [_this, objNull, true] call tmf_spectator_fnc_init;
        systemChat "You joined the mission in progress. Entering spectator.";
        deleteVehicle _this;
    } else {
        if (!local _this) then {
            [_this, "tmf_common_fnc_handleLocalJip", _this] call BIS_fnc_MP;
        };
    };
};