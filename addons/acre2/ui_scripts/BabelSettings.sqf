//with uiNameSpace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };
//with uiNameSpace do { RadioChannels_script = compile preprocessFileLineNumbers "RadioChannels.sqf"; }; with uiNameSpace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };
params ["_mode",["_params",[]]];

#include "\a3\3den\UI\dikCodes.inc"
//ret = (get3DENSelected "Object" select 0) set3DENAttribute ["TMF_Channellist","1"];
//set3DENAttributes [[get3DENSelected "Object","TMF_Channelset",[1,2,3]]];

#define EDIT_CHANNEL_IDCS [313201,313202,313203,313204,313205,313206,313207,313208,313209,313210]
#define BEHIND_EDIT_CHANNELS_IDCS [189437,101]

fn_removeUnitFromLang = {
    params ["_channel", "_unit"];
    
    _list = (_unit get3DENAttribute "TMF_BabelLanguages") params ["_value"];
    if (_value isEqualType []) then {
        //Is default do nothing
        _//unit set3DENAttribute ["TMF_Channellist",str []];
    } else {
        _value = call compile _value;
        _value = _value - [_channel];
        _unit set3DENAttribute ["TMF_BabelLanguages",str _value];
    };
};

fn_removeGroupFromLang = {
    params ["_channel", "_group"];

    _list = (_group get3DENAttribute "TMF_BabelLanguages") params ["_value"];
    if (_value isEqualType []) then {
        //Is Default do nothing
        //_group set3DENAttribute ["TMF_ChannellistLeader",str []];
    } else {
        _value = call compile _value;
        _value = _value - [_curSel];
        _group set3DENAttribute ["TMF_BabelLanguages",str _value];
    };

    
    _list = (_group get3DENAttribute "TMF_BabelLanguages") params ["_value"];
    if (_value isEqualType []) then {
        //is default do nothing
        //_group set3DENAttribute ["TMF_Channellist",str []];
    } else {
        _value = call compile _value;
        _value = _value - [_curSel];
        _group set3DENAttribute ["TMF_BabelLanguages",str _value];
    };
    // do units
    {
        [_channel, _x] call fn_removeUnitFromLang;
    } forEach (units _group);
};

//Handle number preset of channel tree below

switch _mode do {
    case "onLoad": {
        private _playableUnits = playableUnits;
        _playableUnits pushBackUnique player;
        cacheAllPlayerGroups = allGroups select {{_x in _playableUnits} count (units _x) > 0};
        BabelArray = ("TMF_MissionAcre2Attributes" get3DENMissionAttribute "TMF_AcreBabelSettings");
        if (BabelArray isEqualType "") then { BabelArray = call compile BabelArray;};
        if (isNil "BabelArray") then {            
            BabelArray = [
                ["English",[west]],
                ["Russian",[east]],
                ["Greek",[resistance]]
            ];
        } else {
            //Deserialize number to side.
            {
                _x params ["","_conditions"];
                {
                    if (_x isEqualType 0) then {
                        _conditions set [_forEachIndex, (_x call TMF_common_fnc_numToSide)];
                    };
                } forEach (_conditions);
            } forEach BabelArray;
        };

        BabelCurrentLang = 0;

        //--- Init UI
        _ctrlGroup = _params select 0;
        BabelSettings_ctrlGroup = _ctrlGroup;

        _ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {BabelSettings_ctrlGroup = _this select 0;};}];
        _ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {BabelSettings_ctrlGroup = nil;};}];
        
                
        {
            (_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
        } forEach (EDIT_CHANNEL_IDCS);
        {
            (_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
        } forEach (BEHIND_EDIT_CHANNELS_IDCS);
        
        ["refreshLangList"] call BabelSettings_script;
    };

    case "attributeLoad": {
        //Attribute loading is done in onLoad instead.
    };
    case "attributeSave": {
        private _array = + (uiNamespace getVariable "BabelArray");
        {
            _x params ["","_conditions"];
            {
                if (_x isEqualType east) then {
                    _conditions set [_forEachIndex, (_x call TMF_common_fnc_sideToNum)];
                };
            } forEach (_conditions);
        } forEach _array;

        private _string = str _array;
        _string
    };
    case "refreshLangList": {
        if (isNil "BabelSettings_ctrlGroup") exitWith {};
        BabelCurrentLang = 0;
        
        private _ctrlLangList = BabelSettings_ctrlGroup controlsGroupCtrl 101;
        _ctrlLangList lnbSetColumnsPos [0,5,5];
        
        lnbClear _ctrlLangList;
        {
            _x params ["_name"];
            _ctrlLangList lnbaddrow [_name, "", ""];
        } forEach BabelArray;
        
        if (count BabelArray > 0) then { 
            _ctrlLangList lnbSetCurSelRow 0; BabelCurrentLang = 0;
        } else {
            _ctrlLangList lnbSetColumnsPos [0,5,5];
            _ctrlLangList lnbaddrow ["No Languages","",""];
            BabelCurrentLang = -1;
        };
        
        ["refreshLangTree"] call BabelSettings_script;
    };
    
    
    case "refreshLangTree": {
        
        if (isNil "BabelSettings_ctrlGroup") exitWith {};
        
        _ctrlTree = BabelSettings_ctrlGroup controlsGroupCtrl 189437;
        tvClear _ctrlTree;
        
        if (BabelCurrentLang == -1) exitWith {};
        BabelCurrentLang = lnbCurSelRow (BabelSettings_ctrlGroup controlsGroupCtrl 101);
        
        (BabelArray select BabelCurrentLang) params ["","_langConditions"];
        
        
        BabelLang_data = [];
        
        
        fn_langTreeProcessUnit = {
            params ["_ctrlTree", "_treeRoot", "_doSpeak", "_unit"];        
            private _roleDesc = ((_unit get3DENAttribute "description") select 0);
            private _color = (side _unit) call TMF_common_fnc_sideToColor;
            
            if (_roleDesc == "") then {
                _roleDesc =    getText (configfile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");
            };
            private _unitIdx = _ctrlTree tvAdd [ _treeRoot, _roleDesc];
            private _location = _treeRoot + [_unitIdx];
            _ctrlTree tvSetValue [_location, BabelLang_data pushBack _unit];            
            private _icon = getText (configFile >> "CfgVehicleIcons" >> getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "icon"));
            if (_icon == "") then {
                _icon = "\a3\3DEN\Data\Cfg3DEN\Object\iconPlayer_ca.paa"; //default player icon
            };
            _ctrlTree tvSetPicture [_location, _icon];
            _ctrlTree tvSetPictureColor [_location, _color];
                
                        
            if (!_doSpeak) then {
                private _unitChanList = (_unit get3DENAttribute "TMF_BabelLanguages") select 0;
                if (_unitChanList isEqualType "") then {
                    _unitChanList = call compile _unitChanList;
                };
                if (BabelCurrentLang in _unitChanList) then {
                    _doSpeak = true;
                }; 
            };
            private _returnCode = 3;
            if (_doSpeak) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_on.paa"];
                _returnCode = 0;
            } else {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_off.paa"];
            };
            
            //0: All, Partial: 1, Leader: 2, None: 3
            _returnCode
        };
        
        fn_langTreeProcessGroup = {
            params ["_ctrlTree", "_treeRoot", "_doSpeak", "_group"];
            
            private _side = side _group;
            private _color = _side call TMF_common_fnc_sideToColor;
            private _grpIdx = _ctrlTree tvAdd [ _treeRoot, groupID _group];
            private _location = _treeRoot + [_grpIdx];
            private _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\n_unknown.paa";
            
            //Found in (configfile >> "Cfg3DEN" >> "Group" >> "Draw" >> "textureCivilian")
            call {
                if (_side == west) exitWith { _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\b_unknown.paa";};
                if (_side == east) exitWith { _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\o_unknown.paa"; };
                if (_side == guerilla) exitWith { _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\n_unknown.paa";};
                if (_side == civilian) exitWith { _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\n_unknown.paa";};
            };
            
            _ctrlTree tvSetPicture [_location, _grpIcon];
            _ctrlTree tvSetPictureColor [_location, _color];
            _ctrlTree tvSetValue [_location, BabelLang_data pushBack _group];
            
            if (!_doSpeak) then {
                private _grpChanList = (_group get3DENAttribute "TMF_BabelLanguages") select 0;
                if (_grpChanList isEqualType "") then {
                    _grpChanList = call compile _grpChanList;
                };
                if (BabelCurrentLang in _grpChanList) then {
                    _doSpeak = true;
                };
            };            
            
            private _hasSpeaker = false;
            {
                if ([_ctrlTree, _location, _doSpeak, _x] call fn_langTreeProcessUnit != 3) then { 
                    _hasSpeaker = true;
                };
            } forEach (units _group);

            private _returnCode = 3;
            if (_doSpeak) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_on.paa"];
                _returnCode = 0;
            } else {
                if (_hasSpeaker) then {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_partial.paa"];
                    _ctrlTree tvExpand _location;
                    _returnCode = 1;
                } else {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_off.paa"];
                    _ctrlTree tvExpand _location;
                };
            };
            
            _returnCode    
        };
        
        fn_langTreeProcessFaction = {
            params ["_ctrlTree", "_treeRoot", "_doSpeak", "_faction"];
            BabelCurrentLang = lnbCurSelRow (BabelSettings_ctrlGroup controlsGroupCtrl 101);
        
            (BabelArray select BabelCurrentLang) params ["","_langConditions"];
            
            if (!_doSpeak and {_faction in _langConditions}) then {
                _doSpeak = true;
            };
            
            private _factionIdx = _ctrlTree tvAdd [ _treeRoot,getText (configfile >> "CfgFactionClasses" >> _faction >> "displayName")];
            private _location = _treeRoot + [_factionIdx];
    
            _ctrlTree tvSetValue [_location, BabelLang_data pushBack _faction];
            
            private _factionImg = getText (configfile >> "CfgFactionClasses" >> _faction >> "icon");
            _ctrlTree tvSetPicture [_location, _factionImg];
            
            private _hasSpeaker = false;            
            {
                if ([_ctrlTree, _location, _doSpeak, _x] call fn_langTreeProcessGroup != 3) then {
                    _hasSpeaker = true;
                };
            } forEach (cacheAllPlayerGroups select {(faction (leader _x)) == _faction});
            
            private _returnCode = 3;
            
            if (_doSpeak) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_on.paa"];
                _returnCode = 0;
            } else {
                if (_hasSpeaker) then {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_partial.paa"];
                    _ctrlTree tvExpand _location;
                    _returnCode = 1;
                } else {
                    _ctrlTree tvExpand _location;
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_off.paa"];
                };
            };
            _returnCode
        };
        
        
        private _sides = []; {_sides pushBackUnique (side _x);} forEach cacheAllPlayerGroups;
        {
            private _side = _x;
            private _doSpeak = false;
            private _location = [(_ctrlTree tvAdd [[], _side call TMF_common_fnc_sideToString])];
            
            _ctrlTree tvSetPicture [_location, _side call TMF_common_fnc_sideToTexture];
            _ctrlTree tvSetValue [_location, BabelLang_data pushBack _side];
            if (_side in _langConditions) then {
                _doSpeak = true;
            };
            
            //Collect factions for side.
            _factions = [];
            {
                _factions pushBackUnique (toLower (faction (leader _x)));
            } forEach (cacheAllPlayerGroups select {(side _x) == _side});
            private _hasSpeaker = false;
            {
                if ([_ctrlTree, _location, _doSpeak, _x] call fn_langTreeProcessFaction != 3) then { _hasSpeaker = true; };
            } forEach _factions;
            
            if (_doSpeak) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_on.paa"];
            } else {
                if (_hasSpeaker) then {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_partial.paa"];
                    _ctrlTree tvExpand _location;
                } else {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\bable_off.paa"];
                    _ctrlTree tvExpand _location;
                };
            };
        } forEach _sides;
    };

    case "langDelClick": {
        with uiNamespace do {
            private _curSel = lnbCurSelRow (BabelSettings_ctrlGroup controlsGroupCtrl 101);
            if (_curSel == -1) exitWith {};

                BabelArray deleteAt _curSel;
                ["refreshLangList"] call BabelSettings_script;
                ["save"] call BabelSettings_script;                
        };
    };
    case "langAddClick": {
        with uiNamespace do {
            {
                (BabelSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (BabelSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
            
            BabelLanguagesEditMode = 0;
            (BabelSettings_ctrlGroup controlsGroupCtrl 313206) ctrlSetText "";
            ctrlSetFocus (BabelSettings_ctrlGroup controlsGroupCtrl 313206);
        };
    };
    case "langEditClick": {
        with uiNamespace do {
            private _curSel = lnbCurSelRow (BabelSettings_ctrlGroup controlsGroupCtrl 101);
            if (_curSel == -1) exitWith {};
                                
            private _languages = (BabelArray select _curSel);
            _languages params ["_name"];
            
            {
                (BabelSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (BabelSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
            
            BabelLanguagesEditMode = 1;
            (BabelSettings_ctrlGroup controlsGroupCtrl 313206) ctrlSetText _name;

            ctrlSetFocus (BabelSettings_ctrlGroup controlsGroupCtrl 313206);
        };
    };
    case "languageEditClickOkay": {
        with uiNamespace do {
            //EDIT MODE
            if (BabelLanguagesEditMode == 1) then {
                private _curSel = lnbCurSelRow (BabelSettings_ctrlGroup controlsGroupCtrl 101);
                if (_curSel == -1) exitWith {};
                                    
                private _languages = (BabelArray select _curSel);
                _languages set [0,ctrlText (BabelSettings_ctrlGroup controlsGroupCtrl 313206)]; // ShortName
                
            } else {

                BabelArray pushBack [ctrlText (BabelSettings_ctrlGroup controlsGroupCtrl 313206),[]];
            };
            
            ["refreshLangList"] call BabelSettings_script;
            {
                (BabelSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (BabelSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
            ["save"] call BabelSettings_script;
        };
    };
    case "languageDelClickCancel": {
        with uiNamespace do {
            {
                (BabelSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (BabelSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
        };
    };
    case "langTreeGive": {
        with uiNamespace do {
            private _ctrlTree = (BabelSettings_ctrlGroup controlsGroupCtrl 189437);
            private _treeSel = tvCurSel _ctrlTree;
            private _entity = BabelLang_data select (_ctrlTree tvValue _treeSel);
            
            // currentChannel
            private _curSel = lnbCurSelRow (BabelSettings_ctrlGroup controlsGroupCtrl 101);
            private _condition = (BabelArray select _curSel) select 1;
            
            if (_entity isEqualType east or _entity isEqualType "") then {
                _condition pushBackUnique _entity;
            } else {
                if (_entity isEqualType grpNull or _entity isEqualType objNull) then {
                    _list = (_entity get3DENAttribute "TMF_BabelLanguages") params ["_value"];
                    if (_value isEqualType []) then {
                        _entity set3DENAttribute ["TMF_BabelLanguages",str [_curSel]];
                    } else {
                        _value = call compile _value;
                        _value pushBackUnique _curSel;
                        _entity set3DENAttribute ["TMF_BabelLanguages",str _value];
                    };
                };
            };
                            
            ["refreshLangTree"] call BabelSettings_script;
            ["save"] call BabelSettings_script;
        };
    };
    
    case "langTreeRemove": {
        with uiNamespace do {
            private _ctrlTree = (BabelSettings_ctrlGroup controlsGroupCtrl 189437);
            private _treeSel = tvCurSel _ctrlTree;
            private _entity = BabelLang_data select (_ctrlTree tvValue _treeSel);
            
            // currentChannel
            private _curSel = lnbCurSelRow (BabelSettings_ctrlGroup controlsGroupCtrl 101);
            private _langEntry = (BabelArray select _curSel);
            private _condition = _langEntry select 1;
            
            if (_entity isEqualType east or _entity isEqualType "") then {
                _langEntry set [1,_condition - [_entity]];
                if (_entity isEqualType east) then {
                    //Find and remove matching faction groups
                    private _sideNum = _entity call TMF_common_fnc_sideToNum;
                    {
                        if (_x isEqualType "") then {
                            if (_sideNum == getNumber (configfile >> "CfgFactionClasses" >> _x >> "side")) then {
                                _langEntry set [1,_condition - [_x]];
                            };
                        };
                    } forEach (_condition);
                
                    //remove groups
                    {
                        [_curSel, _x] call fn_removeGroupFromLang;
                    } forEach (allGroups select {side _x == _entity});
                };
                //Also remove faction.
                if (_entity isEqualType "") then {
                    {
                        [_curSel, _x] call fn_removeUnitFromLang;
                    } forEach (allGroups select {faction (leader _x) == _entity});
                };
            } else {
                if (_entity isEqualType grpNull) then {
                    [_curSel,_entity] call fn_removeGroupFromLang;
                };
                if (_entity isEqualType objNull) then {
                    [_curSel,_entity] call fn_removeUnitFromLang;
                };
            };
            
            ["refreshLangTree"] call BabelSettings_script;
            ["save"] call BabelSettings_script;
        };
    };
    
    case "save": {
        //RadioChannelArray
        private _array = + (uiNamespace getVariable "BabelArray");
        {
            _x params ["","_conditions"];
            {
                if (_x isEqualType east) then {
                    _conditions set [_forEachIndex, (_x call TMF_common_fnc_sideToNum)];
                };
            } forEach (_conditions);
        } forEach _array;

        private _string = str _array;
        set3DENMissionAttributes [["teamworkMissionAcreAttributes","TMF_AcreBabelSettings",_string]];
    };
};

//LEAVE EMPTY TO RETURN VALUE.

