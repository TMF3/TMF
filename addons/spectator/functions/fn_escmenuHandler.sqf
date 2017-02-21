
#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_mode","_args"];


disableSerialization;
switch (_mode) do {
    case "onLoad": {
      if ([] call tmf_common_fnc_isAdmin) then {
          ["onLoad",[(_args select 0)],"RscDebugConsole"] execVM "A3\ui_f\scripts\gui\RscDebugConsole.sqf";
      }
      else {
          ((_args select 0) displayCtrl 13184) ctrlShow false;
      };

      _text = format["<t size='2.2' align='center'>Help</t> <br/>
      W,A,S,D - Move fowards/backwards/left/right <br/>
      Q,Z - Adjust altitude <br/>
      T - Toggle tracers <br/>
      U - Hide UI <br/>
      %1 - Show group lines <br/>
      Space - Toggle camera mode <br/>
      %2 - Show map <br/>
      Scroll-wheel - Zoom on mouse position <br/>
      Shift - High speed <br/>
      ",actionKeysNames "ReloadMagazine",actionKeysNames "ShowMap"];
      ((_args select 0) displayCtrl 1100) ctrlSetStructuredText parseText _text;

    };
    case "onUnload" : {
        _args params ["_display"];
        if ([] call tmf_common_fnc_isAdmin) then {
            ["onUnload",[(_args select 0)],"RscDebugConsole"] execVM "A3\ui_f\scripts\gui\RscDebugConsole.sqf";
        };
    };
    case "abortClicked": {
        private _display = ctrlparent (_args select 0);
        private _abort = [localize "str_msg_confirm_return_lobby","Back to lobby?",localize "str_disp_xbox_hint_yes",localize "str_disp_xbox_hint_no",_display,false,false] call BIS_fnc_guiMessage;

        if (_abort) then {_display closeDisplay 2; failMission "loser"};
    };
    case "continueClicked": {
        closeDialog 1;
    };
    default {
    };
};
true;
