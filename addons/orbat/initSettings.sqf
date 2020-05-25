[
    QGVAR(markerUpdateInterval),
    "SLIDER",
    ["Marker Update Interval", "Time in seconds between marker updates, 0 for every frame. Lower values are more resource intensive."],
    ["TMF", "ORBAT"],
    [
        0,  // Min
        150,// Max
        3,  // Default
        0   // Trailing decimals
    ],
    1, // isGlobal
    {  // Script to execute when setting is changed
        if (isNil QGVAR(PFHandler)) exitWith {};

        [GVAR(PFHandler)] call CBA_fnc_removePerFrameHandler;
        GVAR(PFHandler) = [FUNC(PFHUpdate), GVAR(markerUpdateInterval), []] call CBA_fnc_addPerFrameHandler;
    }
] call CBA_fnc_addSetting;
