#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

[_display] call FUNC(endMissionOccluder);




// rewrite dis




// Populate mission ending list
private _endingList = (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_LIST);
if ((lbSize _endingList) > 0) exitWith {};

{
    private _title = getText (_x >> "title");
    private _description = getText (_x >> "description");

    if (!isText (_x >> "subtitle")) then {
        if (_description isEqualTo "") then {
            _endingList lbAdd format ["%1", _title];
        } else {
            _endingList lbAdd format ["%1 | %2", _title, _description];
        };
    } else {
        private _subtitle = getText (_x >> "subtitle");

        if (_description isEqualTo "") then {
            _endingList lbAdd format ["%1 | %2", _title, _subtitle];
        } else {
            _endingList lbAdd format ["%1 | %2 | %3", _title, _subtitle, _description];
        };
    };

    _endingList lbSetData [_forEachIndex, configName _x];
} forEach ("true" configClasses (missionConfigFile >> "CfgDebriefing"));

/*private _idx = _endingList lbAdd "Generic Victory";
_endingList lbSetData [_idx, "victory"];
_idx = _endingList lbAdd "Generic Defeat";
_endingList lbSetData [_idx, "defeat"];*/


// Set per-side toolboxes
/*{
    if (isNil _x) then {
        missionNamespace setVariable [_x, 0];
    };
} forEach [QGVAR(endingSideBlufor), QGVAR(endingSideOpfor), QGVAR(endingSideIndependent), QGVAR(endingSideCivilian)];*/
