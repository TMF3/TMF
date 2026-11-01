#include "\x\tmf\addons\autotest\script_component.hpp"
[
    QGVAR(outputToRPT),
    "CHECKBOX",
    ["Write autotest results to RPT", "Also writes every autotest result to the RPT log file, not just the Eden autotest window."],
    ["TMF", "Autotest"],
    false
] call CBA_fnc_addSetting;
