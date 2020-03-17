#include "\a3\3DEN\UI\resincl.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		_display = _params select 0;

		_lBSelChanged = {
			_display = ctrlparent (_this select 0);
			_data = (_this select 0) lbdata (_this select 1);
			_cfg = configfile >> 'Cfg3DEN' >> 'Updates' >> _data;
			_path = gettext (configfile >> 'Cfg3DEN' >> 'Updates' >> "path");
			_text = loadfile (_path + _data + ".hpp");

			//--- Parse text
			_textParsed = [];
			_textFT = [];
			_symbolAsterisk = toarray "*" select 0;
			_symbolTilde = toarray "~" select 0;
			_symbolCircumflex = toarray "^" select 0;
			_symbolLine = toarray "|" select 0;
			_arrayBR = toarray "<br />";
			_arrayBullet = toarray "<img image='\a3\3DEN\Data\Controls\ctrlMenu\arrow_ca.paa' />";
			_arrayBoldOpen = toarray "<t font='RobotoCondensed'>";
			_arrayBoldClose = toarray "</t>";
			_arrayThinOpen = toarray "<t font='EtelkaMonospacePro' size='0.86'>";
			_arrayThinClose = toarray "</t>";
			_arrayTitleOpen = toarray "<t size='1.4' color='#aa000000' font='PuristaMedium'>";
			_arrayTitleClose = toarray "</t>";

			_isLineBreak = false;
			_isBold = false;
			_isThin = false;
			_isTitle = false;
			_isFT = false;
			{
				_symbol = switch _x do {
					case 13: {_textParsed = _textParsed + _arrayBR;};
					case 10: {_isLineBreak = true;};
					case _symbolAsterisk: {
						if (_isLineBreak) then {
							_textParsed = _textParsed + _arrayBullet;
						} else {
							_tag = if !(_isBold) then {_arrayBoldOpen} else {_arrayBoldClose};
							_textParsed = _textParsed + _tag;
							_isBold = !_isBold;
						};
					};
					case _symbolCircumflex: {
						_tag = if !(_isTitle) then {_arrayTitleOpen} else {_arrayTitleClose};
						_textParsed = _textParsed + _tag;
						_isTitle = !_isTitle;
					};
					case _symbolTilde: {
						_tag = if !(_isThin) then {_arrayThinOpen} else {_arrayThinClose};
						_textParsed = _textParsed + _tag;
						_isThin = !_isThin;
					};
					case _symbolLine: {
						_tag = if (_isFT) then {toarray format ["(<a href=""https://feedback.arma3.com/view.php?id=%1"">#%1</a>)",tostring _textFT];} else {[]};
						_textParsed = _textParsed + _tag;
						_textFT = [];
						_isFT = !_isFT;
					};
					default {
						_isLineBreak = false;
						if (_isFT) then {_textFT pushback _x;} else {_textParsed pushback _x;};
					};
				};
			} foreach toarray _text;

			_ctrlGroup = _display displayctrl IDC_DISPLAY3DENUPDATES_GROUP;

			_ctrlContent = _display displayctrl IDC_DISPLAY3DENUPDATES_CONTENT;
			_ctrlContent ctrlsetstructuredtext parsetext tostring _textParsed;
			_ctrlContentPos = ctrlposition _ctrlContent;
			_ctrlContentPos set [3,(ctrltextheight _ctrlContent) max (ctrlposition _ctrlGroup select 3)];
			_ctrlContent ctrlsetposition _ctrlContentPos;
			_ctrlContent ctrlcommit 0;
		};

		//--- Fill the list
		_ctrlList = _display displayctrl IDC_DISPLAY3DENUPDATES_LIST;
		_cfgUpdates = configproperties [configfile >> "Cfg3DEN" >> "Updates","isclass _x"];
		_months = ["str_january","str_february","str_march","str_april","str_may","str_june","str_july","str_august","str_september","str_october","str_november","str_december"];
		{
			_date = getarray (_x >> 'date');
			_year = _date select 0;
			_month = _date select 1;
			_day = _date select 2;
			_index = _ctrlList lbadd format [
				"UPDATE" + " #%4 - %2 %3, %1",
				_year,
				localize (_months select (_month - 1)),//if (_month < 10) then {"0" + str _month} else {_month},
				_day,//if (_day < 10) then {"0" + str _day} else {_day},
				if (_foreachindex < 10) then {"0" + str (_foreachindex + 1)} else {_foreachindex + 1}
			];
			_ctrlList lbsetdata [_index,configname _x];
		} foreach _cfgUpdates;
		lbsort [_ctrlList,"ASC"];
		_index = lbsize _ctrlList - 1;
		_ctrlList lbsetcursel _index;
		[_ctrlList,_index] call _lBSelChanged;

		//--- Change the content based on selected item
		_ctrlList ctrladdeventhandler ["LBSelChanged",_lBSelChanged];

		//--- Reset notifictaion icon
		_display3DEN = finddisplay IDD_DISPLAY3DEN;
		_ctrlUpdates = _display3DEN displayctrl IDC_DISPLAY3DEN_TOOLBAR_HELP_UPDATES;
		_ctrlUpdates ctrlsettext "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\help_updates_ca.paa";
		profilenamespace setvariable ['3DEN_Updates',count _cfgUpdates];
		saveprofilenamespace;
	};
};