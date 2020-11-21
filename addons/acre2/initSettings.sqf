[
    QGVAR(godmodeEnabled),
    "CHECKBOX",
    ["Handle God Mode", "Whether TMF should handle ACRE God Mode configuration. \nDefault Configuration: \n- Group 1: Admins \n- Group 2: Spectators \n- Group 3: Curators\nSee ACRE wiki for more info on God Mode."],
    ["TMF", "ACRE2"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;
