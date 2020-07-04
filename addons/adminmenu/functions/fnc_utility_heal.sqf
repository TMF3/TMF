#include "\x\tmf\addons\adminmenu\script_component.hpp"

if (!isNil "ace_medical_treatment_fnc_fullHeal") then {
    {
        [player, _x] call ace_medical_treatment_fnc_fullHeal;
        (format ["[TMF Admin Menu] Your health was restored by '%1'", profileName]) remoteExec ["systemChat", _x];
    } forEach GVAR(utilityData);
} else {
    {
        _x setDamage 0;
    } forEach GVAR(utilityData);
};

systemChat format ["[TMF Admin Menu] %1 players had their health restored", count GVAR(utilityData)];

[["%1 Restored health on %2",profileName,GVAR(utilityData) apply {name _x}],false,"Admin Menu"] call FUNC(log);
