#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrl"];

private _display = ctrlParent _ctrl;
private _ctrlIDC = ctrlIDC _ctrl;
private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;

if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_REFRESH) exitWith {
    _display call FUNC(playerManagement_updateList);
};
if (_ctrlIDC isEqualTo IDC_TMF_ADMINMENU_PMAN_SEL_ALL) exitWith {
    GVAR(playerManagement_selected) = GVAR(playerManagement_players);

    for "_i" from 0 to ((lbSize _list) - 1) do {
        _list lbSetSelected [_i, true];
    };
};

systemChat format ["[TMF Admin Menu] Player Management button code '%1' not recognized", _ctrlIDC];
