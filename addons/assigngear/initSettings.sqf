[
    QGVAR(loadoutUsage),
    "LIST",
    "#loadout available",
    ["TMF", "Assign Gear"],
    [
        [0,         1,                  2,                                  3       ],
        ["Never",   "During safestart", "During safestart & after respawn", "Always"],
        0
    ], // default value
    1 // isGlobal
] call CBA_fnc_addSetting;
