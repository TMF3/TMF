#include "\a3\3DEN\UI\resincl.inc"
#include "\a3\3DEN\UI\dikCodes.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		["placemode"] spawn bis_fnc_3DENInterface;
		["placesubmode"] spawn bis_fnc_3DENInterface;
		["placeempty"] spawn bis_fnc_3DENInterface;

		_display = _params select 0;
		_display displayaddeventhandler ["keydown",{with uinamespace do {["keyDown",_this,""] call display3DENPlace_script;};}];
	};
	case "keyDown":
	{
		_display = _params select 0;
		_key = _params select 1;
		_ctrlModes = _display displayctrl IDC_DISPLAY3DEN_MODES;
		_ctrlModeLabels = _display displayctrl IDC_DISPLAY3DEN_MODELABELS;
		_cursel = switch _key do {
			case DIK_F1: {0};
			case DIK_F2: {1};
			case DIK_F3: {2};
			//case DIK_F4: {};
			case DIK_F5: {3};
			case DIK_F6: {4};
			default {-1};
		};
		if (_cursel >= 0) then {
			_ctrlModes lbsetcursel _cursel;
			_ctrlModeLabels lbsetcursel _cursel;
		};
		
	};
};