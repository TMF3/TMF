#include "\x\tmf\addons\safestart\script_component.hpp"
[
    QGVAR(soundEnabled),
    "CHECKBOX",
    ["Countdown sounds", "Play a beep for each of the last few seconds before safe start ends."],
    ["TMF", "Safestart"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(handleAI),
    "CHECKBOX",
    ["Freeze AI during safe start", "AI cannot take damage or engage targets until safe start ends."],
    ["TMF", "Safestart"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(triggerSound),
    "CHECKBOX",
    ["Dry-fire click", "Play a click when a player tries to shoot during safe start."],
    ["TMF", "Safestart"],
    false,
    1
] call CBA_fnc_addSetting;

[
    QGVAR(enableDefaultSS),
    "CHECKBOX",
    ["Safe start without a module", "Run safe start even when the mission has no Safe Start module, using the duration below."],
    ["TMF", "Safestart"],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(defaultSS),
    "TIME",
    ["Default safe start duration", "Used when there is no Safe Start module. 0 keeps safe start on until an admin ends it."],
    ["TMF", "Safestart"],
    [0,1800,120],
    1,
    {},
    true
] call CBA_fnc_addSetting;
