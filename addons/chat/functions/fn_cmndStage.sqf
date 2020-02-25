/*
 * Name = TMF_chat_fnc_cmndStage
 * Author = Freddo
 *
 * Syntaxes:
 * #stage - Stages a group to a position.
 *
 * Return Value:
 * Void
 *
 * Description:
 * See Syntaxes
 */

#include "\x\tmf\addons\chat\script_component.hpp"

IS_CMND_AVAILABLE(GVAR(stageUsage),"#stage");

if !(leader player isEqualTo player) exitWith {
    systemChat "TMF Error: You need to be the group leader to stage";
};

/*GVAR(safeZoneMarkers) = [];

{
    _x params ["_logic", "_width", "_height"];

    private _marker = createMarkerLocal [format ["%1_%2", QGVAR(safeZone), (_logic call BIS_fnc_netId)], _logic];
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerBrushLocal "Border";
    _marker setMarkerColorLocal "ColorBlue";
    _marker setMarkerSizeLocal [_width, _height];

    GVAR(safeZoneMarkers) pushBack _marker;
} forEach GVAR(adversarialSafeZones);*/

openMap true;
forceMap true;

GVAR(stageMapClickHandler) = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];

    private _outside = true;

    /*{
        if (_pos inArea _x) then {
            _outside = false;
        };
    } forEach GVAR(adversarialSafeZones);

    if (!_outside) exitWith {
        systemChat "You cannot stage inside the safe zone";
    };*/

    {
        vehicle _x setPos _pos;
    } forEach units group ace_player;

    /*{
        deleteMarker _x;
    } forEach GVAR(safeZoneMarkers);*/

    forceMap false;
    openMap false;

    removeMissionEventHandler ["MapSingleClick", GVAR(stageMapClickHandler)];
}];
