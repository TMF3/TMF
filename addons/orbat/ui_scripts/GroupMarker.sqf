#include "..\script_component.hpp"

params ["_mode",["_params",[]],["_value","[]"]];

switch _mode do {
    case "onLoad": {
       #include "GroupMarker_onLoad.sqf"
    };
    case "attributeLoad": {
       #include "GroupMarker_attributeLoad.sqf"
    };
    case "attributeSave": {
       #include "GroupMarker_attributeSave.sqf"
    };
};
