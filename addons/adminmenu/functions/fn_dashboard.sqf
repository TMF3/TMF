#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _blu = [0, 34, 11];
private _opf = [41, 0, 0];
private _ind = [0, 5, 2];
private _civ = [0, 0, 0];

if (random 5 > 3) then {
	_blu = [floor random 20, floor random 20, floor random 20];
 	_opf = [floor random 20, floor random 20, floor random 20];
	_ind = [floor random 20, floor random 20, floor random 20];
	_civ = [floor random 20, floor random 20, floor random 20];
};

for "_i" from 0 to 2 do {
	private _vblu = _blu select _i;
	private _vopf = _opf select _i;
	private _vind = _ind select _i;
	private _vciv = _civ select _i;

	(_display displayCtrl (IDCS_TMF_ADMINMENU_DASH_STATS_BLUFOR select _i)) ctrlSetText str _vblu;
	(_display displayCtrl (IDCS_TMF_ADMINMENU_DASH_STATS_OPFOR select _i)) ctrlSetText str _vopf;
	(_display displayCtrl (IDCS_TMF_ADMINMENU_DASH_STATS_INDEP select _i)) ctrlSetText str _vind;
	(_display displayCtrl (IDCS_TMF_ADMINMENU_DASH_STATS_CIV select _i)) ctrlSetText str _vciv;

	(_display displayCtrl (IDCS_TMF_ADMINMENU_DASH_STATS_TOTAL select _i)) ctrlSetText str (_vblu + _vopf + _vind + _vciv);
};