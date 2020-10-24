[
    QGVAR(isJIPAllowed),
    "LIST",
    ["JIP allowed", "If disallowed JIP players are placed in spectator. Only affects TMF spectator."],
    ["TMF", "Spectator"],
    [[0,1,2],["Disallow", "Allow", "During Safestart"],2],
    1
] call CBA_fnc_addSetting;
[
    QGVAR(showGroupMarkers),
    "LIST",
    ["Show 3D group markers", ""],
    ["TMF", "Spectator"],
    [[0,1],["Groups with players only", "All"], 0],
    1
] call CBA_fnc_addSetting;

[
    QGVAR(followCameraEnabled),
    "CHECKBOX",
    ["Follow camera mode enabled", "Allow the usage of the Orbiting camera mode"],
    ["TMF", "Spectator"],
    true,
    1
] call CBA_fnc_addSetting;
[
    QGVAR(freeCameraEnabled),
    "CHECKBOX",
    ["Free camera mode enabled", "Allow the usage of the free camera mode"],
    ["TMF", "Spectator"],
    true,
    1
] call CBA_fnc_addSetting;
[
    QGVAR(firstPersonCameraEnabled),
    "CHECKBOX",
    ["Firstperson camera mode enabled", "Allow the usage of the firstperson camera mode"],
    ["TMF", "Spectator"],
    true,
    1
] call CBA_fnc_addSetting;
[
    QGVAR(canSpectateAllSides),
    "CHECKBOX",
    ["Spectate all sides", "Disable to only allow the player to spectate thier own side"],
    ["TMF", "Spectator"],
    true,
    1
] call CBA_fnc_addSetting;