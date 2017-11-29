#include "\x\tmf\addons\safeStart\script_component.hpp"

disableSerialization;

private _control = uiNamespace getVariable ['TMF_safestart_text',controlNull];
_control ctrlSetText "";


0 = [_control] spawn {
    disableSerialization;
    params["_control"];
    waitUntil{!isNull player};
    private _logics = (allMissionObjects "TMF_safestart_module");
    private _allUnitLogics = _logics select {(_x getVariable ["TMFUnits",-1]) isEqualTo -1};

    if (count _allUnitLogics > 0) then {
        private _duration = (_allUnitLogics select 0) getVariable ["Duration",120];
        private _minutes = floor (_duration / 60);
        private _seconds = floor (_duration - (_minutes * 60));
        if(_minutes < 10) then {_minutes = "0"+str _minutes }  else {_minutes = str _minutes};
        if(_seconds < 10) then {_seconds = "0"+str _seconds} else {_seconds = str _seconds};

        _control ctrlSetText (format ["SAFESTART %1:%2", _minutes,_seconds]);
    } else {
        {
            private _logic = _x;
            private _appliesToMe = false;
            switch (_logic getVariable ["TMFUnits",-1]) do {
                case (0): {
                    if (player in (synchronizedObjects _logic)) then {
                        _appliesToMe = true;
                    };
                };
                case (1): {
                    {
                        if (player in (units _x)) exitWith {_appliesToMe = true;};
                    } forEach (synchronizedObjects _logic);

                };
                case (2): {
                    {
                        if (side player == (side _x)) then {_appliesToMe = true;};
                    } forEach synchronizedObjects _logic;
                };
            };
            if (_appliesToMe) exitWith {
                private _duration = _logic getVariable ["Duration",120];
                private _minutes = floor (_duration / 60);
                private _seconds = floor (_duration - (_minutes * 60));
                if(_minutes < 10) then {_minutes = "0"+str _minutes }  else {_minutes = str _minutes};
                if(_seconds < 10) then {_seconds = "0"+str _seconds} else {_seconds = str _seconds};
                _control ctrlSetText (format ["SAFESTART %1:%2", _minutes,_seconds]);
            };
        } forEach _logics;
    };  
};



