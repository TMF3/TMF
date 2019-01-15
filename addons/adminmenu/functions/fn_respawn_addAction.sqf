#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _ctrlSpectatorListBox = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_SPECTATORLIST);

private _selection = _ctrlSpectatorListBox lbText (lbCurSel _ctrlSpectatorListBox);
private _obj = objNull;
{
    private _name = _x getVariable ["tmf_spectator_name",name _x];
    if (_selection == _name) exitWith {
        _obj = _x;
    };
} forEach GVAR(spectatorList);

if (!(isNull _obj)) then {
    private _role = lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_RESP_ROLECOMBO); // Role
    private _rank = GVAR(respawn_rank); // Rank
    
    GVAR(selectedRespawnGroup) pushBack [_rank,_obj,_role];
};

[_display] call FUNC(respawn_refreshSpectatorList);
[_display] call FUNC(respawn_refreshGroupBox);
