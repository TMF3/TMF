#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

createDialog QGVAR(adminEyeDialog);

GVAR(Triggers) = allMissionObjects "EmptyDetector";
GVAR(WaveSpawners) = allMissionObjects QEGVAR(ai,wavespawn);
GVAR(Garrison) = (allMissionObjects QEGVAR(ai,garrison) + allMissionObjects QEGVAR(ai,garrisonQuantity));


GVAR(adminEyeSelectedObj) = objNull;
//FUTURE - Area
