#include "\x\tmf\addons\spectator\script_component.hpp"
disableSerialization;

GVAR(showUI) = !GVAR(showUI);
private _display = uiNamespace getVariable [QGVAR(display),displayNull];

{ (_display displayCtrl _x) ctrlShow GVAR(showUI); } forEach GVAR(interfaceControls);

if (!isClass(configFile >> "CfgPatches" >> "acre_main")) then { // Hide mute button if we dont need it. implement variable..
    (uiNamespace getVariable [QGVAR(mute), controlNull]) ctrlShow GVAR(showUI);
    (uiNamespace getVariable [QGVAR(radio), controlNull]) ctrlShow GVAR(showUI);
};

[QGVAR(toggleUI), [GVAR(showUI),_display]] call CBA_fnc_localEvent;

showChat GVAR(showUI);

