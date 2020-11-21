#include "\x\tmf\addons\acre2\script_component.hpp"

//TODO: Enforce better table cleanup (On ADD) in the GUI control
//  - For un-used networks...
//  - When adding from the tree... so that unit/group attrs are correct. Or switch condition to check side/faction/group/unit exhuastively?

GVAR(languagesTable) = [];
//Parse Babel

if (getMissionConfigValue ['TMF_AcreBabelEnabled',false]) then {
    TMF_BabelArray = getMissionConfigValue ["TMF_AcreBabelSettings",[]];
    if (TMF_BabelArray isEqualType "") then { TMF_BabelArray = call compile TMF_BabelArray; };
    {
        _x params ["_langName"];
        private _langId = format["tw_lang%1", _forEachIndex];
        private _entry = [_langId, _langName];
        GVAR(languagesTable) pushBack _entry;
        _entry call acre_api_fnc_babelAddLanguageType;
    } forEach (TMF_BabelArray);
};

/// Parse Radios
private _tmfNetworkEnabled = (getMissionConfigValue ['TMF_AcreNetworkEnabled',false]);
if (_tmfNetworkEnabled) then {
    if (isNil QGVAR(radioCoreSettings)) then {
        GVAR(radioCoreSettings) = [
            // Array of Radio names, min freq, max freq, freq step, freq spacing between channels (for channel alloication
            [["ACRE_PRC343"],2400,2420,0.01,0.1,"default2"],
            [["ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F"],60,360,0.00625,1,"default"],
            [["ACRE_SEM52SL"],46,64,0.025,1,"default"],
            [["ACRE_PRC77"],30,75,0.05,10,"default"]
        ];
    };


    GVAR(radioAddActions) = getMissionConfigValue ['TMF_AcreAddRadioActions', []];
    if (GVAR(radioAddActions) isEqualType "") then { GVAR(radioAddActions) = call compile GVAR(radioAddActions)};
    GVAR(networksWithRadioChannels) = getMissionConfigValue ['TMF_AcreSettings', []];
    if (GVAR(networksWithRadioChannels) isEqualType "") then { GVAR(networksWithRadioChannels) = call compile GVAR(networksWithRadioChannels)};
    if (isServer) then {
        GVAR(channelFrequencyOffsets) = [];

        if (!isNil QGVAR(networksWithRadioChannels)) then {
            private _sharedRadioChannelListing = [];
            {
                GVAR(channelFrequencyOffsets) pushBack (random 1);

                //Loop through the channels and find the shared channels so they also have randomized freqs.
                _x params ["", "_channels"];
                {
                    _x params ["_shortName", "", "_radio", "", "_shared"];
                    if (_shared) then { // is special channel
                        private _coreRadioIdx = GVAR(radioCoreSettings) findIf {_radio in (_x select 0)};

                        private _sharedEntry = [_coreRadioIdx, _shortName]; //Radio core ID + Short Channel Name.
                        //TODO ensure this works.
                        private _sharedIdx = _sharedRadioChannelListing find _sharedEntry;
                        if (_sharedIdx == -1) then {
                            GVAR(channelFrequencyOffsets) pushBack (random 1); // add default channel split
                            _sharedIdx = _sharedRadioChannelListing pushBack _sharedEntry;
                        };
                    }
                } forEach _channels;
            } forEach GVAR(networksWithRadioChannels);
        };

        publicVariable QGVAR(channelFrequencyOffsets);
    };

    GVAR(giveMissingRadios) = true;

    [{!isNil QGVAR(channelFrequencyOffsets)},{
        [] call FUNC(createPresets);
    }] call CBA_fnc_waitUntilAndExecute;

};


if (hasInterface) then {
    // Set up god mode
    if GVAR(godmodeEnabled) then {
        ["Admins", 0] call acre_api_fnc_godModeNameGroup;
        ["Spectators", 1] call acre_api_fnc_godModeNameGroup;
        ["Curators", 2] call acre_api_fnc_godModeNameGroup;

        private _canBroadcast = [player, "acreBroadcast"] call EFUNC(adminMenu,isAuthorized);
        private _canGroupChat = [player, "acreGroupChat"] call EFUNC(adminMenu,isAuthorized);

        TRACE_3("Initializing god mode",getPlayerUID player,_canBroadcast,_canGroupChat);
        [_canBroadcast, _canGroupChat] call acre_api_fnc_godModeConfigureAccess;

        if _canGroupChat then {
            [getPlayerUID player, 0, 1] remoteExecCall ["acre_api_fnc_godModeModifyGroup", 0, true];
        };
        [{
            allPlayers select {_x isKindOf QEGVAR(spectator,unit) || {[_x] call acre_api_fnc_isSpectator}}
        }, 1, 0] call acre_api_fnc_godModeModifyGroup;
        [{[] call BIS_fnc_listCuratorPlayers}, 2, 0] call acre_api_fnc_godModeModifyGroup;
    };

    // Handle VarSync
    [{
        if (isNull player) exitWith {};
        params ["_tmfNetworkEnabled"];
        if (_tmfNetworkEnabled && isNil "tmf_acre2_networksCreated") exitWith {}; //Ensure presets are created
        if (isNil QEGVAR(common,VarSync)) exitWith {}; // Ensure vars are recieved.

        [] call FUNC(clientInit);
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    }, 1,_tmfNetworkEnabled] call CBA_fnc_addPerFrameHandler;

    // Spectator for showing/hiding radio UI.
    [QEGVAR(spectator,toggleUI), {
        disableSerialization;
        params ["_show", "_display"];

        private _control = _display displayCtrl SPECTATOR_IDC_RADIO_INFO;

        if (_show && missionNamespace getVariable [QGVAR(showSpectatorRadios), false]) then {
            _control ctrlShow true;
        } else {
            _control ctrlShow false;
        }
    }] call CBA_fnc_addEventHandler;

    [QEGVAR(spectator,radioButtonPressed), {
        disableSerialization;
        private _display = uiNamespace getVariable [QEGVAR(spectator,display), displayNull];
        private _showRadio = missionNamespace getVariable [QGVAR(showSpectatorRadios), false];
        private _show = EGVAR(spectator,showUI);
        missionNamespace setVariable [QGVAR(showSpectatorRadios), !_showRadio];

        private _control = _display displayCtrl SPECTATOR_IDC_RADIO_INFO;

        if (_show && missionNamespace getVariable [QGVAR(showSpectatorRadios), false]) then {
            _control ctrlShow true;
        } else {
            _control ctrlShow false;
        }
    }] call CBA_fnc_addEventHandler;

    [QEGVAR(spectator,displayOnLoad), {
        disableSerialization;
        params ["_display"];

        [
            _display,
            {
                // Return target unit.
                missionNamespace getVariable [QEGVAR(spectator,target), objNull];
            },
            {missionNamespace getVariable [QEGVAR(spectator,showUI), false] && {missionNamespace getVariable [QGVAR(showSpectatorRadios), false]}}
        ] call acre_sys_spectator_fnc_initDisplay;

        private _control = _display displayCtrl SPECTATOR_IDC_RADIO_INFO;
        private _show = EGVAR(spectator,showUI);
        if (_show && missionNamespace getVariable [QGVAR(showSpectatorRadios), false]) then {
            _control ctrlShow true;
        } else {
            _control ctrlShow false;
        }
    }] call CBA_fnc_addEventHandler;
};
