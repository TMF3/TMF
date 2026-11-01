#include "\x\tmf\addons\spectator\script_component.hpp"
[
    QGVAR(isJIPAllowed),
    "LIST",
    ["Join in progress", "Whether players who join after the mission started may play. Players who may not are put into spectator."],
    ["TMF", "Spectator"],
    [[0,1,2],["Spectator only", "Allowed", "Only during safe start"],2],
    1
] call CBA_fnc_addSetting;
[
    QGVAR(showGroupMarkers),
    "LIST",
    ["Group markers shown", "Which groups get a marker in spectator, in 3D and on the map."],
    ["TMF", "Spectator"],
    [[0,1],["Player groups only", "All groups, including AI"], 0],
    1
] call CBA_fnc_addSetting;

[
    QGVAR(followCameraEnabled),
    "CHECKBOX",
    ["Allow follow camera", "Spectators can use the camera that orbits around a unit."],
    ["TMF", "Spectator"],
    true,
    1
] call CBA_fnc_addSetting;
[
    QGVAR(freeCameraEnabled),
    "CHECKBOX",
    ["Allow free camera", "Spectators can fly the camera freely around the map."],
    ["TMF", "Spectator"],
    true,
    1
] call CBA_fnc_addSetting;
[
    QGVAR(firstPersonCameraEnabled),
    "CHECKBOX",
    ["Allow first-person camera", "Spectators can view through a unit's eyes."],
    ["TMF", "Spectator"],
    true,
    1
] call CBA_fnc_addSetting;
[
    QGVAR(canSpectateAllSides),
    "CHECKBOX",
    ["Spectate all sides", "When off, spectators can only watch units on their own side."],
    ["TMF", "Spectator"],
    true,
    1
] call CBA_fnc_addSetting;
