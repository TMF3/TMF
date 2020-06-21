[
    QGVAR(printToChat),
    "LIST",
    ["Print log messages to chat", "Whether to print logged messages to chat. Only visible for admins."],
    ["TMF", "Adminmenu"],
    [[2,1,0],["All Messages", "Only Warnings", "None"],0]
] call CBA_fnc_addSetting;
