#include "..\script_component.hpp"
params ["_mode",["_params",[]]];

switch _mode do {
    case "onLoad": {
       #include "UnitMarker_onLoad.sqf"
    };
    case "attributeLoad": {
       #include "UnitMarker_attributeLoad.sqf"
    };
    case "attributeSave": {
       #include "UnitMarker_attributeSave.sqf"
    };
};
