
#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_map"];

if(!GVAR(showmap)) exitWith {};

with uiNamespace do {
	ctrlSetFocus GVAR(unitlist);
};

// Draw camera location
_map drawIcon ["\A3\ui_f\data\GUI\Rsc\RscDisplayMissionEditor\iconCamera_ca.paa", [0,0,0,1],getpos GVAR(camera),20,20,getDir GVAR(camera),"",0];

{
	// Check if we need to update our location
    _grpCache = _x getVariable [QGVAR(grpCache),[0,[],[1,1,1,1],false]];
    //grpCache format:
    _grpCache params ["_grpTime","_avgpos","_color","_isAI"];
	_fontSize = 0.04;


    if(count _avgpos <= 0 || time > _grpTime) then
    {
        _grpCache = ([_x] call FUNC(updateGroupCache));
    };
    _grpCache params ["_grpTime","_avgpos","_color","_isAI"];




	if(!_isAI) then {
        // if we have a framework orbat marker, use it.
    _twGrpMkr = [_x] call EFUNC(orbat,getGroupMarkerData);
		if(count _twGrpMkr >= 3) then {
      _twGrpMkr params ["_grpTexture","_gname","_grpTextureSize"];
			_map drawIcon [_grpTexture, [1,1,1,1],_avgpos, 32, 32, 0,"", 2,_fontSize,"PuristaSemibold" ];
			_map drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,1],_avgpos, 32, 32, 0,_gname, 2,_fontSize,"PuristaSemibold" ];
			if(_grpTextureSize != "") then {
				_map drawIcon [_grpTextureSize, [1,1,1,1],_avgpos, 32, 32, 0,"", 0,_fontSize,"PuristaSemibold" ];
			};
		}
		else {
			_map drawIcon ["\A3\ui_f\data\map\markers\nato\b_unknown.paa", _color,_avgpos, 32, 32, 0,"", 2,_fontSize,"PuristaSemibold" ];
			_map drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,1],_avgpos, 32, 32, 0,groupID _x, 2,_fontSize,"PuristaSemibold" ];
		};
	};


	_doneVehicles = [];
	{
			if(alive _x && {!(vehicle _x in _doneVehicles)}) then
			{
					_isVeh = false;
					if(vehicle _x != _x) then {
						_x = vehicle _x;
						_doneVehicles pushBack _x;
						_isVeh = true
					};
					_pos = (getPosVisual _x);
					_name = name _x;


					if(_isVeh) then
					{
					    private _vehicleName = _x getVariable [QGVAR(vehiclename),""];
					    if(_vehicleName == "") then {
					        _vehicleName = getText ( configFile >> "CfgVehicles" >> typeOf _x >> "displayname");
					        _x setVariable [QGVAR(vehiclename),_vehicleName];
					    };
					    _name = format ["%1 [%2]",_x getVariable [_vehicleName,""], count crew _x];
					};

					// AI HAVE NO NAMES , HAHAHA
					if(!isPlayer _x) then {_name = ""};
					_format = _x getVariable [QGVAR(nameLabel),0];
					if(!(_format isEqualType 0)) then {
						_name = format[_format,_name];
					};


					_icon = _x getVariable [QGVAR(mapIcon),""];
					if(_icon == "") then {
						_icon = getText (configfile >> "CfgVehicles" >> typeOf (vehicle _x) >> "icon");
						vehicle _x setVariable [QGVAR(mapIcon),_icon];
					};
					_map drawIcon [_icon,_color,_pos,19,19,getdir _x,"",0,0.02,"EtelkaMonospacePro"];
					_map drawIcon ["#(argb,8,8,3)color(0,0,0,0)",_color,_pos,19,19,0,_name,1,0.02,"EtelkaMonospacePro"];

					if(GVAR(showlines)) then {_map drawLine [_pos,_avgpos,_color]};
			};
	} forEach units _x;


} forEach allGroups;

{
	_data = _x getVariable [QGVAR(objectiveData),[]];
	if(count _data > 0) then {
		_data params ["_icon","_text","_color"];
		_fontSize = 0.04;
		_pos = getpos _x;
		_map drawIcon  [_icon, _color,_pos, 32, 32, 0,"", 2,_fontSize,"PuristaSemibold" ];
		if(_text != "") then {
			_map drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,_color select 3],_pos, 32, 32, 0,_text, 2,_fontSize,"PuristaSemibold" ];
		};

	};
} foreach GVAR(objectives);

[QGVAR(draw2D), [_campos]] call EFUNC(event,emit);


{
    _x params ["_unit","_time"];
    _time = time - _time;
    if(_time <= 10) then {
        _map drawIcon ["\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa",[1,1,1,1 - (0.1 * _time)],getpos _unit,16,16,0,""];
    }
    else {
        GVAR(killedUnits) set [_forEachIndex,0];
    };
} foreach GVAR(killedUnits);
GVAR(killedUnits) = GVAR(killedUnits)  - [0];








if(GVAR(tracers)) then {
	{
			_x params ["_object","_posArray","_last"];
			if(!isNull _object) then
			{
			  _initalpos = getPos _object;
			  _futurepos = _initalpos vectorAdd ((vectorDirVisual _object) vectorAdd (velocity _object vectorMultiply 0.3));
			  if((typeof _object) isKindOf "Grenade") then
			  {
			      _icon = "\x\tmf\addons\spectator\images\grenade.paa";
			      if(_object isKindOf "SmokeShell") then {_icon = "\x\tmf\addons\spectator\images\smokegrenade.paa"};
			      _map drawIcon [_icon, [1,0,0,1], _initalpos, 10, 10,0,"",0];
			      if(time > _last) then {
			          _posArray pushBack getPosVisual _object;
			          _last = time+0.5;
			      };
			      _map drawLine [_posArray select 0, getPosVisual _object, [1,0,0,1]];
			  }
			  else
			  {
			      if((typeOf _object) isKindOf "MissileCore" || (typeOf _object) isKindOf "RocketCore") then
			      {
			          _map drawIcon ["\x\tmf\addons\spectator\images\missile.paa", [1,0,0,1], _initalpos, 10, 10, _initalpos getDir _futurepos,"",0,0.02];
			          if(time > _last) then {
			              _posArray pushBack (getPosVisual _object);
			              _last = time+1;
			          };
			          _map drawLine [_posArray select 0, getPosVisual _object, [1,0,0,1]];
			      }
			      else
			      {
			          _map drawLine [_initalpos, _futurepos, [1,0,0,1]];
			      };
			  };
			};
	} forEach GVAR(rounds);
};
