










#include "defines.hpp"
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


      _tooltip = "ENABLE TAGS";
      _msg = "TAGS DISABLED";

      if(GVAR(tags)) then {
          _tooltip = "DISABLE TAGS";
          _msg = "TAGS ENABLED";
      };


      _control ctrlSetTooltip _tooltip;
    };
    case "mute" : {
      [] call acre_sys_core_fnc_toggleHeadset;
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
        private _tooltip = "SWITCH TO FOLLOW CAMERA";
        private _messsage = "FIRST PERSON ENABLED";
        private _modes = [getMissionConfigValue ["TMF_Spectator_AllowFollowCam",true],getMissionConfigValue ["TMF_Spectator_AllowFreeCam",true],getMissionConfigValue ["TMF_Spectator_AllowFPCam",true]];
        private _nextMode = GVAR(mode) +1;
        if(_nextMode > 2) then {_nextMode = 0;};

        while{!(_modes select (_nextMode))} do {
            _nextMode = GVAR(mode) +1;
            if(_nextMode > 2) then {_nextMode = 0;};
        };

        switch (_nextMode) do {
            case (FOLLOWCAM): {
                _tooltip = "SWITCH TO FREECAM";
                _messsage = "SWITCHED TO FOLLOWCAM";
            };
            case (FREECAM): {
                _tooltip = "SWITCH TO FIRST PERSON";
                _messsage = "SWITCHED TO FREECAM";
            };
            case (FIRSTPERSON): {
                _tooltip = "SWITCH TO FOLLOWCAM";
                _messsage = "SWITCHED TO FIRST PERSON";
            };
        };
        GVAR(mode) = _nextMode;
        [] call FUNC(setTarget);

        _control ctrlSetTooltip _tooltip;
    };
};
