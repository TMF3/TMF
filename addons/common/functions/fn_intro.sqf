params ["_value"];
if (_value) then {
    [{time > 5 && {player == player}},
    {[] spawn {
        if !(hasInterface) exitWith {};
        private _msg = (getPos player) call BIS_fnc_locationDescription;
        _msg = _msg + format ['<br/>%1/%2/%3', (date select 0), (date select 1), (date select 2)];
        _msg = _msg + format ['<br/>%1', ([dayTime, 'HH:MM'] call BIS_fnc_timeToString)];
        [
            _msg,
            [safezoneX + safezoneW - 0.8,0.50],
            [safezoneY + safezoneH - 0.8,0.8],
            5,
            0.5
        ] spawn BIS_fnc_dynamicText;
    };
    },nil] call CBA_fnc_waitUntilAndExecute;
};