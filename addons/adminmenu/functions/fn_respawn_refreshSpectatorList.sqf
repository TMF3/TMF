#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _ctrlSpectatorListBox = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_SPECTATORLIST);



lbClear _ctrlSpectatorListBox;
{
	private _found = false;
	private _deadPlayer = _x;


	//Check if already selected and thus in the selected respawn listBox.
	{
		if (_deadPlayer == (_x select 1)) exitWith {
			_found = true;  
		};
	} forEach GVAR(selectedRespawnGroup);
	
	if (!_found) then {
		private _name = _deadPlayer getVariable ["tmf_spectator_name",name _deadPlayer];
		private _idx = _ctrlSpectatorListBox lbAdd _name;
		_ctrlSpectatorListBox lbSetData[_idx,_name];
	};

} forEach GVAR(spectatorList);
