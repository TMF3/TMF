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