#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlLabelRadios = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelRadios;
_ctrlLabelRadios ctrlSetPosition [0, 0, (0.25 * _ctrlGrpWidth), TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelRadios ctrlCommit 0;
_ctrlLabelRadios ctrlSetText "Give players ACRE2 radios";