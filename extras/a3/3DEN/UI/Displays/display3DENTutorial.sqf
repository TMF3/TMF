#include "\a3\3DEN\UI\resincl.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		_fnc_treeselchanged = {
			private ["_classCategory","_classSection"];
			_ctrlTree = _this select 0;
			_path = _this select 1;
			_cfg = if (count _path > 1) then {
				_classCategory = _ctrlTree tvdata [_path select 0];
				_classSection = _ctrlTree tvdata _path;
				configfile >> "Cfg3DEN" >> "Tutorials" >> _classCategory >> "Sections" >> _classSection;
			} else {
				_classCategory = _ctrlTree tvdata _path;
				configfile >> "Cfg3DEN" >> "Tutorials" >> _classCategory;
			};
			_display = ctrlparent _ctrlTree;
			_ctrlButtonOK = _display displayctrl IDC_OK;
			_ctrlButtonOK ctrlshow (isclass (_cfg >> "Steps"));

			//--- Mark as completed after clicking
			if (count _path == 2) then {
				_pathData = [_classCategory,_classSection];
				_completed = profilenamespace getvariable ["display3DENTutorial_completed",[]];
				if !(_pathData in _completed) then {
					_completed pushback _pathData;
					profilenamespace setvariable ["display3DENTutorial_completed",_completed];
					saveprofilenamespace;
				};
				_ctrlTree = _display displayctrl IDC_DISPLAY3DENTUTORIAL_LIST;
				_ctrlTree tvsetpicture [_path,gettext (configfile >> "display3DENTutorial" >> "pictureCompleted")];

				//--- Reset notification icon
				_count = 0;
				{
					_count = _count + count configproperties [_x >> "Sections","isclass _x"];
				} foreach configproperties [configfile >> "Cfg3DEN" >> "Tutorials","isclass _x"];
				if (count _completed >= _count) then {
					_display3DEN = finddisplay IDD_DISPLAY3DEN;
					_ctrlTutorials = _display3DEN displayctrl IDC_DISPLAY3DEN_TOOLBAR_HELP_TUTORIAL;
					_ctrlTutorials ctrlsettext "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\help_tutorial_ca.paa";
					setstatvalue ["3DENModelStudent",1];
				};
			};
		};
		_fnc_buttonclick = {
			_display = ctrlparent (_this select 0);
			_ctrlTree = _display displayctrl IDC_DISPLAY3DENTUTORIAL_LIST;
			_path = tvcursel _ctrlTree;
			if (count _path > 1) then {
				_classCategory = _ctrlTree tvdata [_path select 0];
				_classSection = _ctrlTree tvdata _path;
				_display closedisplay IDC_OK;
				[[_classCategory,_classSection]] call bis_fnc_3dentutorial;
			};
		};

		_display = _params select 0;
		_ctrlTree = _display displayctrl IDC_DISPLAY3DENTUTORIAL_LIST;
		_ctrlTree ctrladdeventhandler ["treeselchanged",_fnc_treeselchanged];
		_ctrlTree ctrladdeventhandler ["treedblclick",_fnc_buttonclick];
		_select = uinamespace getvariable ["display3DENTutorial_select",["",""]];
		_selectCategory = _select param [0,"",[""]];
		_selectClass = _select param [1,"",[""]];
		_selectPath = [0];
		_picture = gettext (configfile >> "display3DENTutorial" >> "picture");
		_pictureCompleted = gettext (configfile >> "display3DENTutorial" >> "pictureCompleted");
		_completed = profilenamespace getvariable ["display3DENTutorial_completed",[]];
		_count = 0;
		{
			_category = configname _x;
			_indexCategory = _ctrlTree tvadd [[],toupper gettext (_x >> "displayName")];
			_ctrlTree tvsetpicture [[_indexCategory],gettext (_x >> "icon")];
			_ctrlTree tvsetdata [[_indexCategory],_category];
			_isSelected = _category == _selectCategory;
			if (_isSelected) then {_selectPath set [0,_indexCategory];};
			{
				_section = configname _x;
				_indexSection = _ctrlTree tvadd [[_indexCategory],gettext (_x >> "displayName")];
				_ctrlTree tvsetpicture [[_indexCategory,_indexSection],if ([_category,_section] in _completed) then {_pictureCompleted} else {_picture}];
				_ctrlTree tvsetdata [[_indexCategory,_indexSection],_section];
				if (_isSelected && {_section == _selectClass}) then {_selectPath set [1,_indexSection];};
				_count = _count + 1;
			} foreach configproperties [_x >> "Sections","isclass _x"];
			_ctrlTree tvexpand [_indexCategory];
		} foreach configproperties [configfile >> "Cfg3DEN" >> "Tutorials","isclass _x"];
		//_ctrlTree tvexpand [_selectPath select 0];
		_ctrlTree tvsetcursel _selectPath;
		[_ctrlTree,_selectPath] call _fnc_treeselchanged;

		_ctrlButtonOK = _display displayctrl IDC_OK;
		_ctrlButtonOK ctrladdeventhandler ["buttonclick",_fnc_buttonclick];

		//--- Reset notification icon
		if (count _completed >= _count) then {
			_display3DEN = finddisplay IDD_DISPLAY3DEN;
			_ctrlTutorials = _display3DEN displayctrl IDC_DISPLAY3DEN_TOOLBAR_HELP_TUTORIAL;
			_ctrlTutorials ctrlsettext "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\help_tutorial_ca.paa";
			setstatvalue ["3DENModelStudent",1];
		};

		//--- Terminate existing tutorial
		[] spawn bis_fnc_3dentutorial;
	};
	case "onUnload": {
		_display = _params select 0;
		_ctrlTree = _display displayctrl IDC_DISPLAY3DENTUTORIAL_LIST;
		_path = tvcursel _ctrlTree;
		_pathClass = if (count _path > 1) then {
			[_ctrlTree tvdata [_path select 0],_ctrlTree tvdata _path]
		} else {
			[_ctrlTree tvdata _path]
		};
		uinamespace setvariable ["display3DENTutorial_select",_pathClass];
	};
};