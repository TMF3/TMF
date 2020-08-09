#include "..\script_component.hpp"

disableSerialization;

params ["_mode","_params","_unit"];
_params params ["_display"];
TRACE_3("Loading AIGear Retroactive Attribute",_mode,_params,_class);
private _ctrlToolbox = _display displayctrl IDC_RSCATTRIBUTERETROACTIVE_TOOLBOX;

switch (_mode) do {
    case "onLoad": {};
    case "onUnload": {};
    case "confirmed": {
        _unit setVariable [QGVARMAIN(Retroactive),0 == lbCurSel _ctrlToolbox];
        _unit setVariable [QGVARMAIN(updated),true];
    };
};
