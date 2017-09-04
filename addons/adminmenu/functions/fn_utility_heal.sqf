#include "\x\tmf\addons\adminmenu\script_component.hpp"

if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
    {
        if (local _x) then {
            ["ace_medical_treatmentAdvanced_fullHealLocal", [player, _x]] call CBA_fnc_localEvent;
            systemChat "[TMF Admin Menu] Your health was restored";
        } else {
            ["ace_medical_treatmentAdvanced_fullHealLocal", [player, _x], _x] call CBA_fnc_targetEvent;
            (format ["[TMF Admin Menu] Your health was restored by '%1'", profileName]) remoteExec ["systemChat", _x];
        };
    } forEach GVAR(utilityData);
} else {
    {
        _x setDamage 0;
    } forEach GVAR(utilityData);
};

systemChat format ["[TMF Admin Menu] %1 players had their health restored", count GVAR(utilityData)];
