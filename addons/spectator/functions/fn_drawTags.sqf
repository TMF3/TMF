#include "\x\tmf\addons\spectator\script_component.hpp"

// enable hud and grab the user settings variables
cameraEffectEnableHUD true;
_campos = getPosVisual GVAR(camera);
_grpTagSize = 1 * GVAR(grpTagScale);
_unitTagSize = 1 * GVAR(unitTagScale);

{

  // grab the group infomation cache
  _grpCache = _x getVariable [QGVAR(grpCache),[0,[],[1,1,1,1],false]];
  _grpCache params ["_grpTime","_avgpos","_color","_isAI"];


  // default fontsize
  _fontSize = 0.04;

  // If we don't have a average pos for the group, or the time since the last the update as expired, generate a new one
  if(count _avgpos <= 0 || time > _grpTime) then
  {
      _grpCache = ([_x] call FUNC(updateGroupCache));
  };
  // reset the cache
  _grpCache params ["_grpTime","_avgpos","_color","_isAI","_isSeen"];

  // check if the average pos is on the screen
  private _render = [_avgpos] call FUNC(onScreen);


  ////////////////////////////////////////////////////////
  // Group tags
  ////////////////////////////////////////////////////////
  // Only draw the icon if the grp tags are "enabled"
  if(_render && !_isAI && _grpTagSize > 0) then {
    if(_campos distance2d _avgpos > 400) then { _fontSize = 0;};

    // get marker data from the teamwork groupmarker system if there is some.
    _twGrpMkr = [_x] call EFUNC(orbat,getGroupMarkerData);

    // if the data exists, read it.
    if(count _twGrpMkr == 3) then {
      _twGrpMkr params ["_grpTexture","_gname","_grpTextureSize"];
      drawIcon3D [_grpTexture, [1,1,1,1],_avgpos,GVAR(grpTagScale),GVAR(grpTagScale), 0,"", 0,_fontSize,"PuristaSemibold" ];
      drawIcon3D ["#(argb,1,1,1)color(0,0,0,0)", [1,1,1,1],_avgpos,GVAR(grpTagScale),GVAR(grpTagScale), 0,_gname, 2,_fontSize,"PuristaSemibold" ];
      if(_grpTextureSize != "") then { drawIcon3D [_grpTextureSize, [1,1,1,1],_avgpos, 1, 1, 0,"", 0,_fontSize,"PuristaSemibold" ];};
    }
    else {
      drawIcon3D ["\A3\ui_f\data\map\markers\nato\b_unknown.paa", _color,_avgpos, _grpTagSize, _grpTagSize, 0,"", 2,_fontSize,"PuristaSemibold" ];
      drawIcon3D ["#(argb,1,1,1)color(0,0,0,0)", [1,1,1,1],_avgpos, _grpTagSize, _grpTagSize, 0,groupID _x, 2,_fontSize,"PuristaSemibold" ];
    };
  };

  ////////////////////////////////////////////////////////
  // Unit / vehicle tags
  ////////////////////////////////////////////////////////

  _renderedVehicles = [];
  {
    _veh = vehicle _x;
    _isVeh = false;
    _render = true;

    // if vehicles, set the appropriate variables
    if(_veh != _x) then {
        _x = _veh;
        _render = ((_renderedVehicles pushBackUnique _x) != -1);
        _isVeh = true;
    };


    _pos = (getPosATLVisual _x);
    if(alive _x && {[_pos] call FUNC(onScreen)} && {_render} && {_campos distance2d _x <= 500}) then {
      if(surfaceIsWater _pos) then {_pos = getPosASLVisual _x;};
      _pos = _pos vectorAdd [0,0,3.1];
      _name = name _x;
      // if we are a vehicle
      if(_isVeh) then {
          // make sure the tag is over the vehicle by using its boundingcenter height
          _pos = _pos vectorAdd [0,0,((boundingCenter _x) select 2)*2];
          // get vehicle name
          private _vehicleName = _x getVariable [QGVAR(vehiclename),""];
          if(_vehicleName == "") then {
              _vehicleName = getText ( configFile >> "CfgVehicles" >> typeOf _x >> "displayname");
              _x setVariable [QGVAR(vehiclename),_vehicleName];
          };
          _name = format ["%1 [%2]",_vehicleName, count crew _x];
      };

      // AI don't arent allowed to have names
      if(!isPlayer _x) then {_name = ""};

      // used to modified the output of the tag text
      _format = _x getVariable [QGVAR(nameLabel),0];
      if(!(_format isEqualType 0)) then {
        _name = format[_format,_name];
      };

      // make the tag white if the target is shooting
      _unitColor = _color;
      if(vehicle _x getVariable [QGVAR(fired), false]) then {
          _unitColor = [0.8,0.8,0.8,0.7];
          vehicle _x setVariable [QGVAR(fired), false];
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
} foreach GVAR(objectives);

// emit event
[QGVAR(draw3D), [_campos]] call EFUNC(event,emit);


////////////////////////////////////////////////////////
// Dead units (skull icon upon death)
////////////////////////////////////////////////////////
{
    if(!(_x isEqualType 0)) then {
        _x params ["_unit","_time","_killer","_deadSide","_killerSide","_dName","_kName"];

        _time = time - _time;

        _pos = (getPosATLVisual _unit);
        if(surfaceIsWater _pos) then {_pos = getPosASLVisual _unit;};
        _pos set [2,(_pos select 2)+1];

        if(_time <= 10 && {_campos distance2d _pos <= 500}) then {
            drawIcon3D ["\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa", [1,1,1,1 - (0.1 * _time)],_pos, _unitTagSize/2, _unitTagSize/2, 0,_dName, 2,0.04,"PuristaSemibold" ];
        }
        else { GVAR(killedUnits) set [_forEachIndex,0]; };
    };
} foreach GVAR(killedUnits);

GVAR(killedUnits) = GVAR(killedUnits)  - [0];

////////////////////////////////////////////////////////
// Tracers / grenade / rocket tags
////////////////////////////////////////////////////////

if(GVAR(tracers)) then {
    _cleanup = false;
    {
        _x params ["_object","_posArray","_last"];
        if(!isNull _object) then {
            private _missile = _object isKindOf "RocketCore" || _object isKindOf "MissileCore";
            private _grenade = !_missile && {_object isKindOf "Grenade"};

            _pos = (getPosATLVisual _object);
            if(surfaceIsWater _pos) then {_pos = getPosASLVisual _object;};

            // missile
            if(_missile) then
            {
              drawIcon3D["\x\tmf\addons\spectator\images\missile.paa",[1,0,0,0.7],_pos,0.5,0.5,0,"",1,0.02,"PuristaSemibold"];
              reverse _posArray;
              _prev = getPosVisual _object;
              {
                  drawLine3D [_prev,_x,[1,0,0,0.7]];
                  _prev = _x;
              } forEach _posArray;
              reverse _posArray;
              if(time > _last) then {
                  _posArray pushBack _pos;
                  _last = time+1;
              };
            };

            // grenade rendering
            if(_grenade && {_campos distance2d _object <= 300}) then {
                _icon = "\x\tmf\addons\spectator\images\grenade.paa";
                if(_object isKindOf "SmokeShell") then {_icon = "\x\tmf\addons\spectator\images\smokegrenade.paa"};

                // draw icon
                drawIcon3D[_icon,[1,0,0,0.7],_pos,0.5,0.5,0,"",1,0.02,"PuristaSemibold"];

                // update the postion array
                _prev = getPosVisual _object;
                if(count _posArray <= 0 || speed _object > 0 ) then {
                  reverse _posArray;
                  {
                      drawLine3D [_prev,_x,[1,0,0,0.7]];
                      _prev = _x;
                  } forEach _posArray;
                  reverse _posArray;
                  if(time > _last) then {
                      _posArray pushBack _pos;
                      _last = time+0.5;
                  };
                };
            };
            GVAR(rounds) set [_forEachIndex,[_object,_posArray,_last]];
        }
        else {
          GVAR(rounds) set [_forEachIndex,objNull];
          _cleanup = true;
        };
  } forEach GVAR(rounds);
  if(_cleanup) then {
    GVAR(rounds) = GVAR(rounds) - [objNull];
  };
};
