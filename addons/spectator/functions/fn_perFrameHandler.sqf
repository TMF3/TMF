#include "defines.hpp"
#include "\x\tmf\addons\spectator\script_component.hpp"
_isOpen = [] call FUNC(isOpen);
if(_isOpen) then {[] call TMF_spectator_fnc_handleUnitList};
if(!(_isOpen) || GVAR(showMap)) exitWith {};


disableSerialization;
with uiNamespace do {
  ctrlSetFocus GVAR(unitlist);
};




GVAR(mPos) params ["_x","_y"];

GVAR(mButtons) params ["_leftButton","_rightButton"];

GVAR(lmPos) params ["_lx","_ly"];

_dx = _lx - _x;
_dy = _ly - _y;



if(_rightButton && !_leftButton) then
  {
  GVAR(followcam_angle) params ["_ax","_ay"];
  GVAR(followcam_angle) = [(_ax - (_dx*360)),(_ay + (_dy*180)) min 89 max -89];
};





_oldcam = GVAR(camera);


GVAR(camera) = switch (tmf_spectator_mode) do {
  case 0: {
    GVAR(followcam)
  };
  case 1: {
    if(GVAR(camera) != GVAR(freecam)) then {
      GVAR(freecam) setpos (getpos GVAR(followcam));
      GVAR(freecam) setVectorDirAndUp [vectordir GVAR(followcam),vectorUp GVAR(followcam) ];
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

  _commitTime = ((1.0 - ((speed vehicle tmf_spectator_target)/65))/3) max 0.1;
  _delta = (-(2*(0.3 max GVAR(followcam_zoom))));


  GVAR(followcam_angle) params ["_ax","_ay"];

  _zLevel = sin(_ay)*(2*(0.3 max GVAR(followcam_zoom)));

  _pos = (getPosATLVisual GVAR(target));
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
  private _mod = GVAR(freecam_speedmod); // 1 to 10

  private _currPos = getPosVisual GVAR(freecam);
  private _height = (0.1 max ((_currPos select 2) - 2)) min 400;
  _mod = (_mod * (0.175 max (_height/200))) min 10;
  if(_shift) then {_mod = _mod * 5};
  if(_ctrl) then {_mod = _mod * 0.5};

  //GVAR(freecam_move) set [1 ,(GVAR(freecam_move) select 1)+_zScroll];

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
    GVAR(freecam_move) set [2,(GVAR(freecam_move) select 2)+_mod/4];
  };
  if(_zButton) then {
    GVAR(freecam_move) set [2,(GVAR(freecam_move) select 2)-_mod/4];
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
  _tmpPos = [_x,_y,_z];
  _tmpPos = (ATLToASL _tmpPos) select 2;
  if(_tmpPos < getTerrainHeightASL [_x,_y]) then {_z = 0};
  _tmpPos = [_x,_y,_z];
  if(_zscroll != 0) then {
     systemChat str (_zscroll);
    if(_zscroll > 0) then {
        _tmpPos = (_tmpPos vectorAdd vectorDirVisual GVAR(camera)) vectorMultiply 1;
    }
    else {
        _tmpPos = (_tmpPos vectorDiff vectorDirVisual GVAR(camera)) vectorMultiply 1;
    };
    GVAR(movement_keys) set [6,0];
  };

  GVAR(camera) setpos _tmpPos;
  GVAR(camera) setDir _angleX;
  [GVAR(camera),_angleY,0] call BIS_fnc_setPitchBank;
  GVAR(camera) camSetFov GVAR(followcam_fov);
  GVAR(camera) camCommit 0;

};

if(GVAR(mode) == FIRSTPERSON) then
{
    GVAR(target) SwitchCamera "internal";
    if(vehicle GVAR(target) != GVAR(target)) then
    {
        _vehicle = vehicle GVAR(target);
        _mode = "internal";
        if((assignedVehicleRole GVAR(target) select 0) != "Cargo") then {_mode = "gunner"};
        _vehicle switchCamera _mode;
    };
    if(vehicle GVAR(target) == GVAR(target) && (GVAR(mButtons) select 1)) then
    {
        GVAR(target) SwitchCamera "gunner";
    };
};

// update compass
(uiNamespace getVariable QGVAR(compass)) ctrlSetText ([(getdir GVAR(camera))] call FUNC(getCardinal));
(uiNamespace getVariable QGVAR(compassL)) ctrlSetText ([(getdir GVAR(camera))-45] call FUNC(getCardinal));
(uiNamespace getVariable QGVAR(compassR)) ctrlSetText ([(getdir GVAR(camera))+45] call FUNC(getCardinal));

// update something horrible

if(!isNil QGVAR(target) && {!isNull GVAR(target)} && {alive GVAR(target)} ) then {
  (uinamespace getvariable QGVAR(unitlabel)) ctrlSetText (name GVAR(target));
} else {
    (uinamespace getvariable QGVAR(unitlabel)) ctrlSetText "";
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
} foreach (uiNamespace getvariable [QGVAR(labels),[]]);
private _arr = [] + GVAR(killedUnits);
reverse _arr;
_index = 0;
{
    _x params ["_unit","_time","_killer","_deadSide","_killerSide","_dName","_kName","_weapon"];
    _time = time - _time;
    if(_time <= 12 && _index < 6) then {
        _control = (uiNamespace getvariable [QGVAR(labels),[]]) select _index;
        if(_dName == "") then { _dName = getText (configFile >> "CfgVehicles" >> typeOf vehicle _unit >> "displayName")   };
        if(_kName == "") then { _kName = getText (configFile >> "CfgVehicles" >> typeOf vehicle _killer >> "displayName") };
        _x set [5,_dName];
        _x set [6,_kName];
        if(_killer == _unit || isNull _killer) then {
            _control ctrlSetStructuredText parseText format ["<img image='\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa'/><t color='%2'>%1</t>",_dName,_deadSide call CFUNC(sidetohexcolor)];
        }
        else {
            _control ctrlSetStructuredText parseText format ["<t color='%4'>%1</t>  [%3]  <t color='%5'>%2</t>",_kName,_dName,getText (configFile >> "CfgWeapons" >> (_weapon) >> "displayName"),_killerSide call CFUNC(sidetohexcolor),_deadSide call CFUNC(sidetohexcolor)];
        };
        _index = _index + 1;
    };
} foreach _arr;



if(GVAR(tags)) then {call FUNC(drawTags)};
GVAR(freecam_timestamp) = time;
