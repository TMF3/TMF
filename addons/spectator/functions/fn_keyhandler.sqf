#define DIK_ESCAPE          0x01
#define DIK_1               0x02
#define DIK_2               0x03
#define DIK_3               0x04
#define DIK_4               0x05
#define DIK_5               0x06
#define DIK_6               0x07
#define DIK_7               0x08
#define DIK_8               0x09
#define DIK_9               0x0A
#define DIK_0               0x0B
#define DIK_MINUS           0x0C    /* - on main keyboard */
#define DIK_EQUALS          0x0D
#define DIK_BACK            0x0E    /* backspace */
#define DIK_TAB             0x0F
#define DIK_Q               0x10
#define DIK_W               0x11
#define DIK_E               0x12
#define DIK_R               0x13
#define DIK_T               0x14
#define DIK_Y               0x15
#define DIK_U               0x16
#define DIK_I               0x17
#define DIK_O               0x18
#define DIK_P               0x19
#define DIK_LBRACKET        0x1A
#define DIK_RBRACKET        0x1B
#define DIK_RETURN          0x1C    /* Enter on main keyboard */
#define DIK_LCONTROL        0x1D
#define DIK_A               0x1E
#define DIK_S               0x1F
#define DIK_D               0x20
#define DIK_F               0x21
#define DIK_G               0x22
#define DIK_H               0x23
#define DIK_J               0x24
#define DIK_K               0x25
#define DIK_L               0x26
#define DIK_SEMICOLON       0x27
#define DIK_APOSTROPHE      0x28
#define DIK_GRAVE           0x29    /* accent grave */
#define DIK_LSHIFT          0x2A
#define DIK_BACKSLASH       0x2B
#define DIK_Z               0x2C
#define DIK_X               0x2D
#define DIK_C               0x2E
#define DIK_V               0x2F
#define DIK_B               0x30
#define DIK_N               0x31
#define DIK_M               0x32
#define DIK_COMMA           0x33
#define DIK_PERIOD          0x34    /* . on main keyboard */
#define DIK_SLASH           0x35    /* / on main keyboard */
#define DIK_RSHIFT          0x36
#define DIK_MULTIPLY        0x37    /* * on numeric keypad */
#define DIK_LMENU           0x38    /* left Alt */
#define DIK_SPACE           0x39
#define DIK_CAPITAL         0x3A
#define DIK_F1              0x3B
#define DIK_F2              0x3C
#define DIK_F3              0x3D
#define DIK_F4              0x3E
#define DIK_F5              0x3F
#define DIK_F6              0x40
#define DIK_F7              0x41
#define DIK_F8              0x42
#define DIK_F9              0x43
#define DIK_F10             0x44
#define DIK_NUMLOCK         0x45
#define DIK_SCROLL          0x46    /* Scroll Lock */
#define DIK_NUMPAD7         0x47
#define DIK_NUMPAD8         0x48
#define DIK_NUMPAD9         0x49
#define DIK_SUBTRACT        0x4A    /* - on numeric keypad */
#define DIK_NUMPAD4         0x4B
#define DIK_NUMPAD5         0x4C
#define DIK_NUMPAD6         0x4D
#define DIK_ADD             0x4E    /* + on numeric keypad */
#define DIK_NUMPAD1         0x4F
#define DIK_NUMPAD2         0x50
#define DIK_NUMPAD3         0x51
#define DIK_NUMPAD0         0x52
#define DIK_DECIMAL         0x53    /* . on numeric keypad */
#define DIK_OEM_102         0x56    /* < > | on UK/Germany keyboards */
#define DIK_F11             0x57
#define DIK_NUMPADENTER     0x9C    /* Enter on numeric keypad */

// defines END




#define KEYDOWN 0


#include "\x\tmf\addons\spectator\script_component.hpp"





params ["_type","_args"];
_args params ["_control","_key","_shift","_ctrl","_alt"];


_done = true;
switch true do {
  case (_key == DIK_ESCAPE && _type == KEYDOWN) :
  {
    [QGVAR(black),false] call BIS_fnc_blackOut;
    with uiNamespace do {
      closeDialog 0;
      _display = (findDisplay 46) createDisplay (["RscDisplayInterrupt","RscDisplayMPInterrupt"] select isMultiplayer);
      _display displayAddEventHandler  ["Unload", {
          with missionNamespace do {
            [player,player,true] call FUNC(init);
            [QGVAR(black)] call BIS_fnc_blackIn;
          };
      }];
    };
    _done = true;
  };
  case (_key == DIK_A) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [1,true];
      }
      else
      {
          GVAR(movement_keys) set [1,false];
      };
  };
  case (_key == DIK_D) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [3,true];

      }
      else
      {
          GVAR(movement_keys) set [3,false];

      };
  };
  case (_key == DIK_W) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [0,true];
      }
      else
      {
          GVAR(movement_keys) set [0,false];
          //_done = true;
      };
  };
  case (_key == DIK_S) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [2,true];
      } else {
          GVAR(movement_keys) set [2,false];
          //_done = true;
      };
  };
  case (_key == DIK_Q) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [4,true];
      } else {
          GVAR(movement_keys) set [4,false];
      };
  };
  case (_key in (actionKeys "NightVision") && _type == KEYDOWN && !GVAR(showmap)) : {
        ['vision',[uinamespace getVariable [QGVAR(vision),controlNull]]] call FUNC(menuhandler);
  };
  case (_key == DIK_Z) : {
      if(_type == KEYDOWN) then
      {
          GVAR(movement_keys) set [5,true];
      } else {
          GVAR(movement_keys) set [5,false];
      };
  };
  case (_key in (actionKeys "ReloadMagazine")) : {
      if(_type == KEYDOWN) then {
          GVAR(showlines) = true;
      } else {
          GVAR(showlines) = false;
      };
  };
  case (_key in [DIK_RSHIFT,DIK_LSHIFT]) : {
      if(_type == KEYDOWN) then {
          GVAR(modifiers_keys) set [1,true];
      } else {
          GVAR(modifiers_keys) set [1,false];
      };
  };
  case (_key in [DIK_LMENU]) : { // Alt
      if(_type == KEYDOWN) then {
          GVAR(modifiers_keys) set [2,true];
      } else {
          GVAR(modifiers_keys) set [2,false];
      };
  };
  case (_key in [DIK_LCONTROL]) : { // Ctrl
      if(_type == KEYDOWN) then {
          GVAR(modifiers_keys) set [0,true];
      } else {
          GVAR(modifiers_keys) set [0,false];
      };
  };
  case (_key in actionKeys "ShowMap") : {
      if(_type == KEYDOWN) then {
          GVAR(showMap) = !GVAR(showMap);
          with uiNamespace do {
              _mapshow = (missionNamespace getVariable [QGVAR(showMap),false]);
              GVAR(map) ctrlShow _mapshow;
              GVAR(map) ctrlMapAnimAdd [0,0.05,missionNamespace getVariable [QGVAR(target),GVAR(camera)]];
              ctrlMapAnimCommit GVAR(map);
            //  if(_mapshow) then {GVAR(unitlist) ctrlSetTextColor [0,0,0,1];} else {GVAR(unitlist) ctrlSetTextColor [1,1,1,1];}
          };
      };
  };
  case (_key == GVAR(mute_key)) : {
      if(_type == KEYDOWN && (GVAR(modifiers_keys)) isEqualTo (GVAR(mute_modifers))) then {
          [] call acre_sys_core_fnc_toggleHeadset;
      };
  };
  case (_key == DIK_T && _type == KEYDOWN): {
      GVAR(tracers) = !GVAR(tracers);
      _message = "Tracers have been toggled off";
      if(GVAR(tracers)) then {_message = "Tracers have been toggled on"};
  };
    case (_key == DIK_SPACE && _type == KEYDOWN) : {
        if(!getMissionConfigValue ["TMF_Spectator_AllowFollowCam",true] || !getMissionConfigValue ["TMF_Spectator_AllowFreeCam",true]) exitWith {}; // camrea mode disabled
        if(GVAR(mode) == FOLLOWCAM || GVAR(mode) == FIRSTPERSON) then {
            if (GVAR(mode) == FOLLOWCAM) then {
                private _pitch = (GVAR(camera) call BIS_fnc_getPitchBank) select 0;
                GVAR(followcam_angle) = [getDir GVAR(camera),_pitch];
            };
          GVAR(mode) = FREECAM;
        }
        else {
            GVAR(mode) = FOLLOWCAM;
            private _pitch = (GVAR(camera) call BIS_fnc_getPitchBank) select 0;
            GVAR(followcam_angle) = [(getDir GVAR(camera) + 180) mod 360,(_pitch+180) mod 360];
        };
    };
  case (_key == DIK_U && _type == KEYDOWN) : {
    [] call FUNC(toggleUI);
  };
  case (_key in actionKeys "Chat") : {
    _done = false;
  };
    case (_key == DIK_P && _type == KEYDOWN) : {
      _time = ([missionStart,true] call CFUNC(secondsToTime));
      systemChat format["Mission time: %1:%2:%3",_time select 0,_time select 1,_time select 2];
  };
  case (_key in (actionKeys "curatorInterface") && _type == KEYDOWN): {
        if(!isNull getAssignedCuratorLogic player) then {
            private _pos = getPos GVAR(camera);
            private _vectorUp = vectorUp GVAR(camera);
            private _vectorDir = vectorDir GVAR(camera);
            closeDialog 2;
            [_pos,_vectorUp,_vectorDir] spawn {
                params ["_pos", "_vectorUp", "_vectorDir"];
                sleep 0.1;
                openCuratorInterface;
                waitUntil {sleep 0.1;!isNull (findDisplay 312)}; // wait until open
                curatorCamera setPos _pos;
                curatorCamera setVectorDirAndUp [_vectorDir,_vectorUp];
                (findDisplay 312) displayAddEventHandler ["Unload",{GVAR(zeusPos) = getPos curatorCamera; GVAR(zeusDir) = getDir curatorCamera; GVAR(zeusPitchBank) = curatorCamera call BIS_fnc_getPitchBank;_this spawn FUNC(zeusUnload);}];
                sleep 0.5;
                curatorCamera setPos _pos;
                curatorCamera setVectorDirAndUp [_vectorDir,_vectorUp];
            };
        };
  };
  case default {
      _done =false;
      if(_type == KEYDOWN) then {
        [QGVAR(keyDown),_this] call EFUNC(event,emit);
      } else {
        [QGVAR(keyUp),_this] call EFUNC(event,emit);
      };
  };
};
_done
