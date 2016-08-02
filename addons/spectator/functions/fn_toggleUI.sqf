#include "\x\tmf\addons\spectator\script_component.hpp"

if(GVAR(showUI)) then { // hide UI
  {
    with uiNamespace do {
      (GVAR(display) displayCtrl _x) ctrlShow false;
    };
  } foreach GVAR(controls);
}
else { // SHOW UI
  {
    with uiNamespace do {
      (GVAR(display) displayCtrl _x) ctrlShow true;
    };
  } foreach GVAR(controls);
  if (!isClass(configFile >> "CfgPatches" >> "acre_main")) then { // Hide mute button if we dont need it. implement variable..
    GVAR(mute) ctrlShow false;
  };
};
GVAR(showUI) = !GVAR(showUI);
