#include "\x\tmf\addons\acre2\script_component.hpp"
// if dead, set spectator and exit
//Wait till is not null

if (!hasInterface) exitWith {};


if(!alive player) exitWith {[true] call acre_api_fnc_setSpectator;};


[{
    [_this select 1] call CBA_fnc_removePerFrameHandler;
    private _unit = player;
    // ====================================================================================
    // Init briefing text.

    private _ltext = "<font size='11'>Legend: <font color='#ff4747'>*</font> is used to denote a channel you are suppose to be on.<br/>The colours are used to match your radios with channels (your radios will be set to these channels), white radios will remain on channel 1.<br/>I can speak any languages that are <font color='#ff4747'>highlighted</font>.</font><br/><br/>";


    // ====================================================================================
    // Set language of the units depending on side (BABEL API)

    //Global Cond
    private _languagesToSpeak = [];
    private _unitGroup = group _unit;
    if (getMissionConfigValue ['TMF_AcreBabelEnabled',false]) then {
        //Determine which languages we should speak
        //Check Side/Faction conditions
        {
            _x params ["","_conditions"];
            private _langIdx = _forEachIndex;
            if ([_unit, _conditions] call EFUNC(common,evaluateCondArray)) then {
                _languagesToSpeak pushBack (format["tw_lang%1", _langIdx]);
            };
        } forEach TMF_BabelArray;

        //Check group/unit conditions
        private _groupCond = _unitGroup getVariable ["TMF_BabelLanguages", []];
        if (_groupCond isEqualType "") then { _groupCond = call compile _groupCond; };
        private _unitCond = _unit getVariable ["TMF_BabelLanguages", []];
        if (_unitCond isEqualType "") then { _unitCond = call compile _unitCond; };

        {
            private _langId = format["tw_lang%1", _x];
            _languagesToSpeak pushBackUnique _langId;
        } forEach (_groupCond + _unitCond);


        //Call ACRE API
        if (count _languagesToSpeak > 0) then {
            _languagesToSpeak call acre_api_fnc_babelSetSpokenLanguages;
            [_languagesToSpeak select 0] call acre_api_fnc_babelSetSpeakingLanguage;
        };

        //Babel Briefing
        _ltext = _ltext + "<font size='16'>BABEL - LANGUAGES</font><br/>Languages spoken in this area:<br/>";
        {
            _x params ["_langKey", "_langName"];
            if (_forEachIndex != 0) then {_ltext = _ltext + ", "; };
            if (_langKey in _languagesToSpeak) then {
              _ltext = _ltext + format["<font color='#ff4747'>%1</font>", _langName];
            } else {
              _ltext = _ltext + _langName;
            };
        } forEach GVAR(languagesTable);

    };

    //If Radio system disabled but babel is, create the briefing page anyway.
    if (!getMissionConfigValue ['TMF_AcreNetworkEnabled',false]) exitWith {
        if (getMissionConfigValue ['TMF_AcreBabelEnabled',false]) then {
            player createDiaryRecord ["diary", ["ACRE2", _ltext]]; 
        };
    };

    // ====================================================================================
    // Determine what radio channel the unit is suppose to be on.


    // Setup the correct presets.

    private _ourPresetIndex = -1;

    private _channelsProcessed = []; // This will store channels, binned by radio type.
    { _channelsProcessed pushBack []; } forEach GVAR(radioCoreSettings);
    private _presetName = "default";

    private _unitVarChannelList = _unit getVariable ["TMF_Channellist", []];
    if (_unitVarChannelList isEqualType "") then { _unitVarChannelList = call compile _unitVarChannelList; };
    private _groupVarChannelList = _unitGroup getVariable ["TMF_Channellist", []];
    if (_groupVarchannelList isEqualType "") then { _groupVarchannelList = call compile _groupVarchannelList; };
    private _groupVarLeaderChannelList = _unitGroup getVariable ["TMF_ChannellistLeader", []];
    if (_groupVarLeaderChannelList isEqualType "") then { _groupVarLeaderChannelList = call compile _groupVarLeaderChannelList; };

    private _isGroupLeader = (leader _unitGroup == _unit);
    {
        private _radioPresetSetting = _x;
        private _radioPresetIdx = _forEachIndex;
        _radioPresetSetting params ["_conditions"];
        private _passes = [_unit, _conditions] call EFUNC(common,evaluateCondArray);

        private _groupCond = _unitGroup getVariable ["TMF_Network",-1];
        if (_groupCond == _radioPresetIdx) then { _passes = true; };
        private _unitCond = _unit getVariable ["TMF_Network",-1];
        if (_unitCond == _radioPresetIdx) then { _passes = true; };

        if (_passes) exitWith {
            //uses these presets.
            _ourPresetIndex = _radioPresetIdx;

            _presetName = format["tmf_preset%1",_ourPresetIndex];
            {
                _x params ["_radioList"];
                { [_x, _presetName] call acre_api_fnc_setPreset; } forEach (_radioList);
            } forEach GVAR(radioCoreSettings);

            {
                _x params ["", "", "_radio", ["_chanConditions",[]]];

                private _unitOnThisChannel = false;
                call {
                    if ([_unit, _chanConditions] call EFUNC(common,evaluateCondArray)) exitWith { _unitOnThisChannel = true; };
                    if (_forEachIndex in _groupVarChannelList) exitWith { _unitOnThisChannel = true; };
                    if (_forEachIndex in _unitVarChannelList) exitWith { _unitOnThisChannel = true; };
                    if (_isGroupLeader && {_forEachIndex in _groupVarLeaderChannelList}) exitWith { _unitOnThisChannel = true; };
                };
                (_channelsProcessed select ([_radio] call tmf_acre2_radioBasenameToSettingsIdx)) pushBack (_x + [_unitOnThisChannel]);    
            } forEach ((_radioPresetSetting select 1)); // loop through channels for the preset
        };
    } forEach GVAR(networksWithRadioChannels);
    if (_ourPresetIndex == -1) then { systemChat "[Warning] TMF-ACRE no preset assigned for myself"; };


    // ====================================================================================
    // Start PFH to cause delay so vars are set.

    
    // Gear assignment always runs at init, this runs after init.
 
    private _side = toLower ([(_unit getVariable ["tmf_assignGear_side",3])] call CFUNC(sideType));
    private _radiosToGive = ["CfgLoadouts", _side, _unit getVariable ["tmf_assignGear_faction","civ_f"], _unit getVariable ["tmf_assignGear_role","baseMan"], "radios"] call EFUNC(common,getCfgEntry);

    if (isNil "_radiosToGive") then { _radiosToGive = []; };
    //CfgLoadouts >> WEST >> BLU_F >> KIT
   //  test = [_side, player getVariable ["tmf_assignGear_faction","civ_f"], player getVariable ["tmf_assignGear_role","baseMan"], "radios"]  call tmf_common_fnc_getCfgEntry;
    //test = [_side, player getVariable ["tmf_assignGear_faction","civ_f"], player getVariable ["tmf_assignGear_role","baseMan"], "radios"]  call tmf_common_fnc_getCfgEntry;
    
    // CONSTRUCT BRIEFING AND MATCH THE RADIO CHANNELS TO RADIOS, SO LATER WE CAN SET THEM ON THE MATCHE CHANNELS.

    private _assignedRadioChannels = []; { _assignedRadioChannels pushBack [_x,-1]; } forEach _radiosToGive; // 'ClassName','Chan num'
    private _usedRadioIndexs = []; // Used for tracking colours, so that we know which ones we have already used.



    private _text = "<br/><font size='16'>RADIO CHANNEL LISTING</font>";
    {
        private _radioSettingsIndex = _forEachIndex;
        if (count (_channelsProcessed select _radioSettingsIndex) > 0) then { // If at least one channel is defined.
            _text = _text + "<br/>For: ";
            _radioFreqInfo = _x;
            _radioList = _radioFreqInfo select 0;
            _radio = (_radioList select 0);
            {
                if (_forEachIndex != 0) then {_text = _text + ", "; };
                _text = _text + getText (configfile >> "CfgWeapons" >> _x >> "displayName");
            } forEach _radioList;
            _text = _text + ":<br/>";                

            {
                private _chanNum = _forEachIndex +1;
                private _frequency = [_radio, _presetName, _chanNum, "frequencyTX"] call acre_api_fnc_getPresetChannelField;
                if (_frequency >= 1000) then { 
                    _frequency = [_frequency, 4,3] call CBA_fnc_formatNumber;  
                } else {
                    if (_frequency < 100) then {
                        _frequency = format[" %1",[_frequency, 2,5] call CBA_fnc_formatNumber];  
                    } else {
                        _frequency = [_frequency, 3,5] call CBA_fnc_formatNumber; 
                    };
                };
                private _channelLine = format["CHN %1 (%2 MHz) - %3 - %4",_chanNum,_frequency,(_x select 0),(_x select 1)];
                _defaultRadio = (_x select 2);
                if (_x select ((count _x) -1 )) then { // if player is supposet to be on this channel
                    // Match radio to number...
                    private _radioFndIdx = -1;
                    {
                        if (_radioFndIdx != -1) exitWith {};
                        _radioID = _forEachIndex;
                        if (!(_radioID in _usedRadioIndexs)) then {
                            if (_x in _radioList) then {
                                _radioFndIdx = _radioID;
                                _usedRadioIndexs pushBack _radioID;
                                (_assignedRadioChannels select _radioFndIdx) set [1,_chanNum];
                            };
                        };
                    } forEach _radiosToGive;
                    // Give missing radio?
                    if ((_radioFndIdx isEqualTo -1) && GVAR(giveMissingRadios)) then {
                        _radiosToGive pushBack _defaultRadio;
                        _assignedRadioChannels pushBack [_defaultRadio,_chanNum];
                        _radioFndIdx = (count _radiosToGive)-1;
                        _usedRadioIndexs pushBack _radioFndIdx;
                    };
                    private _color = [_radioFndIdx] call EFUNC(common,numToColor);
                    _channelLine = " <font color='#ff4747'>*</font> " + format["<font color='%1'>",_color] + _channelLine + "</font><br/>";  
                } else {
                    _channelLine = "   " +_channelLine + "<br/>";
                };
                _text = _text + _channelLine;
            } forEach (_channelsProcessed select _radioSettingsIndex);
        };
    } forEach GVAR(radioCoreSettings);

    private _myRadiosText = "<br/><br/><font size='16'>MY ASSIGNED RADIOS</font><br/>";
    {
        _color = [_forEachIndex] call EFUNC(common,numToColor);
        _myRadiosText = _myRadiosText + format["<font color='%1'>%2</font><br/>",_color,getText (configfile >> "CfgWeapons" >> _x >> "displayName")];
    } forEach _radiosToGive;

    _text = _ltext + _myRadiosText + _text;

    //Provide instructions on the page. such as * to denote a channel you are suppose to be on, explain what the colours mean.
    player createDiaryRecord ["diary", ["ACRE2", _text]];    

    // ====================================================================================
    // Give radios and set the channels accordingly
    // Uses CBA PFH to have a delay yet ensure code is still run in the unscheduled enviornment.
    [{
        params ["_params"];
        _params params ["_unit","_radiosToGive", "_assignedRadioChannels"];

        // Wait for existing rasRemove already initalized radios.
        if ("ItemRadio" in (items _unit + assignedItems _unit)) exitWith {};
        if (!([] call acre_api_fnc_isInitialized)) exitWith {};	

        {_unit removeItem _x;} forEach ([] call acre_api_fnc_getCurrentRadioList);


        // Allocate new radios.
        {	
            if (_unit canAdd _x) then {
                _unit addItem _x;
            } else {
                //Backpacks can be statics/not accept cargo. Though let us try.
                //TODO: Nick help me see if we can make this work. Seems over-ride doesn't work early.

                private _added = false;
                /*if (backpack _unit != "") then {
                    if (getNumber( configFile >> "CfgVehicles" >> (backpack _unit) >> "maximumLoad") > 0) then {
                        (unitBackpack _unit) addItemCargoGlobal [_x, 1];
                        _added = true;
                    };
                };*/			

                if (!_added) then {
                    [_x] spawn {
                        waitUntil{time>3};
                        systemChat format["[TMF ACRE2] Warning: No room to add radio '%1', report this to the mission maker. You now have an addaction to add the radio.",_this select 0];
                    };

                    //Create addAction to give radio.
                    private _radioName = getText (configfile >> "CfgWeapons" >> _x >> "displayName");
                    private _actionID = _unit addAction [format ["<t color='#3375D6'>[Radios] Give myself a %1 radio</t>",_radioName],
                     {
                         _radioToGive = (_this select 3) select 0;
                         _unit = (_this select 0),
                         if (_unit canAdd _radioToGive) then {
                            _unit addItem _radioToGive;
                            _unit removeAction (_this select 2);
                         } else {
                            systemChat format["[TMF ACRE2] Warning: No room to add radio '%1', remove more stuff and try again",_radioToGive];
                         };
                     }
                     ,[_x],0,false,false,"","(_target == _this)"];
                    [_actionID,_unit] spawn {
                        sleep 300;
                        if (!isNull (_this select 1)) then {
                            (_this select 1) removeAction (_this select 0);
                        };
                    };
                };
            };
        } forEach _radiosToGive;

        // Setup Radio channels properly and provide the addActions.
        [{
            if (!([] call acre_api_fnc_isInitialized)) exitWith {};
            params ["_params"];

            _params params ["_unit", "_assignedRadioChannels"];

            private _usedRadioIndexs = [];
            private _radioList = [] call acre_api_fnc_getCurrentRadioList;
            {
                private _radioName = _x;
                private _baseRadio = [_x] call acre_api_fnc_getBaseRadio;
                {
                    _x params ["_xBaseRadio", "_chanNum"];
                    if (!(_forEachIndex in _usedRadioIndexs)) then {
                        if (_baseRadio == _xBaseRadio) then {
                            if (_chanNum != -1 && _baseRadio != "ACRE_PRC77") then {
                                [_radioName, _chanNum] call acre_api_fnc_setRadioChannel;
                            };
                            _usedRadioIndexs pushBack _forEachIndex;
                        };
                    };
                } forEach (_assignedRadioChannels);
            } forEach _radioList;


            // Give addActions to addRadios.
            if (!isNil QGVAR(radioAddActions)) then {
                {
                    private _actionid_action = _unit addAction [format["<t color='#c3d633'>[Radios] Give myself a %1 radio (check your inventory for space)</t>",getText (configfile >> "CfgWeapons" >> _x >> "displayName")], 
                                                        format["if ((_this select 0) canAdd '%1') then { (_this select 0) addItem '%1'; (_this select 0) removeAction (_this select 2); } else { systemChat '[TMF ACRE2] No space for radios'; };",_x],0,0,false,true,"","(_target == _this)"];
                    [_actionid_action,_unit] spawn {
                        sleep 300;
                        if (!isNull (_this select 1)) then {
                            (_this select 1) removeAction (_this select 0);
                        };
                    };
                } forEach GVAR(radioAddActions);
            };


            [_this select 1] call CBA_fnc_removePerFrameHandler;
        }, 0.4,[_unit, _assignedRadioChannels]] call CBA_fnc_addPerFrameHandler;


        [_this select 1] call CBA_fnc_removePerFrameHandler;
    }, 0.5,[_unit,_radiosToGive, _assignedRadioChannels]] call CBA_fnc_addPerFrameHandler;



}, 0.01,[]] call CBA_fnc_addPerFrameHandler;
