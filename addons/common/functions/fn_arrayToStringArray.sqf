params ["_arr"];
private _text = "";
{
    private _t = _x;
    if(!(_t isEqualType "")) then {_t = str _x};
    if(_t != "") then {
        _t = str _t; // quote _t
        if(_forEachIndex != 0) then {
            _t = "," +  _t;
        };
        _text = _text + _t;
    };
} foreach _arr;
format["{%1}",_text];
