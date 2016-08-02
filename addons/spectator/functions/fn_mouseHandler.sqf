#include "\x\tmf\addons\spectator\script_component.hpp"
params["_type","_args"];

switch (_type) do {
    case "MouseButtonDown": {
        _args params ["_control","_button","_x","_y","_shift","_ctrl","_alt"];
        GVAR(mButtons) set [_button,true];
        // Switches to the unit when clicked
        if(_button == 0 && (GVAR(mode) == 0 || GVAR(mode) == 1)) then {
          private _ints = lineIntersectsWith [getPosASL GVAR(camera),ATLToASL screenToWorld getMousePosition,GVAR(camera),objNull,true];
          reverse _ints;
          _ints = _int select {!isNull _x && {_x in GVAR(allunits)}};
          if (count _ints < 0) exitWith {};
          [_ints select 0] call FUNC(setTarget);
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
        if(GVAR(modifiers_keys) select 0) then
        {
            if(_value > 0) then {GVAR(followcam_fov) = (GVAR(followcam_fov) - 0.05 * _value) max 0.1;};
            if(_value < 0) then {GVAR(followcam_fov) = (GVAR(followcam_fov) + 0.05 * (abs _value)) min 2.0;};
        };
        if(GVAR(mode) == 0 && {_x} count GVAR(modifiers_keys) <= 0) then {
          GVAR(followcam_zoom) = ((GVAR(followcam_zoom) - ((_value)*GVAR(followcam_zoom)/5)) max 0.1) min 650;
        };
        if(GVAR(mode) == 1 && {_x} count GVAR(modifiers_keys) <= 0) then
        {
          if(_value > 0) then {GVAR(freecam_speedmod) = (GVAR(freecam_speedmod) +  _value) min GVAR(freecam_speedmod_max);};
          if(_value < 0) then {GVAR(freecam_speedmod) = (GVAR(freecam_speedmod) -  (abs _value)) max GVAR(freecam_speedmod_min);};
          profileNamespace setVariable [QGVAR(freecam_speedmod),GVAR(freecam_speedmod)];
          _prcent = GVAR(freecam_speedmod) / GVAR(freecam_speedmod_max);

          GVAR(freecam_speed_timestamp) = time;

          with uiNamespace do {
              GVAR(speed_bar) ctrlShow true;
              GVAR(speed_text) ctrlShow true;
              GVAR(speed_bar) progressSetPosition _prcent;
          };
        };
	};


};
