#include "\x\tmf\addons\orbat\script_component.hpp"
[
    QGVAR(markerUpdateInterval),
    "SLIDER",
    ["ORBAT map marker update interval", "Seconds between updates of the ORBAT group and unit markers on the map. 0 updates every frame. Lower values cost more performance."],
    ["TMF", "ORBAT"],
    [
        0,  // Min
        150,// Max
        3,  // Default
        1   // Trailing decimals
    ],
    1, // isGlobal
    {[_this] call FUNC(setmarkerUpdateInterval)}
] call CBA_fnc_addSetting;
