#include "\a3\3DEN\UI\resincl.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		//--- Restore the last sort order
		_display = _params select 0;
		uinamespace setvariable ["display3DENSave_display",_display];
		_selected = uinamespace getvariable ["display3DENSave_selected",[0,0]];
		_ctrlFilter = _display displayctrl IDC_DISPLAY3DENSAVE_FILTER;
		_ctrlFilter lnbsetvalue [[0,_selected select 0],_selected select 1];

		if (ctrltext (_display displayctrl 1) != localize "STR_3den_display3den_menubar_missionsave_text") then { // ToDo: Better Save variant detection, split into separate display perhaps?
			{
				(_display displayctrl _x) ctrlshow false;
			} foreach [IDC_DISPLAY3DENSAVE_BINARIZETEXT,IDC_DISPLAY3DENSAVE_BINARIZE];
		};
	};
	case "onUnload": {
		_display = _params select 0;

		// Save value of 'Binarize' attribute
		if ((_params select 1) == IDC_OK) then {
			"Scenario" set3DENMissionAttribute ["SaveBinarized",cbChecked (_display displayctrl IDC_DISPLAY3DENSAVE_BINARIZE)];
		};

		//--- Save mission list sorting
		_ctrlFilter = _display displayctrl IDC_DISPLAY3DENSAVE_FILTER;
		_selected = [0,0];
		for '_i' from 0 to (lnbsize _ctrlFilter select 1) - 1 do {
			_value = _ctrlFilter lnbvalue [0,_i];
			if (_value > -1) exitwith {_selected = [_i,_value];};
		};
		uinamespace setvariable ["display3DENSave_selected",_selected];
		uinamespace setvariable ["display3DENSave_display",nil];
	};
};