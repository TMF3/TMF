#include "\x\tmf\addons\chat\script_component.hpp"
[
    QGVAR(healUsage),
    "LIST",
    ["#heal command", "When players may use #heal in chat to heal themselves or another player. Admins can always use it."],
    ["TMF", "Chat Commands"],
    [
        [0,         1,                  3       ],
        ["Never",   "During safe start", "Always"],
        0
    ], // default value
    1 // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(rpUsage),
    "LIST",
    ["#rp command", "When players may use #rp in chat to move to a free spot nearby when they are stuck. Admins can always use it."],
    ["TMF", "Chat Commands"],
    [
        [0,         1,                  3       ],
        ["Never",   "During safe start", "Always"],
        0
    ], // default value
    1 // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(tpUsage),
    "LIST",
    ["#tp command", "When players may use #tp in chat to teleport to another player or group. Admins can always use it."],
    ["TMF", "Chat Commands"],
    [
        [0,         1,                  2,                                  3       ],
        ["Never",   "During safe start", "During safe start and 5 min after respawn", "Always"],
        0
    ], // default value
    1 // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(whisperUsage),
    "LIST",
    ["#whisper command", "Whether players may use #whisper in chat to send a private message to another player."],
    ["TMF", "Chat Commands"],
    [
        [0,       3       ],
        ["Never", "Always"],
        0
    ], // default value
    1 // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(specUsage),
    "LIST",
    ["#spec command", "When players may use #spec in chat to enter spectator. Admins can always use it."],
    ["TMF", "Chat Commands"],
    [
        [0,         1,                  2,                                  3       ],
        ["Never",   "During safe start", "During safe start and 5 min after respawn", "Always"],
        0
    ], // default value
    1 // isGlobal
] call CBA_fnc_addSetting;

if (isClass (configFile >> "CfgPatches" >> QUOTE(DOUBLES(PREFIX,assignGear)))) then {
    [
        QGVAR(loadoutUsage),
        "LIST",
        ["#loadout command", "When players may use #loadout in chat to change or copy their loadout. Admins can always use it."],
        ["TMF", "Chat Commands"],
        [
            [0,         1,                  2,                                  3       ],
            ["Never",   "During safe start", "During safe start and 5 min after respawn", "Always"],
            0
        ], // default value
        1 // isGlobal
    ] call CBA_fnc_addSetting;
};

if (isClass (configFile >> "CfgPatches" >> QUOTE(DOUBLES(PREFIX,acre2)))) then {
    [
        QGVAR(radioUsage),
        "LIST",
        ["#radio command", "When players may use #radio in chat to give themselves an ACRE2 radio. Admins can always use it."],
        ["TMF", "Chat Commands"],
        [
            [0,         1,                  2,                                  3       ],
            ["Never",   "During safe start", "During safe start and 5 min after respawn", "Always"],
            0
        ], // default value
        1 // isGlobal
    ] call CBA_fnc_addSetting;
};
