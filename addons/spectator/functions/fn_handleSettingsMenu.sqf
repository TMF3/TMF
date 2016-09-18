#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_type","_args"];

switch (_type) do {
    case ("grpTagScale"): {
        _args params ["_control","_value"];
        GVAR(grpTagScale) = _value;
        profileNamespace setVariable [QGVAR(grpTagScale),_value];
    };
    case ("unitTagScale"): {
        _args params ["_control","_value"];
        GVAR(unitTagScale) = _value;
        profileNamespace setVariable [QGVAR(unitTagScale),_value];
    };
};
