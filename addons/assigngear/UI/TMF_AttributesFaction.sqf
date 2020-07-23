#define DEBUG_MODE_FULL
#include "..\script_component.hpp"

disableSerialization;

params ["_mode","_params","_class"];
_params params ["_ctrl","_config"];
TRACE_3("Loading AIGear Faction Attribute",_mode,_params,_class);

switch (_mode) do {
    case "onLoad": {
        private _ctrlCombo = _ctrl controlsGroupCtrl 100;

        private _factionClasses = uiNamespace getVariable [QGVAR(factions),[]];
        if (_factionClasses isEqualTo []) then {
            LOG("AIGear factionClasses not cached");
            // Cache to uiNamespace
            _factionClasses = "isNumber (_x >> 'side') && getNumber (_x >> 'side') in [0,1,2,3]" configClasses (configFile >> 'CfgFactionClasses');

            // Filter to only factions that have units
            _factionClasses = _factionClasses select {
                private _cfgName = configName _x;
                private _men = "configName _x isKindOf 'CAManBase'" configClasses (configFile >> "CfgVehicles");
                (_men findIf {getText (_x >> "faction") == _cfgName}) != -1;
            };

            _factionClasses = _factionClasses apply {[
                configName _x,
                getText (_x >> 'displayName') + [" [OPF]", " [BLU]", " [IND]", " [CIV]"] # getNumber (_x >> "side"),
                getText (_x >> 'icon')
            ]};
            uiNamespace setVariable [QGVAR(factions),_factionClasses];
            LOG_1("AIGear factionClasses cached to uiNamespace: %1",_factionClasses);
        };


        {
            _x params ['_data','_displayName','_icon'];
            TRACE_3("AIGear Adding to faction combo",_data,_displayName,_icon);
            private _id = _ctrlCombo lbAdd _displayName;
            _ctrlCombo lbSetData [_id,_data];
            _ctrlCombo lbSetPictureRight [_id,_icon];
        } forEach _factionClasses;
        lbSort _ctrlCombo;
    };
    case "onUnload": {

    };
};


