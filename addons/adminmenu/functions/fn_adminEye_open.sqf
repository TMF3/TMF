#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

createDialog QGVAR(adminEyeDialog);

GVAR(Triggers) = allMissionObjects "EmptyDetector";
GVAR(WaveSpawners) = allMissionObjects "tmf_ai_wavespawn";
GVAR(Garrison) = (allMissionObjects "tmf_ai_garrison" + allMissionObjects "tmf_ai_garrisonQuantity");


GVAR(adminEyeSelectedObj) = objNull;
//FUTURE - Area
