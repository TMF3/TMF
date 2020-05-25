[
    QGVAR(markerUpdateInterval),
    "SLIDER",
    ["Marker Update Interval", "Time in seconds between marker updates, 0 for every frame. Lower values are more resource intensive."],
    ["TMF", "ORBAT"],
    [
        0,  // Min
        150,// Max
        3,  // Default
        1   // Trailing decimals
    ],
    1, // isGlobal
    {[_this] call FUNC(setmarkerUpdateInterval)}
] call CBA_fnc_addSetting;
