// https://cbateam.github.io/CBA_A3/docs/files/settings/fnc_addSetting-sqf.html

[
    QGVAR(soundEnabled),
    "CHECKBOX",
    ["Enable Safestart Sounds", "Whether to make countdown sounds during the last few seconds"],
    ["TMF", "Safestart"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(handleAI),
    "CHECKBOX",
    ["Disable AI during safestart", "Whether to disable AI damage and targetting during safestart"],
    ["TMF", "Safestart"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(triggerSound),
    "CHECKBOX",
    ["Dry fire sound", "Whether to make a sound when attempting to fire while safestart is active"],
    ["TMF", "Safestart"],
    true,
    1
] call CBA_fnc_addSetting;

[
    QGVAR(enableDefaultSS),
    "CHECKBOX",
    ["Enable default safestart", "If no safestart module is placed, this will be used."],
    ["TMF", "Safestart"],
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(defaultSS),
    "TIME",
    ["Default safestart duration", "0 for infinite"],
    ["TMF", "Safestart"],
    [0,1800,120],
    1,
    {},
    true
] call CBA_fnc_addSetting;
