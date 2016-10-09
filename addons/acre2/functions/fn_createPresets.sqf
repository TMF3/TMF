#include "\x\tmf\addons\acre2\script_component.hpp"

private _calcChanFreq = {
    // INPUT 'RadioEntryEntry' <- from radioSettings
    // e.g. [0,1,1] call tmf_acre2_calcChanFreq
    params ["_radioSettingIndexP","_presetNum","_chanNum"];

    private _radioSettingEntry = GVAR(radioCoreSettings) select _radioSettingIndexP;
    _radioSettingEntry params["_ignore","_minFreq","_maxFreq","_channelMinSpacing","_spacingBetweenChannels"];
    
    private _randomSeed = 0;
    if (_presetNum == (count GVAR(networksWithRadioChannels))) then {
        _randomSeed = GVAR(channelFrequencyOffsets) select ((count GVAR(networksWithRadioChannels))+ _chanNum - 1);
    } else {
        _randomSeed = (GVAR(channelFrequencyOffsets) select _presetNum);
    };

    private _sizePresetBlock = (_spacingBetweenChannels / (count GVAR(networksWithRadioChannels) + 1) ); // +1 is for special channels
    private _possibleSteps = _sizePresetBlock / _channelMinSpacing; // if min spacing = 0.00625mhz, 0.25/0.00625= 40 (possible channels)
     //  below:             'random side'  OFFSET      +  'frequency split' OFFSET.
    private _offset = ((floor (_randomSeed*_possibleSteps))* _channelMinSpacing) + (_presetNum*_sizePresetBlock);

    private _frequency = _minFreq + _offset + ((_chanNum-1) * _spacingBetweenChannels);
    _frequency
};

tmf_acre2_radioBasenameToSettingsIdx = {
    params ["_radio"];

    private _fndIdx = -1;
    {
        if (_radio in (_x select 0)) exitWith {
          _fndIdx = _forEachIndex;
        };
    } forEach GVAR(radioCoreSettings);

    if (_fndIdx isEqualTo -1) then { 
        systemChat format["Warning - TMF ACRE2 Assign - GVAR(radioCoreSettings) missing radio: %1",_radio];
    };
    _fndIdx
};

//Network/Preset loop

private _sharedRadioChannelListing = [];

//TODO Preserve shared channel indexes.
{
    
    private _radioPresetChannelList = (_x select 1); //_radioPresetSetting = _x;
    private _radioPresetSettingIndex = _forEachIndex;

    ////// Bin Channels by Radio type. Create array fr the bins
    private _channelsProcessed = []; // This will store channels, binned by radio type.
    { _channelsProcessed pushBack []; } forEach GVAR(radioCoreSettings);

    //Add this entry to the channel list.
    //for "_i" from 1 to (count _radioPresetSetting)-1 do {
    {
        private _channelEntry = _x;
        private _radio = (_channelEntry select 2);
        private _coreRadioIdx = [_radio] call tmf_acre2_radioBasenameToSettingsIdx;
        if (_coreRadioIdx != -1) then {
            if (_channelEntry select 4) then { // If a shared channel
                //Ensure we having a match channel number thing.
                //Unique ID should be bound to RADIO_SHORT_NAME and the master RADIO type.
                private _sharedEntry = [_coreRadioIdx, _x select 0]; //Radio core ID + Short Channel Name.

                private _sharedIdx = _sharedRadioChannelListing find _sharedEntry;
                if (_sharedIdx == -1) then {
                    _sharedIdx = _sharedRadioChannelListing pushBack _sharedEntry;
                };
                _channelEntry pushBack _sharedIdx;
            };

            (_channelsProcessed select _coreRadioIdx) pushBack _channelEntry;
        };
    } forEach _radioPresetChannelList;


    ////// Put these processed channels into presets.
    private _presetName = format["tmf_preset%1",_radioPresetSettingIndex];
    private _frequency = 0; // Create variable for use.
    private _channelName = "";
    {
        //Create Preset.
        private _radioSettingEntry = _x;
        private _radioSettingIndex = _forEachIndex;
        private _radioList = _radioSettingEntry select 0; // RadioList
        private _channelList = (_channelsProcessed select _forEachIndex);
        // Create Presets....
        {
            private _radioName = _x;

            private _return = [_radioName, (_radioSettingEntry select 5), _presetName] call acre_api_fnc_copyPreset; // tweak
            //Preset Data doesn't exist, create fake preset.
            if (!_return) then {
                private _radioPresetData = createLocation ["AcreHashType", [-10000,-10000,-10000], 0, 0];//HASH_CREATE;
                
                _channels = [];
                for "_i" from 0 to 15 do {
                    private _channel = createLocation ["AcreHashType", [-10000,-10000,-10000], 0, 0];//;HASHLIST_CREATEHASH(_channels);
                    _channel setVariable ["frequencyTX",0];
                    _channels pushBack _channel;
                };
                _radioPresetData setVariable ["channels",_channels];
                //HASH_SET(_presetData,"channels",_channels);
                
                //might need to set channels
               [_radioName, _presetName, _radioPresetData] call acre_sys_data_fnc_registerRadioPreset;
            };

            private _channelCount = switch (_radioName) do {
                case "ACRE_PRC152": {100};
                case "ACRE_PRC148": {32};
                case "ACRE_PRC117F": {100};
                case "ACRE_PRC343": {80};
                case "ACRE_SEM52SL": {12};
                default {16};
            };
            for "_i" from 1 to _channelCount do {
                _frequency = [_radioSettingIndex,_radioPresetSettingIndex,_i] call _calcChanFreq;
                if (_i > (count _channelList)) then { 
                    _channelName = "Channel " + str(_i);
                } else {
                    _channelEntry = _channelList select (_i-1);
                    _channelName = (_channelEntry select 0);
                    if (_channelEntry select 4) then { // Check if this is a shared channel.
                        _frequency = [_radioSettingIndex, (count GVAR(networksWithRadioChannels)), (_channelEntry select 5)] call _calcChanFreq; // Use 'special preset' and 'special channel' number.
                    };
                };
                
                [_radioName, _presetName, _i, "label", _channelName] call acre_api_fnc_setPresetChannelField;
                [_radioName, _presetName, _i, "frequencyTX", _frequency] call acre_api_fnc_setPresetChannelField;
                [_radioName, _presetName, _i, "frequencyRX", _frequency] call acre_api_fnc_setPresetChannelField;
            };
        } forEach _radioList;
    } forEach GVAR(radioCoreSettings);
} forEach GVAR(networksWithRadioChannels);

tmf_acre2_networksCreated = true;