#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_list"];

GVAR(playerManagement_selected) =  (lbSelected _list) apply {_list lbData _x};

systemChat format ["%1 %2", QFUNC(playerManagementListSelChange), time];