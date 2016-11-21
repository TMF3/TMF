#include "\x\tmf\addons\spectator\script_component.hpp"
disableSerialization;
// enable hud and grab the user settings variables
cameraEffectEnableHUD true;
private _campos = getPosVisual GVAR(camera);
private _grpTagSize = 1 * GVAR(grpTagScale);
private _unitTagSize = 1 * GVAR(unitTagScale);
private _renderGroups = _grpTagSize > 0;

{
  // grab the group infomation cache
  private _grpCache = _x getVariable [QGVAR(grpCache),[0,[0,0,0],[1,1,1,1],true]];
  _grpCache params ["_grpTime","_avgpos","_color","_isAI"];

  diag_log "Hello:15";
  _control = _x call {disableSerialization;_this getVariable "tmf_spectator_tagcontrol"};
  if(isnil "_control") then {
      [_x] call FUNC(createGroupControl);
      _control = _x call {disableSerialization;_this getVariable "tmf_spectator_tagcontrol"};
  };
  // If we don't have a average pos for the group, or the time since the last the update as expired, generate a new one
  if(count _avgpos <= 0 || time > _grpTime) then
  {
      _grpCache = ([_x] call FUNC(updateGroupCache));
      _avgpos = _grpCache select 1; // update pos ASAP
  };

  // check if the average pos is on the screen
  private _render = [_avgpos] call FUNC(onScreen);


  ////////////////////////////////////////////////////////
  // Group tags
  ////////////////////////////////////////////////////////
  // Only draw the icon if the grp tags are "enabled"
  diag_log "Hello:34";
  if(_render) then { //
      _control ctrlShow true;
      _control ctrlSetPosition (worldToScreen _avgpos);
      _control ctrlSetScale 2;
      _control ctrlCommit 0;
  } else {
      _control ctrlShow false;
      _control ctrlCommit 0;
  };
diag_log "Hello:41";
  ////////////////////////////////////////////////////////
  // Unit / vehicle tags
  ////////////////////////////////////////////////////////

  private _renderedVehicles = [];
  {

  } forEach units _x;
} forEach allGroups;




////////////////////////////////////////////////////////
// Objectives tags
////////////////////////////////////////////////////////
{
  _data = _x getVariable [QGVAR(objectiveData),[]];
  if(count _data > 0) then {
    _data params ["_icon","_text","_color"];
    _fontSize = 0.04;

    _pos = (getPosATLVisual _x);
    if(surfaceIsWater _pos) then {_pos = getPosASLVisual _x;};
    if(_campos distance2d _pos > 400) then {_fontSize = 0};

    // draw icon
    drawIcon3D [_icon, _color,_pos, 1, 1, 0,"", 2,_fontSize,"PuristaSemibold" ];
    // draw text
    if(_text != "") then { drawIcon3D ["#(argb,1,1,1)color(0,0,0,0)", [1,1,1,_color select 3],_pos, 1, 1, 0,_text, 2,_fontSize,"PuristaSemibold" ]; };
  };
} forEach GVAR(objectives);

// emit event
[QGVAR(draw3D), [_campos]] call EFUNC(event,emit);


////////////////////////////////////////////////////////
// Dead units (skull icon upon death)
////////////////////////////////////////////////////////
{
    _x params ["_unit","_time","_killer","_deadSide","_killerSide","_dName","_kName","_weapon","_isplayer"];

    private _time = time - _time;

    private _pos = (getPosATLVisual _unit);
    if(surfaceIsWater _pos) then {_pos = getPosASLVisual _unit;};
    _pos set [2,(_pos select 2)+1];
    private _name = "";
    if(_isplayer) then {_name = _dName;};
    if(_time <= 10 && {_campos distance2d _pos <= 500}) then {
        drawIcon3D ["\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa", [1,1,1,1 - (0.1 * _time)],_pos, _unitTagSize/2, _unitTagSize/2, 0,_name, 2,0.04,"PuristaSemibold" ];
    };
} forEach GVAR(killedUnits);



////////////////////////////////////////////////////////
// Tracers / grenade / rocket tags
////////////////////////////////////////////////////////

if(!GVAR(tracers)) exitWith {};
{
    _x params ["_object","_posArray","_last","_time","_type"];
    _pos = _posArray select (count _posArray-1);
    if(!isNull _object) then {
        private _pos = (getPosATLVisual _object);
        if(surfaceIsWater _pos) then {_pos = getPosASLVisual _object;};
    };
    _render = (_campos distance2d _pos <= 400);
    if(_type > 0 && _render) then {
        private _icon = switch (_type) do {
            case 1 : { GVAR(grenadeIcon) };
            case 2 : { GVAR(smokeIcon) };
            case 3 : { GVAR(missileIcon) };
        };
        drawIcon3D[_icon,[1,0,0,0.7],_pos,0.5,0.5,0,"",1,0.02,"PuristaSemibold"];
        [_posArray,[1,0,0,0.7]] call CFUNC(drawLines);
    };
    if(GVAR(bulletTrails) && _type == 0 && _render) then {
        [_posArray,[1,0,0,0.7]] call CFUNC(drawLines);
    };
} forEach GVAR(rounds);
