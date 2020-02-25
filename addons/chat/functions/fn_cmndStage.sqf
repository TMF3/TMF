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

openMap true;
forceMap true;

systemChat "TMF: Select position to stage group to";

GVAR(stageMapClickHandler) = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];

    if !([_pos, side player] call FUNC(isInAdversarialSafeArea)) exitWith {
        systemChat "TMF Error: Marked position is in a defender controlled area. Select another position";
    };
    private _vehicles = (units group player) apply {vehicle _x};
    UNIQUE(ARR);

    {
        _x setPos _pos
    } forEach _vehicles;
    {
        (FORMAT_1("TMF: %1 teleported group to staging area", name player)) remoteExecCall ["systemChat", _x];
    } forEach (units group player) - [player];

    systemChat "TMF: Teleported group to staging area";

    forceMap false;
    openMap false;

    removeMissionEventHandler ["MapSingleClick", GVAR(stageMapClickHandler)];
}];
