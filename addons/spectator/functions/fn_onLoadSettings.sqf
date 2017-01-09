params ["_display"];
#include "\x\tmf\addons\spectator\script_component.hpp"


private _grpTagSlider = _display controlsGroupCtrl 101;
private _unitTagSlider = _display controlsGroupCtrl 102;




_grpTagSlider sliderSetRange [0.0,2];
_grpTagSlider sliderSetPosition GVAR(grpTagScale);

_unitTagSlider sliderSetRange [0.0,2];
_unitTagSlider sliderSetPosition GVAR(unitTagScale);




_grpTagSlider ctrlSetEventHandler ["SliderPosChanged",'["grpTagScale",_this] call FUNC(handleSettingsMenu);'];


_unitTagSlider ctrlSetEventHandler ["SliderPosChanged",'["unitTagScale",_this] call FUNC(handleSettingsMenu);'];
