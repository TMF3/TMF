#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

[_display] call FUNC(endMission_occluder);

// Populate mission ending list
private _endingList = (_display displayCtrl IDC_TMF_ADMINMENU_ENDM_LIST);
if ((lbSize _endingList) == 0) then {
    {
        private _title = getText (_x >> "title");

        private _extra = getText (_x >> "description");
        if !(_extra isEqualTo "") then {
            _title = _title + " | " + _extra;
        };

        _extra = getText (_x >> "subtitle");
        if !(_extra isEqualTo "") then {
            _title = _title + " | " + _extra;
        };

        _endingList lbAdd _title;
        _endingList lbSetData [_forEachIndex, configName _x];
    } forEach ("true" configClasses (missionConfigFile >> "CfgDebriefing"));

    _endingList lbSetData [(_endingList lbAdd "Generic Success"), QGVAR(victory)];
    _endingList lbSetData [(_endingList lbAdd "Generic Fail"), QGVAR(defeat)];
    _endingList lbSetData [(_endingList lbAdd "Generic Draw"), QGVAR(draw)];
    _endingList lbSetData [(_endingList lbAdd "Generic Technical Issues"), QGVAR(technical_issues)];
};
