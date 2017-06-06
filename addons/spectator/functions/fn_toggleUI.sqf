#include "\x\tmf\addons\spectator\script_component.hpp"
GVAR(showUI) = !GVAR(showUI);
{
    with uiNamespace do {
        (GVAR(display) displayCtrl _x) ctrlShow GVAR(showUI);
    };
} forEach GVAR(interfaceControls);
if (!isClass(configFile >> "CfgPatches" >> "acre_main")) then { // Hide mute button if we dont need it. implement variable..
    GVAR(mute) ctrlShow GVAR(showUI);
};
showChat GVAR(showUI);

