[
    "TMF",
    QGVAR(openKey),
    ["Open Admin Menu", "Only available for admins and in singleplayer"],
    FUNC(keyPressed),
    {false},
    [59,
    [true, false, false]],
    false,
    0
] call CBA_fnc_addKeybind; // Shift + F1
[
    "TMF",
    QGVAR(spectatorRemoteControl),
    ["Control Focused Spectator Unit", "Only available in TMF Spectator, and only for admins and in singleplayer"],
    FUNC(keyPressed),
    {false},
    [0, [false, false, false]],
    false,
    0
] call CBA_fnc_addKeybind; // No default bind


[QEGVAR(spectator,keyDown), {
    params ["", "_args"];
    _args call FUNC(keyPressed);
}] call CBA_fnc_addEventHandler;
