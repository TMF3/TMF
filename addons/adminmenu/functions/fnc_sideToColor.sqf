#include "\x\tmf\addons\adminmenu\script_component.hpp"

params [["_side", sideUnknown, [sideUnknown]]];

// Cache
if (isNil QGVAR(sideColors)) then {
    GVAR(sideColors) = [
        [0.975, 0.929, 0.078, 0.8],
        [1, 1, 1, 0.8],
        [profileNamespace getVariable ['Map_BLUFOR_R', 0], profileNamespace getVariable ['Map_BLUFOR_G', 0], profileNamespace getVariable ['Map_BLUFOR_B', 1], 0.8],
        [profileNamespace getVariable ['Map_OPFOR_R', 1], profileNamespace getVariable ['Map_OPFOR_G', 0], profileNamespace getVariable ['Map_OPFOR_B', 0], 0.8],
        [profileNamespace getVariable ['Map_Independent_R', 0], profileNamespace getVariable ['Map_Independent_G', 1], profileNamespace getVariable ['Map_Independent_B', 0], 0.8],
        [profileNamespace getVariable ['Map_Civilian_R', 0.5], profileNamespace getVariable ['Map_Civilian_G', 0], profileNamespace getVariable ['Map_Civilian_B', 0.5], 0.8]
    ];
    GVAR(sideColorsIndex) = [sideLogic, blufor, opfor, resistance, civilian];
};

GVAR(sideColors) select ((GVAR(sideColorsIndex) find _side) + 1);
