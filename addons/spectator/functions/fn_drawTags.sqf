#include "\x\tmf\addons\spectator\script_component.hpp"

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


  // default fontsize
  private _fontSize = 0.04;

  // If we don't have a average pos for the group, or the time since the last the update as expired, generate a new one
  if(count _avgpos <= 0 || time > _grpTime) then
  {
      _grpCache = ([_x] call FUNC(updateGroupCache));
      _avgpos = _grpCache select 1; // update pos ASAP
  };
  // reset the cache


  // check if the average pos is on the screen
  private _render = [_avgpos] call FUNC(onScreen);


  ////////////////////////////////////////////////////////
  // Group tags
  ////////////////////////////////////////////////////////
  // Only draw the icon if the grp tags are "enabled"
  if(_render && {_renderGroups && !_isAI}) then { //
    if(_campos distance2d _avgpos > 400) then { _fontSize = 0;};

    // get marker data from the teamwork groupmarker system if there is some.
    private _twGrpMkr = [_x] call EFUNC(orbat,getGroupMarkerData);

    // if the data exists, read it.
    if(count _twGrpMkr == 3) then {
      _twGrpMkr params ["_grpTexture","_gname","_grpTextureSize"];
      drawIcon3D [_grpTexture, [1,1,1,1],_avgpos,_grpTagSize,_grpTagSize, 0,_gname, 2,_fontSize,"PuristaSemibold" ];
    }
    else {
      drawIcon3D ["\A3\ui_f\data\map\markers\nato\b_unknown.paa", _color,_avgpos, _grpTagSize, _grpTagSize, 0,"", 2,_fontSize,"PuristaSemibold" ];
      drawIcon3D ["#(argb,1,1,1)color(0,0,0,0)", [1,1,1,1],_avgpos, _grpTagSize, _grpTagSize, 0,groupID _x, 2,_fontSize,"PuristaSemibold" ];
    };
  };

  ////////////////////////////////////////////////////////
  // Unit / vehicle tags
  ////////////////////////////////////////////////////////

  private _renderedVehicles = [];
  {
    private _veh = vehicle _x;
    private _isVeh = false;
    _render = true;

    // if vehicles, set the appropriate variables
    if(_veh != _x && effectiveCommander _veh == _x) then {
        _x = _veh;
        _render = ((_renderedVehicles pushBackUnique _x) != -1);
        _isVeh = true;
    };

    private _pos = (getPosATLVisual _x);

    if(alive _x && {[_pos] call FUNC(onScreen)} && {_render} && {_campos distance2d _x <= 500} ) then {

        if(_isVeh) then {
            private _vehicleName = _x getVariable [QGVAR(vehiclename),""];
            if(_vehicleName == "") then {
                _vehicleName = getText ( configFile >> "CfgVehicles" >> typeOf _x >> "displayname");
                _x setVariable [QGVAR(vehiclename),_vehicleName];
            };
            if(isPlayer _x) then {
                _vehicleName = name (effectiveCommander _x);
            };
            _name = format ["%1 [%2]",_vehicleName, count crew _x];
        };

        // AI HAVE NO NAMES, THEY ARE DRIVING A VEHICLE
        if(!isPlayer _x && !_isVeh) then {_name = ""}
        else {
            _format = _x getVariable [QGVAR(nameLabel),0]; // can we omit this?, most missions don't use it
            if(!(_format isEqualType 0)) then { _name = format[_format,_name]; }; // passes name to the format
        };

      if(surfaceIsWater _pos) then {_pos = getPosASLVisual _x;};
      _pos = _pos vectorAdd [0,0,3.1];

      // make the tag white if the target is shooting
      private _unitColor = _color;
      private _hasFired = _veh getVariable [QGVAR(fired), 0];
      if(_hasFired > 0) then {
          _unitColor = [0.8,0.8,0.8,0.7];
          _veh setVariable [QGVAR(fired), _hasFired-1];
      };

      // draw icon
      drawIcon3D["\A3\ui_f\data\map\markers\military\triangle_CA.paa",_unitColor,_pos,_unitTagSize,_unitTagSize,180,"",2,0.03,"PuristaSemibold"];
      // draw text
      if(_name != "") then { drawIcon3D["#(argb,1,1,1)color(0,0,0,0)", [1,1,1,1],_pos,_unitTagSize/2,_unitTagSize/2,0,_name,2,0.03,"PuristaSemibold"];};

      // if showing the group lines, draw it.
      if(GVAR(showlines) && !_isAI) then {drawLine3D [_pos,_avgpos,_color]};
    };
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
    if(!(_x isEqualType 0)) then {
        _x params ["_unit","_time","_killer","_deadSide","_killerSide","_dName","_kName"];

        _time = time - _time;

        private _pos = (getPosATLVisual _unit);
        if(surfaceIsWater _pos) then {_pos = getPosASLVisual _unit;};
        _pos set [2,(_pos select 2)+1];

        if(_time <= 10 && {_campos distance2d _pos <= 500}) then {
            drawIcon3D ["\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa", [1,1,1,1 - (0.1 * _time)],_pos, _unitTagSize/2, _unitTagSize/2, 0,_dName, 2,0.04,"PuristaSemibold" ];
        };
    };
} forEach GVAR(killedUnits);



////////////////////////////////////////////////////////
// Tracers / grenade / rocket tags
////////////////////////////////////////////////////////

if(!GVAR(tracers)) exitWith {}:
{
    _x params ["_object","_posArray","_last","_type"];
    _pos = _posArray select (count _posArray-1);
    if(!isNull _object) then {
        private _pos = (getPosATLVisual _object);
        if(surfaceIsWater _pos) then {_pos = getPosASLVisual _object;};
    };
    if(_type > 0) then {
        private _icon = switch (_type) do {
            case 1 : {GVAR(grenadeIcon)};
            case 2 : {GVAR(smokegrenade)};
            case 3 : {GVAR(grenadeIcon)};
        };
        drawIcon3D[_icon,[1,0,0,0.7],_pos,0.5,0.5,0,"",1,0.02,"PuristaSemibold"];
        [_posArray,[1,0,0,0.7]] call CFUNC(drawLines);
    }
    if(GVAR(bulletTrails) && _type == 1) then {
        [_posArray,[1,0,0,0.7]] call CFUNC(drawLines);
    };
} forEach GVAR(rounds);
