if (isClass (configFile >> "CfgPatches" >> "ace_safemode")) then {
    [
        QGVAR(weaponSafety),
        "CHECKBOX",
        "Enable ACE Weapon Safety on mission start",
        ["TMF", "Common"],
        true,
        0,
        {},
        true
    ] call CBA_fnc_addSetting;
};
[
    QGVAR(slottingNames),
    "CHECKBOX",
    ["Legacy Group Names in Lobby", "Use CBA system instead. Format: Role@Groupname"],
    ["TMF", "Common"],
    profileNamespace getVariable [QGVAR(slottingNames),false], // Store from last session
    0,
    {
        profileNamespace setVariable [QGVAR(slottingNames),_this];
    },
    true
] call CBA_fnc_addSetting;
