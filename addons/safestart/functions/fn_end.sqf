#include "\x\tmf\addons\safestart\script_component.hpp"
params ["_module"];
if(isNull _module || !(_module isKindOf QGVAR(module))) exitWith {
    false
};
_module setVariable [QGVAR(enabled),false,true];
true