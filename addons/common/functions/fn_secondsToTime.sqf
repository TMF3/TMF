/// input [seconds,padding]
// when _padding is true, return value is a string!
/// output : [hours,minutes,seconds]
params ["_time",["_padding",false]];

private _hours = 0;
private _minutes = 0;
private _seconds = 0;

_hours = floor (_time / 3600);
_time = _time -  floor (_hours * 3600);
_minutes = floor (_time / 60);
_time = _time - floor (_minutes * 60);
_seconds = _time;

if(_padding) then {
    if(_hours < 10) then {_hours = format["0%1",_hours]} else {_hours = str _hours};
    if(_minutes < 10) then {_minutes = format["0%1",_minutes]} else {_minutes = str _minutes};
    if(_seconds < 10) then {_seconds = format["0%1",_seconds]} else {_seconds = str _seconds};
};

[_hours, _minutes, _seconds]