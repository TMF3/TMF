#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _blu = [0, 34, 11];
private _opf = [41, 0, 0];
private _ind = [0, 5, 2];
private _civ = [0, 0, 0];

if (random 5 > 3) then {
	_blu = [floor random 10, floor random 10, floor random 10];
 	_opf = [floor random 10, floor random 10, floor random 10];
	_ind = [floor random 10, floor random 10, floor random 10];
	_civ = [floor random 10, floor random 10, floor random 10];
};

_blu pushBack ((_blu select 0) + (_blu select 1) + (_blu select 2));
_opf pushBack ((_opf select 0) + (_opf select 1) + (_opf select 2));
_ind pushBack ((_ind select 0) + (_ind select 1) + (_ind select 2));
_civ pushBack ((_civ select 0) + (_civ select 1) + (_civ select 2));

for "_i" from 0 to 3 do {
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