#include "\a3\3DEN\UI\resincl.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		_display = _params select 0;

		_ctrlTitle = _display displayctrl IDC_DISPLAY3DENCOPY_TITLE;
		_ctrlEdit = _display displayctrl IDC_DISPLAY3DENCOPY_EDIT;
		_ctrlEditFake = _display displayctrl IDC_DISPLAY3DENCOPY_EDITFAKE;

		_data = uinamespace getvariable ["Display3DENCopy_data",[]];
		_dataTitle = _data param [0,"",[""]];
		_dataEdit = _data param [1,"",[""]];

		_ctrlTitle ctrlsettext _dataTitle;
		_ctrlEdit ctrlsettext _dataEdit;
		_ctrlEditFake ctrlsettext _dataEdit;

		_ctrlEditPos = ctrlposition _ctrlEdit;
		_ctrlEditPos set [3,(ctrltextheight _ctrlEditFake) max (_ctrlEditPos select 3)];
		_ctrlEdit ctrlsetposition _ctrlEditPos;
		_ctrlEdit ctrlcommit 0;
	};
};