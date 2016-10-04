#include "defines.hpp"
#include "\x\tmf\addons\spectator\script_component.hpp"

disableSerialization;
private _isOpen = [] call FUNC(isOpen);
if(_isOpen) then {[] call TMF_spectator_fnc_handleUnitList};
if(!(_isOpen) || GVAR(showMap)) exitWith {};

with uiNamespace do { ctrlSetFocus GVAR(unitlist);};

GVAR(mPos) params ["_x","_y"];
GVAR(mButtons) params ["_leftButton","_rightButton"];
GVAR(lmPos) params ["_lx","_ly"];

private _dx = _lx - _x;
private _dy = _ly - _y;

if(_rightButton && !_leftButton) then {
    GVAR(followcam_angle) params ["_ax","_ay"];
    GVAR(followcam_angle) = [(_ax - (_dx*360)),(_ay + (_dy*180)) min 89 max -89];
};

private _oldcam = GVAR(camera);

GVAR(camera) = switch (tmf_spectator_mode) do {
  case 0: {
    GVAR(followcam)
  };
  case 1: {
    if(GVAR(camera) != GVAR(freecam)) then {
      GVAR(freecam) setPos (getPos GVAR(followcam));
      GVAR(freecam) setVectorDirAndUp [vectorDir GVAR(followcam),vectorUp GVAR(followcam) ];
    };
    GVAR(freecam)
  };
  case 2: {
    GVAR(target)
  };
};

if(_oldcam != GVAR(camera)) then {
  [GVAR(target)] call FUNC(setTarget);
  GVAR(followcam_fov) = 0.7;
};

GVAR(lmPos) = [_x,_y];

GVAR(movement_keys) params ["_wButton","_aButton","_sButton","_dButton","_qButton","_zButton","_zScroll"];
GVAR(modifiers_keys) params ["_ctrl","_shift","_alt"];
// Followcam
if(GVAR(mode) == FOLLOWCAM) then
  {
  if(_aButton) then {
    GVAR(followcam_angle) set [0,(GVAR(followcam_angle) select 0)+1];
  };
  if(_dButton) then {
    GVAR(followcam_angle) set [0,(GVAR(followcam_angle) select 0)-1];
  };
  if(_wButton) then {
    GVAR(followcam_angle) set [1,(GVAR(followcam_angle) select 1)+1];
  };
  if(_sButton) then {
    GVAR(followcam_angle) set [1,(GVAR(followcam_angle) select 1)-1];
  };

  private _commitTime = ((1.0 - ((speed vehicle tmf_spectator_target)/65))/3) max 0.1;
  private _delta = (-(2*(0.3 max GVAR(followcam_zoom))));

  GVAR(followcam_angle) params ["_ax","_ay"];

  private _zLevel = sin(_ay)*(2*(0.3 max GVAR(followcam_zoom)));

  private _pos = (getPosATLVisual GVAR(target));
  if(surfaceIsWater _pos) then {_pos = getPosASLVisual GVAR(target)};
  _pos set [2,(_pos select 2)+1.3];

  GVAR(camera) camSetTarget _pos;
  GVAR(relpos) = [(sin(_ax)*_delta)*cos(_ay), (cos(_ax)*_delta)*cos(_ay), _zLevel];
  GVAR(camera) camSetRelPos GVAR(relpos);
  GVAR(camera) camSetFov GVAR(followcam_fov);
  if(GVAR(camera) distance2d GVAR(target) > 1000) then {
    _commitTime = 0;
  };
  GVAR(camera) camCommit _commitTime;
};
// Freecam
if(GVAR(mode) == FREECAM) then
{
  private _currPos = getPosVisual GVAR(freecam);
  private _height = (0.1 max ((_currPos select 2) + 0.4)) min 650;
  private _mod = (0.1 max ((log (_height/5)) + (_height / 115))) min 7;
  if(_shift) then {_mod = _mod * 3.5};
  if(_ctrl) then {_mod = _mod * 0.5};

  if(_aButton) then {
    GVAR(freecam_move) set [0,(GVAR(freecam_move) select 0)-_mod];
  };
  if(_dButton) then {
    GVAR(freecam_move) set [0,(GVAR(freecam_move) select 0)+_mod];
  };
  if(_wButton) then {
    GVAR(freecam_move) set [1,(GVAR(freecam_move) select 1)+_mod];
  };
  if(_sButton) then {
    GVAR(freecam_move) set [1,(GVAR(freecam_move) select 1)-_mod];
  };
  if(_qButton) then {
    GVAR(freecam_move) set [2,(GVAR(freecam_move) select 2)+_mod/2];
  };
  if(_zButton) then {
    GVAR(freecam_move) set [2,(GVAR(freecam_move) select 2)-_mod/2];
  };

  private _delta = time - GVAR(freecam_timestamp);
  GVAR(freecam_move) = GVAR(freecam_move) vectorMultiply (_delta*60); // Ensure that speed is consistent.
  GVAR(freecam_move) params ["_mX","_mY","_mZ"];
  GVAR(followcam_angle) params ["_angleX","_angleY"];

  _z = 0;
  _x = (_currPos select 0) + (_mX * (cos _angleX)) + (_mY * (sin _angleX));
  _y = (_currPos select 1) - (_mX * (sin _angleX)) + (_mY * (cos _angleX));
  _z = ((_currPos select 2) + _mZ);

  if(_mX > 0) then {GVAR(freecam_move) set [0,_mX - abs (_mX)]};
  if(_mY > 0) then {GVAR(freecam_move) set [1,_mY - abs (_mY )]};

  if(_mX < 0) then {GVAR(freecam_move) set [0,_mX + abs (_mX )]};
  if(_mY < 0) then {GVAR(freecam_move) set [1,_mY + abs (_mY )]};

  if(_mZ < 0) then {GVAR(freecam_move) set [2,_mZ + abs (_mZ )]};
  if(_mZ > 0) then {GVAR(freecam_move) set [2,_mZ - abs (_mZ)]};
  private _tmpPos = [_x,_y,_z];
  private _z2 = (ATLToASL _tmpPos) select 2;
  if(_z2 < getTerrainHeightASL [_x,_y]) then {_z = 0; _tmpPos set[2,0];};

  if(_zscroll != 0) then {
    private _movement = _zScroll*2.5*_mod;
    private _zdelta = _movement;
    private _dirVector = vectorNormalized (screenToWorld (getMousePosition) vectorDiff getPosVisual GVAR(camera)); //(vectorDirVisual GVAR(camera)
    if(_zscroll > 0) then {
        _tmpPos = _tmpPos vectorAdd (_dirVector vectorMultiply abs(_zdelta));
    } else {
        _tmpPos = _tmpPos vectorDiff (_dirVector vectorMultiply abs(_zdelta));
    };

    GVAR(movement_keys) set [6,_zScroll*_delta];
    private _value = _zScroll-_zdelta;
    if(_value < 0.5 && _value > 0) then {GVAR(movement_keys) set [6,0];};
    if(_value > -0.5 && _value < 0) then {GVAR(movement_keys) set [6,0];};
  };

  GVAR(camera) setPos _tmpPos;
  GVAR(camera) setDir _angleX;
  [GVAR(camera),_angleY,0] call BIS_fnc_setPitchBank;
  GVAR(camera) camSetFov GVAR(followcam_fov);
  GVAR(camera) camCommit 0;
};

if(GVAR(mode) == FIRSTPERSON) then
{
    GVAR(target) switchCamera "internal";
    if(vehicle GVAR(target) != GVAR(target)) then
    {
        private _vehicle = vehicle GVAR(target);
        private _mode = "internal";
        if((assignedVehicleRole GVAR(target) select 0) != "Cargo") then {_mode = "gunner"};
        _vehicle switchCamera _mode;
    };
    if(vehicle GVAR(target) == GVAR(target) && (GVAR(mButtons) select 1)) then
    {
        GVAR(target) switchCamera "gunner";
    };
};

// update compass
(uiNamespace getVariable QGVAR(compass)) ctrlSetText ([(getDir GVAR(camera))] call FUNC(getCardinal));
(uiNamespace getVariable QGVAR(compassL)) ctrlSetText ([(getDir GVAR(camera))-45] call FUNC(getCardinal));
(uiNamespace getVariable QGVAR(compassR)) ctrlSetText ([(getDir GVAR(camera))+45] call FUNC(getCardinal));

// update something horrible

if(!isNil QGVAR(target) && {!isNull GVAR(target)} && {alive GVAR(target)} ) then {
    (uiNamespace getVariable QGVAR(unitlabel)) ctrlSetText (name GVAR(target));
} else {
    (uiNamespace getVariable QGVAR(unitlabel)) ctrlSetText "";
};

// Handle notfications
if(GVAR(currentnotification) == "" && count GVAR(notification) > 0) then {
  GVAR(currentnotification) = (GVAR(notification) select 0);
  GVAR(notification) = GVAR(notification) - [GVAR(currentnotification)];
  with uiNamespace do {
    GVAR(notificationbar) ctrlSetText " "+(missionNamespace getVariable QGVAR(currentnotification));
    GVAR(notificationbar) ctrlSetPosition GVAR(notification_pos);
    GVAR(notificationbar) ctrlCommit 0;
    [] spawn {
      disableSerialization;
      waitUntil {ctrlCommitted GVAR(notificationbar)};
      uiSleep 0.8;
      _x = [] + GVAR(notification_pos);// make a new one;
      _x set [2,0];
      GVAR(notificationbar) ctrlSetPosition _x;
      GVAR(notificationbar) ctrlCommit 0.3;
      waitUntil {ctrlCommitted GVAR(notificationbar)};
      GVAR(notificationbar) ctrlSetText "";
      missionNamespace setVariable [QGVAR(currentnotification),""];
    };
  };
};
{
    _x ctrlSetStructuredText parseText "";
} forEach (uiNamespace getVariable [QGVAR(labels),[]]);
private _arr = [] + GVAR(killedUnits);
reverse _arr;
private _index = 0;
{
    _x params ["_unit","_time","_killer","_deadSide","_killerSide","_dName","_kName","_weapon"];
    _time = time - _time;
    if(_time <= 12 && _index < 6) then {
        private _control = (uiNamespace getvariable [QGVAR(labels),[]]) select _index;
        if(_dName == "") then { _dName = getText (configFile >> "CfgVehicles" >> typeOf vehicle _unit >> "displayName")   };
        if(_kName == "") then { _kName = getText (configFile >> "CfgVehicles" >> typeOf vehicle _killer >> "displayName") };
        _x set [5,_dName];
        _x set [6,_kName];
        if(_killer == _unit || isNull _killer) then {
            _control ctrlSetStructuredText parseText format ["<img image='\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa'/><t color='%2'>%1</t>",_dName,_deadSide call CFUNC(sidetohexcolor)];
        } else {
            _control ctrlSetStructuredText parseText format ["<t color='%4'>%1</t>  [%3]  <t color='%5'>%2</t>",_kName,_dName,getText (configFile >> "CfgWeapons" >> (_weapon) >> "displayName"),_killerSide call CFUNC(sidetohexcolor),_deadSide call CFUNC(sidetohexcolor)];
        };
        _index = _index + 1;
    };
} forEach _arr;

if(GVAR(tags)) then {call FUNC(drawTags)};
GVAR(freecam_timestamp) = time;
