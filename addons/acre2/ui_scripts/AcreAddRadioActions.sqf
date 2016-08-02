params ["_mode",["_params",[]]];

// with uiNameSpace do { RadioChannels_script = compile preprocessFileLineNumbers "RadioChannels.sqf"; };  with uiNameSpace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };  with uiNameSpace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; };

//with uiNameSpace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };  with uiNameSpace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; };
// with uiNameSpace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; };

#define ACRE_RADIO_CLASSNAME_ARRAY ["ACRE_PRC343","ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F","ACRE_PRC77"]

switch _mode do {
	case "onLoad": {
		//Add EH On touch
		
		_ctrlGroup = _params select 0;
		AcreAddRadioActions_ctrlGroup = _ctrlGroup;

		_ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {AcreAddRadioActions_ctrlGroup = _this select 0;};}];
		_ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {AcreAddRadioActions_ctrlGroup = nil;};}];
		
		_ctrlList = _ctrlGroup controlsGroupCtrl 101;
		_ctrlList ctrladdeventhandler ["lbdblclick",{with uinamespace do {["listModify",[ctrlparentcontrolsgroup (_this select 0),+1],objnull] call AcreAddRadioActions_script;};}];
		
		TMF_AcreAddRadioActions_Array = ("TMF_MissionAcre2Attributes" get3DENMissionAttribute "TMF_AcreAddRadioActions");
		if (TMF_AcreAddRadioActions_Array isEqualType "") then {
			TMF_AcreAddRadioActions_Array = call compile TMF_AcreAddRadioActions_Array;
		};
		
		lnbclear _ctrlList;
		_ctrlList lnbSetColumnsPos [0.1,0.2];
		{
			_weaponCfg = configfile >> "cfgWeapons" >> _x;
			_displayName = gettext (_weaponCfg >> "displayName");
			_picture = gettext (_weaponCfg >> "picture");
			_description = getText (_weaponCfg >> "descriptionShort");
			_lnbAdd = _ctrlList lnbaddrow ["",_displayName];
			_ctrlList lnbsetdata [[_lnbAdd,0],_x];
			_ctrlList lnbsetpicture [[_lnbAdd,0],_picture];
			_alpha = if (_x in TMF_AcreAddRadioActions_Array) then {1} else {0.5};
			_ctrlList lnbsetcolor [[_lnbAdd,1],[1,1,1,_alpha]];
		} forEach ACRE_RADIO_CLASSNAME_ARRAY;
	};
	case "attributeSave": {
		str (uiNamespace getVariable "TMF_AcreAddRadioActions_Array")
	};
	case "listModify": {
		private _ctrlList = AcreAddRadioActions_ctrlGroup controlsGroupCtrl 101;
		private _curSel = lnbCurSelRow _ctrlList;
		private _radio = (_ctrlList lnbData [_curSel,0]);
		
		if (_radio in TMF_AcreAddRadioActions_Array) then {
			TMF_AcreAddRadioActions_Array = TMF_AcreAddRadioActions_Array - [_radio];
		} else {
			TMF_AcreAddRadioActions_Array pushBackUnique _radio;
		};
		lnbclear _ctrlList;
		_ctrlList lnbSetColumnsPos [0.1,0.2];
		{
			_weaponCfg = configfile >> "cfgWeapons" >> _x;
			_displayName = gettext (_weaponCfg >> "displayName");
			_picture = gettext (_weaponCfg >> "picture");
			_description = getText (_weaponCfg >> "descriptionShort");
			_lnbAdd = _ctrlList lnbaddrow ["",_displayName];
			_ctrlList lnbsetdata [[_lnbAdd,0],_x];
			_ctrlList lnbsetpicture [[_lnbAdd,0],_picture];
			_alpha = if (_x in TMF_AcreAddRadioActions_Array) then {1} else {0.5};
			_ctrlList lnbsetcolor [[_lnbAdd,1],[1,1,1,_alpha]];
		} forEach ACRE_RADIO_CLASSNAME_ARRAY;	
	};
	case "attributeLoad": {
	};
	
};