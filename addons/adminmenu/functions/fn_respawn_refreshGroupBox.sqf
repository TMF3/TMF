#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _ctrlGroupListBox = (_display displayCtrl IDC_TMF_ADMINMENU_RESP_GROUPLIST);
lbClear _ctrlGroupListBox;

{
	_x params ["_rankIdx","_obj", "_roleIdx"];
	private _name = _obj getVariable ["tmf_spectator_name",name _obj];
	private _idx = _ctrlGroupListBox lbAdd format["%1 - %2", _name, (respawnMenuRoles select _roleIdx) select 1];
	//Set image based on rank
	switch (_rankIdx) do {
		case 0 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa"]; };
		case 1 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa"];};
		case 2 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa"];};
		case 3 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa"];};
		case 4 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa"];};
		case 5 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa"];};
		case 6 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"];};
		default { };
	};
	_ctrlGroupListBox lbSetColor [_idx, [1, 1, 1, 1]];
	_ctrlGroupListBox lbSetPictureColor [_idx, [1,1,1,0.7]];
	_ctrlGroupListBox lbSetPictureColorSelected [_idx,[1,1,1,1]];
} forEach GVAR(selectedRespawnGroup);
