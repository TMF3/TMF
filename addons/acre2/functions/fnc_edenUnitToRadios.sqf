#include "\x\tmf\addons\acre2\script_component.hpp"
/*
 * Name: TMF_acre2_fnc_edenUnitToRadios
 * Author: Snippers
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return:
 * Array of radio classnames <ARRAY>
 *
 * Description:
 * Returns the list of radios that a unit should recieve with the current settings.
 */
params[["_unit",objNull]];

// Gear assignment always runs at init, this runs after init.

private _side = _unit getVariable ["tmf_assignGear_side",-1];
private _faction = _unit getVariable ["tmf_assignGear_faction","civ_f"];
private _role =  _unit getVariable ["tmf_assignGear_role","baseMan"];

// Config look up
private _cfg = configNull;

if (_side isEqualTo -1) then {
    _cfg = missionConfigFile >> "cfgLoadouts" >> _faction;
} else {
     _side = toLower ([_side] call CFUNC(sideType));
    // OLD ASSIGN GEAR SYSTEM
    _cfg = missionConfigFile >> "cfgLoadouts" >> _side >> _faction;
};

// Faction not found in mission try in modpack.
if (!isClass _cfg) then {
    _cfg = configFile >> "cfgLoadouts" >> _faction;
};
private _radiosToGive = getArray(_cfg >> _role >> "radios");

if (isNil "_radiosToGive") then { _radiosToGive = []; };

GVAR(giveMissingRadios) = true;
if (GVAR(giveMissingRadios)) then {
    
    private _unitGroup = group _unit;

    GVAR(radioCoreSettings) = [
        // Array of Radio names, min freq, max freq, freq step, freq spacing between channels (for channel alloication
        [["ACRE_PRC343"],2400,2420,0.01,0.1,"default2"],
        [["ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F"],60,360,0.00625,1,"default"],
        [["ACRE_SEM52SL"],46,64,0.025,1,"default"],
        [["ACRE_PRC77"],30,75,0.05,10,"default"]
    ];

    // ====================================================================================
    // Determine what radio channel the unit is suppose to be on.

    // Setup the correct presets.

    private _ourPresetIndex = [_unit] call FUNC(unitToPreset);

    private _networksWithRadioChannels = getMissionConfigValue ['TMF_AcreSettings', []];
    if (_networksWithRadioChannels isEqualType "") then { _networksWithRadioChannels = call compile _networksWithRadioChannels};
    if (_ourPresetIndex != -1) then {       
        private _unitVarChannelList = (_unit get3DENAttribute "TMF_Channellist") param [0,[]];
        if (_unitVarChannelList isEqualType "") then { _unitVarChannelList = call compile _unitVarChannelList; };
        private _groupVarChannelList = (_unitGroup get3DENAttribute "TMF_Channellist") param [0,[]];
        if (_groupVarchannelList isEqualType "") then { _groupVarchannelList = call compile _groupVarchannelList; };
        private _groupVarLeaderChannelList = (_unitGroup get3DENAttribute "TMF_ChannellistLeader") param [0,[]];
        if (_groupVarLeaderChannelList isEqualType "") then { _groupVarLeaderChannelList = call compile _groupVarLeaderChannelList; };

        private _usedRadioIndexs = []; // Used for tracking colours, so that we know which ones we have already used.

        private _isGroupLeader = (leader _unitGroup == _unit);
        private _radioPresetSetting = _networksWithRadioChannels select _ourPresetIndex;
        {
            _x params ["", "", "_radio", ["_chanConditions",[]]];

            private _unitOnThisChannel = false;
            call {
                if ([_unit, _chanConditions] call EFUNC(common,evaluateCondArray)) exitWith { _unitOnThisChannel = true; };
                if (_forEachIndex in _groupVarChannelList) exitWith { _unitOnThisChannel = true; };
                if (_forEachIndex in _unitVarChannelList) exitWith { _unitOnThisChannel = true; };
                if (_isGroupLeader && {_forEachIndex in _groupVarLeaderChannelList}) exitWith { _unitOnThisChannel = true; };
            };
            if (_unitOnThisChannel) then {
                private _radioList = [_radio];
                {
                    _x params ["_innerRadioList"];
                    if (_radio in _innerRadioList) exitWith {
                        _radioList = _innerRadioList;
                    };
                } forEach GVAR(radioCoreSettings);
                
                private _radioFndIdx = -1;
                {
                    if (_radioFndIdx != -1) exitWith {};
                    private _radioID = _forEachIndex;
                    if (!(_radioID in _usedRadioIndexs)) then {
                        if (_x in _radioList) then {
                            _radioFndIdx = _radioID;
                            _usedRadioIndexs pushBack _radioID;
                        };
                    };
                } forEach _radiosToGive;
                // No matching radio - add Radio;
                if (_radioFndIdx isEqualTo -1) then {
                    _usedRadioIndexs pushBack (_radiosToGive pushBack _radio);
                };             
            };
        } forEach (_radioPresetSetting select 1); // loop through channels for the preset
    };
};

_radiosToGive;
