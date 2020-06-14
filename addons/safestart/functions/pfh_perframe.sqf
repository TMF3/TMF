#include "\x\tmf\addons\safeStart\script_component.hpp"

if (TIMER > 0) then {
    // Timer is counting down
    private _text = "SAFESTART " + ([TIMER - CBA_missionTime, "MM:SS"] call BIS_fnc_secondsToString);
    _textCtrl ctrlSetText _text;

    // Play ticks for the final countdown
    if (GVAR(soundEnabled) && TIMER - CBA_missionTime <= 4) then {
        playSound "FD_Timer_F";
    };
} else {
    // Timer is set to infinite
    if !(ctrlText _textCtrl isEqualTo "SAFESTART ACTIVE") then {
        _textCtrl ctrlSetText "SAFESTART ACTIVE";
    };
};
