#include "\x\tmf\addons\autotest\script_component.hpp"
[
    QGVAR(outputToRPT),
    "CHECKBOX",
    ["Output Autotest Results to RPT","Logs all autotest results to the RPT file/"],
    ["TMF", "Autotest"],
    false
] call CBA_fnc_addSetting;
