#include "\x\tmf\addons\autotest\script_component.hpp"

// AI Numbers check
private _output = [];
private _warningAmount = getNumber (_test >> "warningAmount");
private _errorAmount = getNumber (_test >> "errorAmount");

private _array = playableUnits + [player];
private _aiCount = {!(_x in _array)} count allUnits;

if (_aiCount > _warningAmount) then {
    if (_aiCount > _errorAmount) then {
        _output pushBack [0,format["You have placed %1 AI. You may wish to consider the performance impact.",_aiCount]];
    } else {
        _output pushBack [1,format["You have placed %1 AI. You may wish to consider the performance impact.",_aiCount]];
    };
};

_output
