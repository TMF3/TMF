#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

TRACE_1("Initializing message log",_display);

[] call FUNC(resyncLog);

private _pfhRefresh = [{
    disableSerialization;
    params ["_display","_handle"];

    private _listCtrl = _display displayCtrl IDC_TMF_ADMINMENU_MSGS_LIST;

    private _entriesNum = lbSize _listCtrl;
    private _newEntriesNum = count GVAR(logEntries);

    for "_i" from (_entriesNum + 1) to _newEntriesNum do {

        (GVAR(logEntries) # (_i - 1)) params [
            ["_time",CBA_missionTime,[-1]],
            ["_text","",[""]],
            ["_isWarning",false,[false]]
        ];
        TRACE_3("Adding log entry",_time,_text,_isWarning);

        _text = format ["[%1]: %2", [_time,"MM:SS"] call BIS_fnc_secondsToString, _text];

        private _index = _listCtrl lbAdd _text;

        if (_isWarning) then {
            _listCtrl lbSetPictureRight [_index, QPATHTOEF(autotest,ui\warning.paa)];
        };
    };

    // Autoscroll
    private _curSel = lbCurSel _listCtrl;
    if (_curSel == -1 || (_curSel == _entriesNum -1 && _entriesNum != _newEntriesNum)) then {
        LOG("Autoscroll log");
        _listCtrl lbSetCurSel (lbSize _listCtrl - 1);
    };
},1,_display] call CBA_fnc_addPerFrameHandler;

GVAR(tabPFHHandles) pushBack _pfhRefresh;
