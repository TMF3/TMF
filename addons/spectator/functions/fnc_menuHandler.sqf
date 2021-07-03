#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_button","_args"];

_args params ["_control"];


switch (_button) do {


    // Sidefilter button
    case "sidefilter": {
      GVAR(sides_button_state) = (GVAR(sides_button_state) + 1);

      // if above array size, restart at zero
      if(GVAR(sides_button_state) > (count GVAR(sides_button_mode))-1) then {
        GVAR(sides_button_state) = 0;
      };


      GVAR(sides) = GVAR(sides_button_mode) select GVAR(sides_button_state);

      if(count GVAR(sides) == 1) then {
            _control ctrlSetTextColor ((GVAR(sides) select 0) call CFUNC(sideToColor));
      }
      else
      {
          _control ctrlSetTextColor [1,1,1,1];
      };

      _control ctrlSetTooltip (GVAR(sides_button_strings) select GVAR(sides_button_state) );

      GVAR(clearGroups) = true;
    };




    // AI button
    case "disableAI": {
      GVAR(playersOnly) = !GVAR(playersOnly);

      _text = "\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayerSetup\enabledai_ca.paa";
      _messsage = "AI + PLAYERS";

      if(GVAR(playersOnly)) then {_messsage = "PLAYERS ONLY";_text = "\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayerSetup\disabledai_ca.paa";};

      GVAR(clearGroups) = true;

      _control ctrlSetText ( _text);
      _control ctrlSetTooltip _messsage;
    };



    // Tags button
    case "tags" : {
        GVAR(tags) = !GVAR(tags);


        private _tooltip = "ENABLE TAGS";

        if(GVAR(tags)) then {
            _tooltip = "DISABLE TAGS";
        } else {
            // Remove controls.
            {_x setVariable [QGVAR(tagControl),nil];} forEach allUnits;
            {_x setVariable [QGVAR(tagControl),nil];} forEach allGroups;
            {ctrlDelete _x} forEach GVAR(controls);
            GVAR(controls) = [];
        };

        _control ctrlSetTooltip _tooltip;
    };
    case "mute" : {
      [] call acre_sys_core_fnc_toggleHeadset;
    };
    case "radio": {
        // Broadcast event.
        [QGVAR(radioButtonPressed), []] call CBA_fnc_localEvent;
    };
    case "vision" : {
        GVAR(visionMode) = GVAR(visionMode) +1;
        if(GVAR(visionMode) > 2) then {GVAR(visionMode) = 0};
        false setCamUseTi 0;
        camUseNVG false;
        switch (GVAR(visionMode)) do {
            case 1: {
                camUseNVG true;
            };
            case 2: {
                true setCamUseTi 0;
            };
        };
        _i = (GVAR(visionMode))+1;
        if(_i > 2) then {_i = 0};
    if(isNil "_control" || {isNull _control}) then {_control = uinamespace getVariable [QGVAR(vision),controlNull];};
        _control ctrlSetTooltip format ["Switch to %1", GVAR(visionMode_strings) select _i ];
    };
    case "camera" : {
        if( count (GVAR(allowed_modes) select {_x}) <= 0) exitWith {
            // we leave because otherwise it will loop forever...
        };


        private _nextMode = GVAR(mode) + 1;
        if(_nextMode > 2) then {
            _nextMode = 0;
        };
        while { !(GVAR(allowed_modes) # _nextMode ) } do {
            _nextMode = _nextMode + 1;
            if(_nextMode > 2) then {
                _nextMode = 0;
            };
        };

        switch(_nextMode) do {
            case FOLLOWCAM: {
                if(GVAR(mode) == FREECAM) then {
                    private _pitch = (GVAR(camera) call BIS_fnc_getPitchBank) select 0;
                    GVAR(followcam_angle) = [(getDir GVAR(camera) + 180) mod 360,(_pitch+180) mod 360];
                };
                GVAR(mode) = FOLLOWCAM;
            };
            case FREECAM: {
                if(GVAR(mode) == FOLLOWCAM) then {
                    GVAR(followcam_angle) = [getDir GVAR(camera), (GVAR(camera) call BIS_fnc_getPitchBank) select 0];
                };
                GVAR(mode) = FREECAM;
            };
            case FIRSTPERSON: {
                GVAR(mode) = FIRSTPERSON;
            };
        };
        [] call FUNC(setTarget);






        _nextMode = GVAR(mode) + 1;
        if(_nextMode > 2) then {
            _nextMode = 0;
        };
        while { !(GVAR(allowed_modes) # _nextMode ) } do {
            _nextMode = _nextMode + 1;
            if(_nextMode > 2) then {
                _nextMode = 0;
            };
        };


        private _tooltip = "SWITCH TO FOLLOW CAMERA";
        switch (_nextMode) do {
            case (FOLLOWCAM): {
                _tooltip = "SWITCH TO FREECAM";
            };
            case (FREECAM): {
                _tooltip = "SWITCH TO FRISTPERSON";
            };
            case (FIRSTPERSON): {
                _tooltip = "SWITCH TO FOLLOWCAM";
            };
        };
        _control ctrlSetTooltip _tooltip;
    };
};
