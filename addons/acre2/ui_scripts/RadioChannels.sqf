//with uiNameSpace do { RadioChannels_script = compile preprocessFileLineNumbers "RadioChannels.sqf"; };

params ["_mode",["_params",[]]];

#include "\a3\3den\UI\dikCodes.inc"

// with uiNamespace do {     set3DENMissionAttributes [["teamworkMissionAcreAttributes","TMF_AcreSettings",str RadioChannelArray]];    };
// with uiNamespace do {     set3DENMissionAttributes [["teamworkMissionAcreAttributes","TMF_AcreSettings","[]"]];    };

#define EDIT_CHANNEL_IDCS [313201,313202,313203,313204,313205,313206,313207,313208,313209,313210,313211,313212]
#define BEHIND_EDIT_CHANNELS_IDCS [189437,101]

#define ACRE_RADIO_CLASSNAME_ARRAY ["ACRE_PRC343","ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F","ACRE_PRC77","ACRE_SEM52SL"]

fn_removeUnitFromChannel = {
    params ["_channel", "_unit"];
    
    _list = (_unit get3DENAttribute "TMF_Channellist") params ["_value"];
    if (_value isEqualType []) then {
        //Is default do nothing
        //_unit set3DENAttribute ["TMF_Channellist",str []];
    } else {
        _value = call compile _value;
        _value = _value - [_channel];
        _unit set3DENAttribute ["TMF_Channellist",str _value];
    };
};

fn_removeGroupFromChannel = {
    params ["_channel", "_group"];

    _list = (_group get3DENAttribute "TMF_ChannellistLeader") params ["_value"];
    if (_value isEqualType []) then {
        //Is Default do nothing
        //_group set3DENAttribute ["TMF_ChannellistLeader",str []];
    } else {
        _value = call compile _value;
        _value = _value - [_curSel];
        _group set3DENAttribute ["TMF_ChannellistLeader",str _value];
    };

    
    _list = (_group get3DENAttribute "TMF_Channellist") params ["_value"];
    if (_value isEqualType []) then {
        //is default do nothing
        //_group set3DENAttribute ["TMF_Channellist",str []];
    } else {
        _value = call compile _value;
        _value = _value - [_curSel];
        _group set3DENAttribute ["TMF_Channellist",str _value];
    };
    // do units
    {
        [_channel, _x] call fn_removeUnitFromChannel;
    } forEach (units _group);
};


// Handle setting network number input
fn_networkTreeHandleKey = {
    params ["_ctrlTree","_networkNumber"];

    private _location = tvCurSel _ctrlTree;
    private _thing = RadioNetwork_data select (_ctrlTree tvValue _location);

    if (_thing isEqualType west) then {
        private _sideNum = _thing call TMF_common_fnc_sideToNum;
        {
            private _channel = _x;
            _channel params ["_condition"];
            {
                if (_x isEqualTo _thing) then {
                    _condition set [_forEachIndex,-1];
                };
                if (_x isEqualType "") then {
                    if (_sideNum == getNumber (configfile >> "CfgFactionClasses" >> _x >> "side")) then {
                        _condition set [_forEachIndex,-1];
                    };
                };
            } forEach _condition;
            _channel set [0,_condition - [-1]];
        } forEach RadioChannelArray;
        //nullify all attributes
        {
            set3DENAttributes [[units _x, "TMF_Network", -1], [[_x],"TMF_Network", -1]];
            set3DENAttributes [[units _x, "TMF_Channellist", "[]"], [[_x],"TMF_Channellist", "[]"], [[_x],"TMF_ChannellistLeader", "[]"]];
        } forEach (cacheAllPlayerGroups select {side _x == _thing});

        if (_networkNumber <= (count RadioChannelArray)) then {
            ((RadioChannelArray select (_networkNumber -1)) select 0) pushBack _thing;
        } else {
            for "_i" from (count RadioChannelArray) to (_networkNumber - 2) do {
                RadioChannelArray pushBack [[],[]];
            };
            RadioChannelArray pushBack [[_thing],[]];
        };
    };
    if (_thing isEqualType "") then {
        
        private _sideNum = getNumber (configfile >> "CfgFactionClasses" >> _thing >> "side");
        private _side = _sideNum call TMF_common_fnc_numToSide;

        {
            private _channel = _x;
            _channel params ["_condition"];
            _channel set [0,_condition - [_thing,_side]];
        } forEach RadioChannelArray;
        //nullify all attributes
        {
            set3DENAttributes [[units _x, "TMF_Network", -1], [[_x],"TMF_Network", -1]];
            set3DENAttributes [[units _x, "TMF_Channellist", "[]"], [[_x],"TMF_Channellist", "[]"], [[_x],"TMF_ChannellistLeader", "[]"]];
        } forEach (cacheAllPlayerGroups select {(faction (leader _x)) == _thing});
        
        if (_networkNumber <= (count RadioChannelArray)) then {
            ((RadioChannelArray select (_networkNumber -1)) select 0) pushBack _thing;
        } else {
            for "_i" from (count RadioChannelArray) to (_networkNumber - 2) do {
                RadioChannelArray pushBack [[],[]];
            };
            RadioChannelArray pushBack [[_thing],[]];
        };
    };
    if (_thing isEqualType grpNull) then {
        private _faction = toLower (faction (leader _thing));
        private _sideNum = getNumber (configfile >> "CfgFactionClasses" >> _faction >> "side");
        private _side = _sideNum call TMF_common_fnc_numToSide;
        {
            private _channel = _x;
            _channel params ["_condition"];
            _channel set [0,_condition - [_faction, _side]];
        } forEach RadioChannelArray;
        
        set3DENAttributes [[units _thing, "TMF_Network", -1],
            [[_thing],"TMF_Network",(_networkNumber-1)]];
        set3DENAttributes [[units _thing, "TMF_Channellist", "[]"], [[_thing],"TMF_Channellist", "[]"], [[_thing],"TMF_Channellist", "[]"], [[_thing],"TMF_ChannellistLeader", "[]"]];

    };
    if (_thing isEqualType objNull) then {
        private _faction = toLower (faction (leader (group _thing)));
        private _sideNum = getNumber (configfile >> "CfgFactionClasses" >> _faction >> "side");
        private _side = _sideNum call TMF_common_fnc_numToSide;
        {
            private _channel = _x;
            _channel params ["_condition"];
            _channel set [0,_condition - [_faction, _side]];
        } forEach RadioChannelArray;
        
        set3DENAttributes [[[_thing],"TMF_Network", (_networkNumber-1)],
            [[group _thing],"TMF_Network",-1]];
        set3DENAttributes [[[_thing], "TMF_Channellist", "[]"], [[group _thing],"TMF_Channellist", "[]"], [[group _thing],"TMF_ChannellistLeader", "[]"]];
        
    };
    
    //FUTURE Consider erasing CHANNEL_LISTS on preset change?
    
    //Force re-render?
    ["refreshNetworkTree"] call RadioChannels_script;
    ["refreshChannelList"] call RadioChannels_script;
    ["save"] call RadioChannels_script;
};


switch _mode do {
    case "onLoad": {
        private _playableUnits = playableUnits;
        _playableUnits pushBackUnique player;
        cacheAllPlayerGroups = allGroups select {{_x in _playableUnits} count (units _x) > 0};
        
        RadioChannelArray = ("TMF_MissionAcre2Attributes" get3DENMissionAttribute "TMF_AcreSettings");
        if (RadioChannelArray isEqualType "") then { RadioChannelArray = call compile RadioChannelArray;};
        if (isNil "RadioChannelArray") then {
            /*RadioChannelArray = [
                                    [["blu_f"],[
                                            ["Alpha","Alpha Squad Net","ACRE_PRC343",["blu_f"]],
                                            ["Bravo","Bravo Squad Net","ACRE_PRC343",[]],
                                            ["Charlie","Charlie Squad Net","ACRE_PRC343",[]],
                                            ["1PLT-COM","Platoon Command Net","ACRE_PRC148",[]] 
                                        ]],
                                    [[east],[]],
                                    [[resistance],[]],
                                    [["blu_g_f"],[]]
                                ];*/
            RadioChannelArray = [];
            //RadioChannelArray = call compile ("teamworkMissionAcreAttributes" get3DENMissionAttribute "TMF_AcreSettings");
        };

        //Deserialize: Convert nums to side from
        {
            private _network = _x;
            _network params ["_conditions", "_channels"];
            {
                if (_x isEqualType 0) then {
                    _conditions set [_forEachIndex,(_x call TMF_common_fnc_numToSide)];
                };
            } forEach (_conditions);
            {
                private _condition = _x select 3; // condition
                {
                    if (_x isEqualType 0) then {
                        _condition set [_forEachIndex,(_x call TMF_common_fnc_numToSide)];
                    };
                } forEach (_condition);
            } forEach (_channels);
        } forEach RadioChannelArray;
        RadioCurrentNetwork = 0;

        //--- Init UI
        _ctrlGroup = _params select 0;
        RadioChannels_ctrlGroup = _ctrlGroup;

        _ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {RadioChannels_ctrlGroup = _this select 0;};}];
        _ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {RadioChannels_ctrlGroup = nil;};}];
        

        
        ["refreshNetworkTree"] call RadioChannels_script;
        ["refreshChannelList"] call RadioChannels_script;
        
        //Tree EH for keyboard number presses
        _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
        _ctrlTree ctrladdeventhandler ["keyDown",{with uinamespace do {['keydown',[RadioChannels_ctrlGroup,_this select 1,_this select 2,_this select 3],objnull] call RadioChannels_script;};}];

        
        {
            (_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
        } forEach (EDIT_CHANNEL_IDCS);
        {
            (_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
        } forEach (BEHIND_EDIT_CHANNELS_IDCS);
        
        
    };

    case "keydown": { // Handle key press on tree.
        _params params ["_ctrlGroup", "_key", "_shift", "_ctrl"];
        if !(isnil "_ctrlGroup") then {

            _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
            
            switch _key do {
                case DIK_1:  {
                    _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
                    [_ctrlTree, 1] call fn_networkTreeHandleKey;
                };
                case DIK_2:  {
                    _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
                    [_ctrlTree, 2] call fn_networkTreeHandleKey;
                };
                case DIK_3:  {
                    _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
                    [_ctrlTree, 3] call fn_networkTreeHandleKey;
                };
                case DIK_4:  {
                    _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
                    [_ctrlTree, 4] call fn_networkTreeHandleKey;
                };
                case DIK_5:  {
                    _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
                    [_ctrlTree, 5] call fn_networkTreeHandleKey;
                };
                case DIK_6:  {
                    _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
                    [_ctrlTree, 6] call fn_networkTreeHandleKey;
                };
                case DIK_7:  {
                    _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
                    [_ctrlTree, 7] call fn_networkTreeHandleKey;
                };
                case DIK_8:  {
                    _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
                    [_ctrlTree, 8] call fn_networkTreeHandleKey;
                };
                case DIK_9:  {
                    _ctrlTree = _ctrlGroup controlsGroupCtrl 189438;
                    [_ctrlTree, 9] call fn_networkTreeHandleKey;
                };
                default {false};
            };
        } else {
            false
        };
    };
    case "attributeLoad": {
        //Attribute loading is done in onLoad instead.
    };
    case "attributeSave": {
    
        private _array = + (uiNamespace getVariable "RadioChannelArray");
        {
            private _network = _x;
            _network params ["_conditions", "_channels"];
            {
                if (_x isEqualType east) then {
                    _conditions set [_forEachIndex, (_x call TMF_common_fnc_sideToNum)];
                };
            } forEach (_conditions);
            {
                private _condition = _x select 3; // condition
                {
                    if (_x isEqualType east) then {
                        _condition set [_forEachIndex, (_x call TMF_common_fnc_sideToNum)];
                    };
                } forEach (_condition);
            } forEach (_channels);
        } forEach _array;
        
        private _string = str _array;
        _string
    };
    case "refreshChannelList": {
        if (isNil "RadioChannels_ctrlGroup") exitWith {};
        
        private _ctrlChannelList = RadioChannels_ctrlGroup controlsGroupCtrl 101;
        private _hasChannels = false;
        lnbClear _ctrlChannelList;
        
        if (RadioCurrentNetwork < count RadioChannelArray) then {
            (RadioChannelArray select RadioCurrentNetwork) params ["","_channels"];
            _ctrlChannelList lnbSetColumnsPos [0,0.005,0.33];
            
            {
                _hasChannels = true;
                _x params ["_shortName", "_longName", "_radioClassname", "_condition", "_shared"];

                private _lnbIdx = _ctrlChannelList lnbaddrow ["", _shortName, _longName];
                private _icon = getText (configFile >> "CfgWeapons" >> _radioClassname >> "picture");
                _ctrlChannelList lnbSetPicture [[_lnbIdx,1],_icon];
            } forEach _channels;
        };
            
        //Update cursor var.
        if (_hasChannels) then { 
            _ctrlChannelList lnbSetCurSelRow 0; RadioCurrentNetworkChannel = 0;
        } else {
            _ctrlChannelList lnbSetColumnsPos [0,1,1];
            if (RadioCurrentNetwork < count RadioChannelArray) then {
                _ctrlChannelList lnbaddrow ["No Channels on this network","",""];
            } else {
                _ctrlChannelList lnbaddrow ["Adds units to this network first!","",""];
            };
            RadioCurrentNetworkChannel = -1;
        };
        
        ["refreshChannelTree"] call RadioChannels_script;
    };
    
    
    case "refreshChannelTree": {
        if (isNil "RadioChannels_ctrlGroup") exitWith {};
        
        private _ctrlTree = RadioChannels_ctrlGroup controlsGroupCtrl 189437;
        tvClear _ctrlTree;
        
        
        
        if (RadioCurrentNetworkChannel == -1) exitWith {};
        RadioCurrentNetworkChannel = lnbCurSelRow (RadioChannels_ctrlGroup controlsGroupCtrl 101);
        
        (RadioChannelArray select RadioCurrentNetwork) params ["_conditions","_channels"];
        
        private _channel = (_channels select RadioCurrentNetworkChannel);
        _channel params ["","","","_channelConditions"];
        
        
        RadioNetworkChannel_data = [];
        
        
        fn_channelTreeProcessUnit = {
            params ["_ctrlTree", "_treeRoot", "_giveRadio", "_unit"];        
            private _roleDesc = ((_x get3DENAttribute "description") select 0);
            
            private _color = (side _unit) call TMF_common_fnc_sideToColor;
            
            if (_roleDesc == "") then {
                _roleDesc =    getText (configfile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");
            };
            private _unitIdx = _ctrlTree tvAdd [ _treeRoot, _roleDesc];
            private _location = _treeRoot + [_unitIdx];
            _ctrlTree tvSetValue [_location, RadioNetworkChannel_data pushBack _unit];            
            private _icon = getText (configFile >> "CfgVehicleIcons" >> getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "icon"));
            if (_icon == "") then {
                _icon = "\a3\3DEN\Data\Cfg3DEN\Object\iconPlayer_ca.paa"; //default player icon
            };
            _ctrlTree tvSetPicture [_location,_icon];
            _ctrlTree tvSetPictureColor [_location, _color];
                
                        
            if (!_giveRadio) then {
                private _unitChanList = (_unit get3DENAttribute "TMF_Channellist") select 0;
                if (_unitChanList isEqualType "") then {
                    _unitChanList = call compile _unitChanList;
                };
                //private _unitChanList = (call compile ((_unit get3DENAttribute "TMF_Channellist") select 0));
                if (RadioCurrentNetworkChannel in _unitChanList) then {
                    _giveRadio = true;
                }; 
            };
            private _returnCode = 3;
            if (_giveRadio) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_Radio_Small.paa"];
                _returnCode = 0;
            } else {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_None_Small.paa"];
            };
            
            //0: All, Partial: 1, Leader: 2, None: 3
            _returnCode
        };
        
        fn_channelTreeProcessGroup = {
            params ["_ctrlTree", "_treeRoot", "_giveRadio", "_group"];
            
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
            _ctrlTree tvSetValue [_location, RadioNetworkChannel_data pushBack _group];
            
            private _giveLeader = false;
            if (!_giveRadio) then {
                private _grpChanList = (_group get3DENAttribute "TMF_Channellist") select 0;
                if (_grpChanList isEqualType "") then {
                    _grpChanList = call compile _grpChanList;
                };
                if (RadioCurrentNetworkChannel in _grpChanList) then {
                    _giveRadio = true;
                } else {
                    _grpChanList = (_group get3DENAttribute "TMF_ChannellistLeader") select 0;
                    if (_grpChanList isEqualType "") then {
                        _grpChanList = call compile _grpChanList;
                    };
                    if (RadioCurrentNetworkChannel in _grpChanList) then {
                        _giveLeader = true;
                    }; 
                };
            };
            
            
            private _gaveSomeoneARadio = false;
            {
                if ([_ctrlTree, _location, _giveRadio, _x] call fn_channelTreeProcessUnit != 3) then { 
                    _gaveSomeoneARadio = true;
                };
            } forEach (units _group);

            private _returnCode = 3;
            if (_giveRadio) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_Radio_Small.paa"];
                _returnCode = 0;
            } else {
                if (_giveLeader) then {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_Leader_Small.paa"];
                    _returnCode = 2;
                } else {
                    if (_gaveSomeoneARadio) then {
                        _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_Partial_Small.paa"];
                        _ctrlTree tvExpand _location;
                        _returnCode = 1;
                    } else {
                        _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_None_Small.paa"];
                        _ctrlTree tvExpand _location;
                    };
                };
            };
            
            _returnCode    
        };
        
        fn_channelTreeProcessFaction = {
            params ["_ctrlTree", "_treeRoot", "_giveRadio", "_faction"];
            
            (RadioChannelArray select RadioCurrentNetwork) params ["_conditions","_channels"];
            private _channel = (_channels select RadioCurrentNetworkChannel);
            _channel params ["","","","_channelConditions"];
            
            if (!_giveRadio and {_faction in _channelConditions}) then {
                _giveRadio = true;
            };
            
            private _factionIdx = _ctrlTree tvAdd [ _treeRoot,getText (configfile >> "CfgFactionClasses" >> _faction >> "displayName")];
            private _location = _treeRoot + [_factionIdx];
    
            _ctrlTree tvSetValue [_location, RadioNetworkChannel_data pushBack _faction];
            
            private _factionImg = getText (configfile >> "CfgFactionClasses" >> _faction >> "icon");
            _ctrlTree tvSetPicture [_location, _factionImg];
            
            private _gaveSomeoneARadio = false;            
            {
                if ([_ctrlTree, _location, _giveRadio, _x] call fn_channelTreeProcessGroup != 3) then {
                    _gaveSomeoneARadio = true;
                };
            } forEach (cacheAllPlayerGroups select {(faction (leader _x)) == _faction});
            
            private _returnCode = 3;
            
            if (_giveRadio) then {
                _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_Radio_Small.paa"];
                _returnCode = 0;
            } else {
                if (_gaveSomeoneARadio) then {
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_Partial_Small.paa"];
                    _ctrlTree tvExpand _location;
                    _returnCode = 1;
                } else {
                    _ctrlTree tvExpand _location;
                    _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_None_Small.paa"];
                };
            };
            _returnCode
        };
        
        private _sides = [];
        {
            private _condition = _x;
            if (_x isEqualType east) then {    
                private _side = _x;
                
                
                if (_sides pushBackUnique _side != -1) then {
                    private _giveRadio = false;
                    private _location = [(_ctrlTree tvAdd [[], _side call TMF_common_fnc_sideToString])];
                    
                    _ctrlTree tvSetPicture [_location, _side call TMF_common_fnc_sideToTexture];
                    _ctrlTree tvSetValue [_location, RadioNetworkChannel_data pushBack _side];
                    if (_side in _channelConditions) then {
                        _giveRadio = true;
                    };
                    
                    //Collect factions for side.
                    _factions = [];
                    {
                        _factions pushBackUnique (toLower (faction (leader _x)));
                    } forEach (cacheAllPlayerGroups select {(side _x) == _side});
                    private _gaveSomeoneARadio = false;
                    {
                        if ([_ctrlTree, _location, _giveRadio, _x] call fn_channelTreeProcessFaction != 3) then { _gaveSomeoneARadio = true; };
                    } forEach _factions;
                    
                    if (_giveRadio) then {
                        _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_Radio_Small.paa"];
                    } else {
                        if (_gaveSomeoneARadio) then {
                            _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_Partial_Small.paa"];
                            _ctrlTree tvExpand _location;
                        } else {
                            _ctrlTree tvSetPictureRight [_location, "x\tmf\addons\acre2\ui\RadioIcon_None_Small.paa"];
                            _ctrlTree tvExpand _location;
                        };
                    };
                };
            };
            if (_x isEqualType "") then {
                [_ctrlTree, [], false, _x] call fn_channelTreeProcessFaction;
            };
        } forEach _conditions;

        
        {
            private _group = _x;
            if (_sides find (side _group) == -1) then {
                if (_sides find (toLower faction (leader _group)) == -1) then {
                    if (((_group get3DENAttribute "TMF_Network") select 0) == RadioCurrentNetwork) then {
                        [_ctrlTree, [], false, _x] call fn_channelTreeProcessGroup;
                    } else {
                        {
                            if (((_x get3DENAttribute "TMF_Network") select 0) == RadioCurrentNetwork) then {
                                [_ctrlTree, [], false, _x] call fn_channelTreeProcessUnit;
                            };
                        } forEach (units _group);
                    };
                };
            };
        } forEach cacheAllPlayerGroups;
        
    };
    
    
    case "refreshNetworkTree": {
        
        if (isNil "RadioChannels_ctrlGroup") exitWith {};
        
        _ctrlTree = RadioChannels_ctrlGroup controlsGroupCtrl 189438;
        tvClear _ctrlTree;
        
        RadioNetwork_data = [];
        
        _sides = [];
        _factions = [];
        {
            private _group = _x;
            private _side = (side _x);
            private _color = _side call TMF_common_fnc_sideToColor;
            
            private _sideIdx = _sides find _side;
            private _networkNumber = -1;
            scopeName "condSideSearch";
            {
                _x params ["_condition"];
                private _sideNum = _forEachIndex;
                {
                    if (_side isEqualTo _x) then {
                        _networkNumber = _sideNum;
                        breakTo "condSideSearch";
                    };
                } forEach _condition;
            } forEach RadioChannelArray;

            //Find Side
            if (_sideIdx == -1) then {
                private _sideText = _side call TMF_common_fnc_sideToString; 
                private _sideIcon = _side call TMF_common_fnc_sideToTexture; 
                
                _ctrlTree tvAdd [[], _sideText];
                _sideIdx = _sides pushBack _side;
                
                _ctrlTree tvSetPicture [[_sideIdx], _sideIcon];
                _ctrlTree tvSetValue [[_sideIdx], RadioNetwork_data pushBack _side];
                
                if (_networkNumber != -1) then {
                    _ctrlTree tvSetPictureRight [[_sideIdx], (_networkNumber+1) call TMF_common_fnc_numToTexture];
                } else {
                    _ctrlTree tvExpand [_sideIdx];
                };
                            
                //Add Faction
                _factions pushBack [];
            };
            //Find Faction
            private _faction = toLower (faction (leader _x));
            private _sideFactions = _factions select _sideIdx;
            private _factionIdx = _sideFactions find _faction;
            
            
            if (_networkNumber == -1) then {
                {
                    _x params ["_condition"];
                    private _sideNum = _forEachIndex;
                    {
                        if (_faction isEqualTo _x) then {
                            _networkNumber = _sideNum;
                            breakTo "condSideSearch"; // quits to main scope not a problem.
                        };
                    } forEach _condition;
                } forEach RadioChannelArray;
            };
            
            
            if (_factionIdx == -1) then {
                _factionIdx = _ctrlTree tvAdd [ [_sideIdx],getText (configfile >> "CfgFactionClasses" >> _faction >> "displayName")];
                _sideFactions pushBack _faction;
                _ctrlTree tvSetValue [[_sideIdx, _factionIdx], RadioNetwork_data pushBack _faction];
                
                private _factionImg = getText (configfile >> "CfgFactionClasses" >> _faction >> "icon");
                _ctrlTree tvSetPicture [[_sideIdx,_factionIdx],_factionImg];
                
                if (_networkNumber != -1) then {
                    _ctrlTree tvSetPictureRight [[_sideIdx, _factionIdx], (_networkNumber+1) call TMF_common_fnc_numToTexture];
                } else {
                    _ctrlTree tvExpand [_sideIdx, _factionIdx];
                };
            };
            
            
            private _grpIdx = _ctrlTree tvAdd [ [_sideIdx, _factionIdx],groupID _x];
            private _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\n_unknown.paa";
            
            //Found in (configfile >> "Cfg3DEN" >> "Group" >> "Draw" >> "textureCivilian")
            call {
                if (_side == west) exitWith { _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\b_unknown.paa";};
                if (_side == east) exitWith { _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\o_unknown.paa"; };
                if (_side == guerilla) exitWith { _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\n_unknown.paa";};
                if (_side == civilian) exitWith { _grpIcon = "\a3\Ui_f\data\Map\Markers\NATO\n_unknown.paa";};
            };
            
            _ctrlTree tvSetPicture [[_sideIdx, _factionIdx, _grpIdx], _grpIcon];
            _ctrlTree tvSetPictureColor [[_sideIdx, _factionIdx, _grpIdx], _color];
            _ctrlTree tvSetValue [[_sideIdx, _factionIdx, _grpIdx], RadioNetwork_data pushBack _group];
            
            if (_networkNumber != -1) then {
                _ctrlTree tvSetPictureRight [[_sideIdx, _factionIdx, _grpIdx], (_networkNumber+1) call TMF_common_fnc_numToTexture];
            } else {
                _networkNumber = (_group get3DENAttribute "TMF_Network") select 0;
                if (_networkNumber != -1) then {
                    _ctrlTree tvSetPictureRight [[_sideIdx, _factionIdx, _grpIdx], (_networkNumber+1) call TMF_common_fnc_numToTexture];
                };
            };
            
            private _preUnitNetworkNumber = _networkNumber;
            {
                _networkNumber = _preUnitNetworkNumber;
                
                private _roleDesc = ((_x get3DENAttribute "description") select 0);
                if (_roleDesc == "") then {
                    _roleDesc =    getText (configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
                };
                private _unitIdx = _ctrlTree tvAdd [ [_sideIdx, _factionIdx, _grpIdx], _roleDesc];
                private _icon = getText (configFile >> "CfgVehicleIcons" >> getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "icon"));
                if (_icon == "") then {
                    _icon = "\a3\3DEN\Data\Cfg3DEN\Object\iconPlayer_ca.paa"; //default player icon
                };
                _ctrlTree tvSetPicture [[_sideIdx, _factionIdx, _grpIdx, _unitIdx],_icon];
                _ctrlTree tvSetPictureColor [[_sideIdx, _factionIdx, _grpIdx, _unitIdx], _color];
                _ctrlTree tvSetValue [[_sideIdx, _factionIdx, _grpIdx, _unitIdx], RadioNetwork_data pushBack _x];
                
                if (_networkNumber != -1) then {
                    _ctrlTree tvSetPictureRight [[_sideIdx, _factionIdx, _grpIdx, _unitIdx], (_networkNumber+1) call TMF_common_fnc_numToTexture];
                } else {
                    _networkNumber = (_x get3DENAttribute "TMF_Network") select 0;
                    if (_networkNumber != -1) then {
                        _ctrlTree tvSetPictureRight [[_sideIdx, _factionIdx, _grpIdx, _unitIdx], (_networkNumber+1) call TMF_common_fnc_numToTexture];
                    };
                };
            } forEach (units _x);
        } forEach cacheAllPlayerGroups;
        
    };
    case "networkToggleButton": {
        with uiNamespace do {
            private _ctrl = (RadioChannels_ctrlGroup controlsGroupCtrl 1502);

            RadioCurrentNetwork = RadioCurrentNetwork + 1;
            if (RadioCurrentNetwork >= count RadioChannelArray) then {
                RadioCurrentNetwork = 0;
            };

            _ctrl ctrlSetText format["< Configure Network %1 >", (RadioCurrentNetwork+1)];
        
            ["refreshChannelList"] call RadioChannels_script;
        };
    };
    case "channelDelClick": {
        with uiNamespace do {
            if (RadioCurrentNetwork >= count RadioChannelArray) exitWith {};
            private _curSel = lnbCurSelRow (RadioChannels_ctrlGroup controlsGroupCtrl 101);
            if (_curSel == -1) exitWith {};
                                
            private _radioChannels = (RadioChannelArray select RadioCurrentNetwork) select 1;
            _radioChannels deleteAt _curSel;
            // Update all channel lists for units/groups on same preset.
            private _units = allUnits select {([_x] call TMF_acre2_fnc_unitToPreset) == 1};
            private _groups = []; {_groups pushBackUnique (group _x);} forEach _units;
            {
                private _entity = _x;
                private _list = (_entity get3DENAttribute "TMF_Channellist") params [["_value",[]]];
                if (_value isEqualType "") then {
                    _value = call compile _value;
                };
                _value = _value - [_curSel]; // Remove current channel.
                // Decrement channel numbers above.
                _value = _value apply {
                    if (_x > _curSel) then {
                        _x - 1;
                    } else {
                        _x;
                    }
                };
                _entity set3DENAttribute ["TMF_Channellist",str _value];
            } forEach (_units + _groups);
            // Cycle through groups to remove leader.
            {
                private _entity = _x;
                private _list = (_entity get3DENAttribute "TMF_ChannellistLeader") params [["_value",[]]];
                if (_value isEqualType "") then {
                    _value = call compile _value;
                };
                _value = _value - [_curSel]; // Remove current channel.
                // Decrement channel numbers above.
                _value = _value apply {
                    if (_x > _curSel) then {
                        _x - 1;
                    } else {
                        _x;
                    }
                };
                _entity set3DENAttribute ["TMF_ChannellistLeader",str _value];
            } forEach _groups;

            ["refreshChannelList"] call RadioChannels_script;
            ["save"] call RadioChannels_script;                
        };
    };
    case "channelAddClick": {
        with uiNamespace do {
            if (RadioCurrentNetwork >= count RadioChannelArray) exitWith {};
            
            {
                (RadioChannels_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (RadioChannels_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
            
            RadioChannelsEditMode = 0;
            (RadioChannels_ctrlGroup controlsGroupCtrl 313206) ctrlSetText "";
            (RadioChannels_ctrlGroup controlsGroupCtrl 313207) ctrlSetText "";
            (RadioChannels_ctrlGroup controlsGroupCtrl 313205) lbsetcursel 0;
            ctrlSetFocus (RadioChannels_ctrlGroup controlsGroupCtrl 313206);
        };
    };
    case "channelEditClick": {
        with uiNamespace do {
            if (RadioCurrentNetwork >= count RadioChannelArray) exitWith {};
            
            private _curSel = lnbCurSelRow (RadioChannels_ctrlGroup controlsGroupCtrl 101);
            if (_curSel == -1) exitWith {};
                                
            private _radioChannels = (RadioChannelArray select RadioCurrentNetwork) select 1;
            (_radioChannels select _curSel) params ["_shortName", "_longName", "_radio", "", "_shared"];
            
            {
                (RadioChannels_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (RadioChannels_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
            
            RadioChannelsEditMode = 1;
            (RadioChannels_ctrlGroup controlsGroupCtrl 313206) ctrlSetText _shortName;
            (RadioChannels_ctrlGroup controlsGroupCtrl 313207) ctrlSetText _longName;
            (RadioChannels_ctrlGroup controlsGroupCtrl 313205) lbSetCurSel (ACRE_RADIO_CLASSNAME_ARRAY find _radio);
            (RadioChannels_ctrlGroup controlsGroupCtrl 313212) cbSetChecked _shared;
            ctrlSetFocus (RadioChannels_ctrlGroup controlsGroupCtrl 313206);
        };
    };
    case "channelEditClickOkay": {
        with uiNamespace do {
            //EDIT MODE
            if (RadioChannelsEditMode == 1) then {
                private _curSel = lnbCurSelRow (RadioChannels_ctrlGroup controlsGroupCtrl 101);
                if (_curSel == -1) exitWith {};
                                    
                private _radioChannels = (RadioChannelArray select RadioCurrentNetwork) select 1;

                (_radioChannels select _curSel) set [0,ctrlText (RadioChannels_ctrlGroup controlsGroupCtrl 313206)]; // ShortName
                (_radioChannels select _curSel) set [1,ctrlText (RadioChannels_ctrlGroup controlsGroupCtrl 313207)]; // LongName
                (_radioChannels select _curSel) set [2,(ACRE_RADIO_CLASSNAME_ARRAY select (lbCurSel (RadioChannels_ctrlGroup controlsGroupCtrl 313205)))]; // Radio
                (_radioChannels select _curSel) set [4,cbChecked (RadioChannels_ctrlGroup controlsGroupCtrl 313212)]; // Shared
            } else {
                private _newChanData = [ctrlText (RadioChannels_ctrlGroup controlsGroupCtrl 313206), //Shortname
                        ctrlText (RadioChannels_ctrlGroup controlsGroupCtrl 313207), // LongGame
                        (ACRE_RADIO_CLASSNAME_ARRAY select (lbCurSel (RadioChannels_ctrlGroup controlsGroupCtrl 313205))), //Radio
                        [], //empty cond
                        cbChecked (RadioChannels_ctrlGroup controlsGroupCtrl 313212) // checked
                ];
                private _radioChannels = (RadioChannelArray select RadioCurrentNetwork) select 1;
                _radioChannels pushBack _newChanData;
            };
            
            ["refreshChannelList"] call RadioChannels_script;
            {
                (RadioChannels_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (RadioChannels_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
            ["save"] call RadioChannels_script;
        };
    };
    case "channelDelClickCancel": {
        with uiNamespace do {
            {
                (RadioChannels_ctrlGroup controlsGroupCtrl _x) ctrlShow false;
            } forEach (EDIT_CHANNEL_IDCS);
            {
                (RadioChannels_ctrlGroup controlsGroupCtrl _x) ctrlShow true;
            } forEach (BEHIND_EDIT_CHANNELS_IDCS);
        };
    };
    case "channelTreeGive": {
        with uiNamespace do {
            private _ctrlTree = (RadioChannels_ctrlGroup controlsGroupCtrl 189437);
            private _treeSel = tvCurSel _ctrlTree;
            private _entity = RadioNetworkChannel_data select (_ctrlTree tvValue _treeSel);
            
            // currentChannel
            private _curSel = lnbCurSelRow (RadioChannels_ctrlGroup controlsGroupCtrl 101);
            private _radioChannel = (((RadioChannelArray select RadioCurrentNetwork) select 1) select _curSel);
            private _condition = _radioChannel select 3;
            
            if (_entity isEqualType east or _entity isEqualType "") then {
                _condition pushBackUnique _entity;
            } else {
                if (_entity isEqualType grpNull or _entity isEqualType objNull) then {
                    _list = (_entity get3DENAttribute "TMF_Channellist") params ["_value"];
                    if (_value isEqualType []) then {
                        _entity set3DENAttribute ["TMF_Channellist",str [_curSel]];
                    } else {
                        _value = call compile _value;
                        _value pushBackUnique _curSel;
                        _entity set3DENAttribute ["TMF_Channellist",str _value];
                    };

                };
            };
            
            
            ["refreshChannelTree"] call RadioChannels_script;
            ["save"] call RadioChannels_script;
        };
    };
    case "channelTreeLeader": {
        with uiNamespace do {
            private _ctrlTree = (RadioChannels_ctrlGroup controlsGroupCtrl 189437);
            private _treeSel = tvCurSel _ctrlTree;
            private _entity = RadioNetworkChannel_data select (_ctrlTree tvValue _treeSel);
            
            // currentChannel
            private _curSel = lnbCurSelRow (RadioChannels_ctrlGroup controlsGroupCtrl 101);
            private _radioChannel = (((RadioChannelArray select RadioCurrentNetwork) select 1) select _curSel);
            private _condition = _radioChannel select 3;
            
            if (_entity isEqualType grpNull) then {
                _list = (_entity get3DENAttribute "TMF_ChannellistLeader") params ["_value"];
                if (_value isEqualType []) then {
                    _entity set3DENAttribute ["TMF_ChannellistLeader",str [_curSel]];
                } else {
                    _value = call compile _value;
                    _value pushBackUnique _curSel;
                    _entity set3DENAttribute ["TMF_ChannellistLeader",str _value];
                };
            };
            
            ["refreshChannelTree"] call RadioChannels_script;
            ["save"] call RadioChannels_script;
        };
    };
    case "channelTreeRemove": {
        with uiNamespace do {
            private _ctrlTree = (RadioChannels_ctrlGroup controlsGroupCtrl 189437);
            private _treeSel = tvCurSel _ctrlTree;
            private _entity = RadioNetworkChannel_data select (_ctrlTree tvValue _treeSel);
            
            // currentChannel
            private _curSel = lnbCurSelRow (RadioChannels_ctrlGroup controlsGroupCtrl 101);
            private _radioChannel = (((RadioChannelArray select RadioCurrentNetwork) select 1) select _curSel);
            private _condition = _radioChannel select 3;
            
            if (_entity isEqualType east or _entity isEqualType "") then {
                _radioChannel set [3,_condition - [_entity]];
                if (_entity isEqualType east) then {
                    //Find and remove matching faction groups
                    private _sideNum = _entity call TMF_common_fnc_sideToNum;
                    {
                        if (_x isEqualType "") then {
                            if (_sideNum == getNumber (configfile >> "CfgFactionClasses" >> _x >> "side")) then {
                                _radioChannel set [3,_condition - [_x]];
                            };
                        };
                    } forEach (_condition);
                
                    //remove groups
                    {
                        [_curSel, _x] call fn_removeGroupFromChannel;
                    } forEach (allGroups select {side _x == _entity});
                };
                //Also remove faction.
                if (_entity isEqualType "") then {
                    {
                        [_curSel, _x] call fn_removeGroupFromChannel;
                    } forEach (allGroups select {faction (leader _x) == _entity});
                };
            } else {
                if (_entity isEqualType grpNull) then {
                    [_curSel,_entity] call fn_removeGroupFromChannel;
                };
                if (_entity isEqualType objNull) then {
                    [_curSel,_entity] call fn_removeUnitFromChannel;
                };
            };
            
            ["refreshChannelTree"] call RadioChannels_script;
            ["save"] call RadioChannels_script;
        };
    };
    
    case "save": {
        //RadioChannelArray

        private _array = + (uiNamespace getVariable "RadioChannelArray");
        {
            private _network = _x;
            _network params ["_conditions", "_channels"];
            {
                if (_x isEqualType east) then {
                    _conditions set [_forEachIndex, (_x call TMF_common_fnc_sideToNum)];
                };
            } forEach (_conditions);
            {
                private _condition = _x select 3; // condition
                {
                    if (_x isEqualType east) then {
                        _condition set [_forEachIndex, (_x call TMF_common_fnc_sideToNum)];
                    };
                } forEach (_condition);
            } forEach (_channels);
        } forEach _array;
        
        private _string = str _array;
        
        set3DENMissionAttributes [["teamworkMissionAcreAttributes", "TMF_AcreSettings", _string]];
    };
};

//LEAVE EMPTY TO RETURN VALUE.

