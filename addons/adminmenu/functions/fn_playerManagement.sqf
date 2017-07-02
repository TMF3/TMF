#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _ctrlUpdateFlash = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_UPDATEFLASH;
_ctrlUpdateFlash ctrlSetFade 1;
_ctrlUpdateFlash ctrlCommit 0;


_display call FUNC(playerManagementUpdateList);

private _pfhUpdate = [{
	(param [1]) call FUNC(playerManagementUpdateList);
}, 3, _display] call CBA_fnc_addPerFrameHandler;
GVAR(tabPFHHandles) pushBack _pfhUpdate;