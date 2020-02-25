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

[ // Heal
    "stage",
    FUNC(cmndStage),
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
