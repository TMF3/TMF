 #include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

 
 if (count GVAR(selectedRespawnGroup) < 1) exitWith { hint "No players selected"; };
   
private _groupName = ctrlText (_display displayCtrl IDC_TMF_ADMINMENU_RESP_GROUPNAME);

// respawnMenuFactions control.
private _control = (_display displayCtrl 26928);
private _faction = _control lbData (lbCurSel _control);

private _markerName = ctrlText (_display displayCtrl IDC_TMF_ADMINMENU_RESP_GROUPMARKERNAME);
private _markerType = lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_RESP_MARKERTYPE); // type == -1 if no spawn marker
private _markerColor =lbCurSel (_display displayCtrl IDC_TMF_ADMINMENU_RESP_MARKERCOLOUR);

private _useMarker = cbChecked (_display displayCtrl IDC_TMF_ADMINMENU_RESP_GROUPMARKERCHECKBOX);
if (!_useMarker) then { //GVAR(respawnGroupMarkerCheckBoxVal)
	_markerType = -1;  
}; 
		
// Hand over control to the map dialog.
closeDialog IDD_TMF_ADMINMENU;
createDialog QGVAR(respawnMapDialog);

GVAR(respawnGuiParameters) = [_faction, _groupName, _markerType, _markerColor, _markerName];
