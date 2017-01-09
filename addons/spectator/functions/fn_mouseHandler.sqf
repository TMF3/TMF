#include "\x\tmf\addons\spectator\script_component.hpp"
params["_type","_args"];

switch (_type) do {
    case "MouseButtonDown": {
        _args params ["_control","_button","_x","_y","_shift","_ctrl","_alt"];
        GVAR(mButtons) set [_button,true];
        // Switches to the unit when clicked
        if(_button == 0 && (GVAR(mode) == FOLLOWCAM || GVAR(mode) == FREECAM) && ctrlClassName _control == QGVAR(EntityTag)) then {
            private _target = _control getVariable [QGVAR(attached), objNull];
            if(_target isEqualType grpNull) then {
                private _units = units _target select {alive _x};
                if(count _units > 0) then {_target = _units select 0}
                else {_target = objNull};
            }
            else {
                _target = (crew _target) select 0
            };
            [_target] call FUNC(setTarget);
        };
    };

    case "MouseButtonUp": {
        _args params ["_control","_button","_x","_y","_shift","_ctrl","_alt"];
        GVAR(mButtons) set [_button,false];
    };

    case "MouseMoving" : {
        _args params ["_control","_x","_y"];
        GVAR(mPos) = [_x,_y];
    };

    case "MouseZChanged" : {
        _args params ["_control","_value"];
        if((GVAR(modifiers_keys) select 0) && (GVAR(modifiers_keys) select 2)) then
        {
            if(_value > 0) then {GVAR(followcam_fov) = (GVAR(followcam_fov) - 0.05 * _value) max 0.1;};
            if(_value < 0) then {GVAR(followcam_fov) = (GVAR(followcam_fov) + 0.05 * (abs _value)) min 2.0;};
        };
        if(GVAR(mode) == FOLLOWCAM && {_x} count GVAR(modifiers_keys) <= 0) then {
            GVAR(followcam_zoom) = ((GVAR(followcam_zoom) - ((_value)*GVAR(followcam_zoom)/5)) max 0.1) min 650;
        };
        if(GVAR(mode) == FREECAM && {_x} count GVAR(modifiers_keys) <= 1) then
        {
            private _nvalue = GVAR(movement_keys) select 6;
            GVAR(movement_keys) set [6,_nvalue + _value];
        };
    };
};
