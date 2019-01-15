#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];
uiNamespace setVariable [QGVAR(modalDisplay), _display];

GVAR(modalDetails) params ["_utilityFunction", "_utilityName"];
(_display displayCtrl IDC_TMF_ADMINMENU_MODAL_TITLE) ctrlSetText _utilityName;
(_display displayCtrl IDC_TMF_ADMINMENU_G_MODAL) call (missionNamespace getVariable _utilityFunction);
