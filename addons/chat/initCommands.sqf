[ // Reset Position
    "rp",
    FUNC(cmndRP),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Teleport
    "tp",
    FUNC(cmndTp),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Spectate
    "spec",
    FUNC(cmndSpec),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Whisper
    "whisper",
    FUNC(cmndWhisper),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Heal
    "heal",
    FUNC(cmndHeal),
    "all"
] call CBA_fnc_registerChatCommand;

if (isClass (configFile >> "CfgPatches" >> QUOTE(DOUBLES(PREFIX,assignGear)))) then {
    [ // Assign loadout
        "loadout",
        FUNC(cmndLoadout),
        "all"
    ] call CBA_fnc_registerChatCommand;
};

if (isClass (configFile >> "CfgPatches" >> QUOTE(DOUBLES(PREFIX,acre2)))) then {
    [ // Assign radio
        "radio",
        FUNC(cmndRadio),
        "all"
    ] call CBA_fnc_registerChatCommand;
};

