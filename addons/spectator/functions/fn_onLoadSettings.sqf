params ["_display"];
#include "\x\tmf\addons\spectator\script_component.hpp"

_camSlider = _display controlsGroupCtrl 100;
_grpTagSlider = _display controlsGroupCtrl 101;
_unitTagSlider = _display controlsGroupCtrl 102;


_camSlider sliderSetRange [GVAR(freecam_speedmod_min),GVAR(freecam_speedmod_max)];
_camSlider sliderSetPosition GVAR(freecam_speedmod);

_grpTagSlider sliderSetRange [0.0,2];
_grpTagSlider sliderSetPosition GVAR(grpTagScale);

_unitTagSlider sliderSetRange [0.0,2];
_unitTagSlider sliderSetPosition GVAR(unitTagScale);



_camSlider ctrlSetEventHandler ["SliderPosChanged",'["freecam_speedmod",_this] call FUNC(handleSettingsMenu);'];


_grpTagSlider ctrlSetEventHandler ["SliderPosChanged",'["grpTagScale",_this] call FUNC(handleSettingsMenu);'];


_unitTagSlider ctrlSetEventHandler ["SliderPosChanged",'["unitTagScale",_this] call FUNC(handleSettingsMenu);'];
