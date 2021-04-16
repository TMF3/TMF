#include "\a3\3DEN\UI\resincl.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {

		_display = _params select 0;
		_ctrlFilter = _display displayctrl IDC_DISPLAY3DENREQUIREDADDONS_FILTER;
		_ctrlList = _display displayctrl IDC_DISPLAY3DENREQUIREDADDONS_LIST;

		[_ctrlFilter,_ctrlList,[0,0,1]] spawn bis_fnc_initListNBoxSorting;
		ctrlsetfocus _ctrlList;
	};
};