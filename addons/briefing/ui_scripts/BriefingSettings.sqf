params ["_mode",["_params",[]]];

#include "\a3\3den\UI\dikCodes.inc"

#define EDIT_CHANNEL_IDCS [313201,313202,313203,313204,313205,313206,313207,313208,313209,313210,313211]
#define BEHIND_EDIT_CHANNELS_IDCS [189437,101]

fn_removeUnitFromBrief = {
    params ["_channel", "_unit"];
    
    _list = (_unit get3DENAttribute "TMF_Briefinglist") params ["_value"];
    if (_value isEqualType []) then {
        //Is default do nothing
        _//unit set3DENAttribute ["TMF_Channellist",str []];
    } else {
        _value = call compile _value;
        _value = _value - [_channel];
        _unit set3DENAttribute ["TMF_Briefinglist",str _value];
    };
};

fn_removeGroupFromBrief = {
    params ["_channel", "_group"];

    _list = (_group get3DENAttribute "TMF_Briefinglist") params ["_value"];
    if (_value isEqualType []) then {
        //Is Default do nothing
        //_group set3DENAttribute ["TMF_ChannellistLeader",str []];
    } else {
        _value = call compile _value;
        _value = _value - [_curSel];
        _group set3DENAttribute ["TMF_Briefinglist",str _value];
    };

    
    _list = (_group get3DENAttribute "TMF_Briefinglist") params ["_value"];
    if (_value isEqualType []) then {
        //is default do nothing
        //_group set3DENAttribute ["TMF_Channellist",str []];
    } else {
        _value = call compile _value;
        _value = _value - [_curSel];
        _group set3DENAttribute ["TMF_Briefinglist",str _value];
    };
    // do units
    {
        [_channel, _x] call fn_removeUnitFromBrief;
    } forEach (units _group);
};

//Handle number preset of channel tree below

switch _mode do {
    case "onLoad": {
        private _playableUnits = playableUnits;
        _playableUnits pushBackUnique player;
        cacheAllPlayerGroups = allGroups select {{_x in _playableUnits} count (units _x) > 0};
        BriefingArray = ("TMF_MissionBriefingAttributes" get3DENMissionAttribute "TMF_Briefing");
        if (BriefingArray isEqualType "") then { BriefingArray = call compile BriefingArray;};
        if (isNil "BriefingArray") then {            
            BriefingArray = [
                ["West",[west],"briefing\briefing_west.sqf"],
                ["East",[east],"briefing\briefing_east.sqf"],
                ["Indfor",[resistance],"briefing\briefing_ind.sqf"],
                ["Credits",[west,east,civilian,sideLogic,resistance],"briefing\briefing_credits.sqf"]
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
            } forEach BriefingArray;
        };

        BriefingCurrentBrief = 0;

        //--- Init UI
        _ctrlGroup = _params select 0;
        BriefingSettings_ctrlGroup = _ctrlGroup;

        _ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {BriefingSettings_ctrlGroup = _this select 0;};}];
        _ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {BriefingSettings_ctrlGroup = nil;};}];
        
                
        {
            (_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
        } forEach (EDIT_CHANNEL_IDCS);
        {
            (_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
        } forEach (BEHIND_EDIT_CHANNELS_IDCS);
        
        ["refreshBriefList"] call BriefingSettings_script;
    };

    case "attributeLoad": {
        //Attribute loading is done in onLoad instead.
    };
    case "attributeSave": {
        private _array = + (uiNamespace getVariable "BriefingArray");
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
    case "refreshBriefList": {
        if (isNil "BriefingSettings_ctrlGroup") exitWith {};
        BriefingCurrentBrief = 0;
        
        private _ctrlBriefList = BriefingSettings_ctrlGroup controlsGroupCtrl 101;
        _ctrlBriefList lnbSetColumnsPos [0,5,5];
        
        lnbClear _ctrlBriefList;
        {
            _x params ["_name"];
            _ctrlBriefList lnbaddrow [_name, "", ""];
        } forEach BriefingArray;
        
        if (count BriefingArray > 0) then { 
            _ctrlBriefList lnbSetCurSelRow 0; BriefingCurrentBrief = 0;
        } else {
            _ctrlBriefList lnbSetColumnsPos [0,5,5];
            _ctrlBriefList lnbaddrow ["No Briefings","",""];
            BriefingCurrentBrief = -1;
        };
        
        ["refreshBriefTree"] call BriefingSettings_script;
    };
    
    
    case "refreshBriefTree": {
        
        if (isNil "BriefingSettings_ctrlGroup") exitWith {};
        
        _ctrlTree = BriefingSettings_ctrlGroup controlsGroupCtrl 189437;
        tvClear _ctrlTree;
        
        if (BriefingCurrentBrief == -1) exitWith {};
        BriefingCurrentBrief = lnbCurSelRow (BriefingSettings_ctrlGroup controlsGroupCtrl 101);
        
        (BriefingArray select BriefingCurrentBrief) params ["","_BriefConditions"];
        
        
        BriefingTree_data = [];
        
        
        fn_BriefTreeProcessUnit = {
            params ["_ctrlTree", "_treeRoot", "_doSpeak", "_unit"];        
            private _roleDesc = ((_unit get3DENAttribute "description") select 0);
            private _color = (side _unit) call TMF_common_fnc_sideToColor;
            
            if (_roleDesc == "") then {
                _roleDesc =    getText (configfile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");
            };
            private _unitIdx = _ctrlTree tvAdd [ _treeRoot, _roleDesc];
            private _location = _treeRoot + [_unitIdx];
            _ctrlTree tvSetValue [_location, BriefingTree_data pushBack _unit];            
            private _icon = getText (configFile >> "CfgVehicleIcons" >> getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "icon"));
            if (_icon == "") then {
                _icon = "\a3\3DEN\Data\Cfg3DEN\Object\iconPlayer_ca.paa"; //default player icon
            };
            _ctrlTree tvSetPicture [_location, _icon];
            _ctrlTree tvSetPictureColor [_location, _color];
                
                        
            if (!_doSpeak) then {
                private _unitChanList = (_unit get3DENAttribute "TMF_Briefinglist") select 0;
                if (_unitChanList isEqualType "") then {
                    _unitChanList = call compile _unitChanList;
                };
                if (BriefingCurrentBrief in _unitChanList) then {
                    _doSpeak = true;
                }; 
            };
            private _returnCode = 3;
            if (_doSpeak) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\check_small_ca.paa"];
                _returnCode = 0;
            } else {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\plus_small_ca.paa"];
            };
            
            //0: All, Partial: 1, Leader: 2, None: 3
            _returnCode
        };
        
        fn_BriefTreeProcessGroup = {
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
            _ctrlTree tvSetValue [_location, BriefingTree_data pushBack _group];
            
            if (!_doSpeak) then {
                private _grpChanList = (_group get3DENAttribute "TMF_Briefinglist") select 0;
                if (_grpChanList isEqualType "") then {
                    _grpChanList = call compile _grpChanList;
                };
                if (BriefingCurrentBrief in _grpChanList) then {
                    _doSpeak = true;
                };
            };            
            
            private _hasSpeaker = false;
            {
                if ([_ctrlTree, _location, _doSpeak, _x] call fn_BriefTreeProcessUnit != 3) then { 
                    _hasSpeaker = true;
                };
            } forEach (units _group);

            private _returnCode = 3;
            if (_doSpeak) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\check_small_ca.paa"];
                _returnCode = 0;
            } else {
                if (_hasSpeaker) then {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\plus_small_ca.paa"];
                    _ctrlTree tvExpand _location;
                    _returnCode = 1;
                } else {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\plus_small_ca.paa"];
                    _ctrlTree tvExpand _location;
                };
            };
            
            _returnCode    
        };
        
        fn_BriefTreeProcessFaction = {
            params ["_ctrlTree", "_treeRoot", "_doSpeak", "_faction"];
            BriefingCurrentBrief = lnbCurSelRow (BriefingSettings_ctrlGroup controlsGroupCtrl 101);
        
            (BriefingArray select BriefingCurrentBrief) params ["","_BriefConditions"];
            
            if (!_doSpeak and {_faction in _BriefConditions}) then {
                _doSpeak = true;
            };
            
            private _factionIdx = _ctrlTree tvAdd [ _treeRoot,getText (configfile >> "CfgFactionClasses" >> _faction >> "displayName")];
            private _location = _treeRoot + [_factionIdx];
    
            _ctrlTree tvSetValue [_location, BriefingTree_data pushBack _faction];
            
            private _factionImg = getText (configfile >> "CfgFactionClasses" >> _faction >> "icon");
            _ctrlTree tvSetPicture [_location, _factionImg];
            
            private _hasSpeaker = false;            
            {
                if ([_ctrlTree, _location, _doSpeak, _x] call fn_BriefTreeProcessGroup != 3) then {
                    _hasSpeaker = true;
                };
            } forEach (cacheAllPlayerGroups select {(faction (leader _x)) == _faction});
            
            private _returnCode = 3;
            
            if (_doSpeak) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\check_small_ca.paa"];
                _returnCode = 0;
            } else {
                if (_hasSpeaker) then {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\plus_small_ca.paa"];
                    _ctrlTree tvExpand _location;
                    _returnCode = 1;
                } else {
                    _ctrlTree tvExpand _location;
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\plus_small_ca.paa"];
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
            _ctrlTree tvSetValue [_location, BriefingTree_data pushBack _side];
            if (_side in _BriefConditions) then {
                _doSpeak = true;
            };
            
            //Collect factions for side.
            _factions = [];
            {
                _factions pushBackUnique (toLower (faction (leader _x)));
            } forEach (cacheAllPlayerGroups select {(side _x) == _side});
            private _hasSpeaker = false;
            {
                if ([_ctrlTree, _location, _doSpeak, _x] call fn_BriefTreeProcessFaction != 3) then { _hasSpeaker = true; };
            } forEach _factions;
            
            if (_doSpeak) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\check_small_ca.paa"];
            } else {
                if (_hasSpeaker) then {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\plus_small_ca.paa"];
                    _ctrlTree tvExpand _location;
                } else {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\briefing\UI\plus_small_ca.paa"];
                    _ctrlTree tvExpand _location;
                };
            };
        } forEach _sides;
    };

    case "BriefDelClick": {
        with uiNamespace do {
            private _curSel = lnbCurSelRow (BriefingSettings_ctrlGroup controlsGroupCtrl 101);
            if (_curSel == -1) exitWith {};

                BriefingArray deleteAt _curSel;
                ["refreshBriefList"] call BriefingSettings_script;
                ["save"] call BriefingSettings_script;                
        };
    };
    case "BriefAddClick": {
        with uiNamespace do {
            {
                (BriefingSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (BriefingSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
            
            BriefingSettingsEditMode = 0;
            (BriefingSettings_ctrlGroup controlsGroupCtrl 313206) ctrlSetText "";
            ctrlSetFocus (BriefingSettings_ctrlGroup controlsGroupCtrl 313206);
        };
    };
    case "BriefEditClick": {
        with uiNamespace do {
            private _curSel = lnbCurSelRow (BriefingSettings_ctrlGroup controlsGroupCtrl 101);
            if (_curSel == -1) exitWith {};
                                
            private _Briefings = (BriefingArray select _curSel);
            _Briefings params ["_name","","_script"];
            
            {
                (BriefingSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (BriefingSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
            
            BriefingSettingsEditMode = 1;
            (BriefingSettings_ctrlGroup controlsGroupCtrl 313206) ctrlSetText _name;
            (BriefingSettings_ctrlGroup controlsGroupCtrl 313211) ctrlSetText _script;

            ctrlSetFocus (BriefingSettings_ctrlGroup controlsGroupCtrl 313206);
        };
    };
    case "BriefingEditClickOkay": {
        with uiNamespace do {
            //EDIT MODE
            if (BriefingSettingsEditMode == 1) then {
                private _curSel = lnbCurSelRow (BriefingSettings_ctrlGroup controlsGroupCtrl 101);
                if (_curSel == -1) exitWith {};
                                    
                private _Briefings = (BriefingArray select _curSel);
                _Briefings set [0,ctrlText (BriefingSettings_ctrlGroup controlsGroupCtrl 313206)]; // ShortName
                _Briefings set [2,ctrlText (BriefingSettings_ctrlGroup controlsGroupCtrl 313211)]; // ShortName
                
            } else {

                BriefingArray pushBack [ctrlText (BriefingSettings_ctrlGroup controlsGroupCtrl 313206),[],ctrlText (BriefingSettings_ctrlGroup controlsGroupCtrl 313211)];
            };
            
            ["refreshBriefList"] call BriefingSettings_script;
            {
                (BriefingSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (BriefingSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
            ["save"] call BriefingSettings_script;
        };
    };
    case "BriefingDelClickCancel": {
        with uiNamespace do {
            {
                (BriefingSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (BriefingSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
        };
    };
    case "BriefTreeGive": {
        with uiNamespace do {
            private _ctrlTree = (BriefingSettings_ctrlGroup controlsGroupCtrl 189437);
            private _treeSel = tvCurSel _ctrlTree;
            private _entity = BriefingTree_data select (_ctrlTree tvValue _treeSel);
            
            // currentChannel
            private _curSel = lnbCurSelRow (BriefingSettings_ctrlGroup controlsGroupCtrl 101);
            private _condition = (BriefingArray select _curSel) select 1;
            
            if (_entity isEqualType east or _entity isEqualType "") then {
                _condition pushBackUnique _entity;
            } else {
                if (_entity isEqualType grpNull or _entity isEqualType objNull) then {
                    _list = (_entity get3DENAttribute "TMF_Briefinglist") params ["_value"];
                    if (_value isEqualType []) then {
                        _entity set3DENAttribute ["TMF_Briefinglist",str [_curSel]];
                    } else {
                        _value = call compile _value;
                        _value pushBackUnique _curSel;
                        _entity set3DENAttribute ["TMF_Briefinglist",str _value];
                    };
                };
            };
                            
            ["refreshBriefTree"] call BriefingSettings_script;
            ["save"] call BriefingSettings_script;
        };
    };
    
    case "BriefTreeRemove": {
        with uiNamespace do {
            private _ctrlTree = (BriefingSettings_ctrlGroup controlsGroupCtrl 189437);
            private _treeSel = tvCurSel _ctrlTree;
            private _entity = BriefingTree_data select (_ctrlTree tvValue _treeSel);
            
            // currentChannel
            private _curSel = lnbCurSelRow (BriefingSettings_ctrlGroup controlsGroupCtrl 101);
            private _BriefEntry = (BriefingArray select _curSel);
            private _condition = _BriefEntry select 1;
            
            if (_entity isEqualType east or _entity isEqualType "") then {
                _BriefEntry set [1,_condition - [_entity]];
                if (_entity isEqualType east) then {
                    //Find and remove matching faction groups
                    private _sideNum = _entity call TMF_common_fnc_sideToNum;
                    {
                        if (_x isEqualType "") then {
                            if (_sideNum == getNumber (configfile >> "CfgFactionClasses" >> _x >> "side")) then {
                                _BriefEntry set [1,_condition - [_x]];
                            };
                        };
                    } forEach (_condition);
                
                    //remove groups
                    {
                        [_curSel, _x] call fn_removeGroupFromBrief;
                    } forEach (allGroups select {side _x == _entity});
                };
                //Also remove faction.
                if (_entity isEqualType "") then {
                    {
                        [_curSel, _x] call fn_removeUnitFromBrief;
                    } forEach (allGroups select {faction (leader _x) == _entity});
                };
            } else {
                if (_entity isEqualType grpNull) then {
                    [_curSel,_entity] call fn_removeGroupFromBrief;
                };
                if (_entity isEqualType objNull) then {
                    [_curSel,_entity] call fn_removeUnitFromBrief;
                };
            };
            
            ["refreshBriefTree"] call BriefingSettings_script;
            ["save"] call BriefingSettings_script;
        };
    };
    
    case "save": {
        //RadioChannelArray
        private _array = + (uiNamespace getVariable "BriefingArray");
        {
            _x params ["","_conditions"];
            {
                if (_x isEqualType east) then {
                    _conditions set [_forEachIndex, (_x call TMF_common_fnc_sideToNum)];
                };
            } forEach (_conditions);
        } forEach _array;

        private _string = str _array;
        set3DENMissionAttributes [["TMF_MissionBriefingAttributes","TMF_Briefing",_string]];
    };
};

//LEAVE EMPTY TO RETURN VALUE.

