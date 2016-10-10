/*
 * Name: TMF_common_fnc_mouseOverInit
 * Author: Nick
 *
 * Arguments:
 * None
 *
 * Return:
 * nil
 *
 * Description:
 * Set up the needed EH
 *
 */
#include "\x\tmf\addons\common\script_component.hpp"

private _idx = missionNamespace getVariable [QGVAR(mouseOverIdx),-1];
if !(_idx == -1) then {
	removeMissionEventHandler ["Draw3D",_idx];
};

_idx = addMissionEventHandler ["Draw3D",FUNC(mouseOver)];
GVAR(mouseOverIdx) = _idx;
GVAR(edenMouseObjects) = [];