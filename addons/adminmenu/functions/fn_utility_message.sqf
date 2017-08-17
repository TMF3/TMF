#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGroup", "_data"];

/* private _ctrlMap = _display ctrlCreate ["RscMapControl", -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlMap];
private _ctrlGrpHeight = (ctrlPosition _ctrlGroup) select 3;
_ctrlMap ctrlSetPosition [0, 0, _ctrlGrpHeight * (4/3), _ctrlGrpHeight];
_ctrlMap ctrlCommit 0; */