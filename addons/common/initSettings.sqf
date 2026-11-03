#include "\x\tmf\addons\common\script_component.hpp"
if (isClass (configFile >> "CfgPatches" >> "ace_safemode")) then {
    [
        QGVAR(weaponSafety),
        "CHECKBOX",
        ["Weapons on safe at mission start", "Players start the mission with ACE weapon safety on. Requires ACE."],
        ["TMF", "Common"],
        true,
        0,
        {},
        true
    ] call CBA_fnc_addSetting;
};
