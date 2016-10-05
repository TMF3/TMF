#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_map"];

if(!GVAR(showMap)) exitWith {};
with uiNamespace do { ctrlSetFocus GVAR(unitlist); };
// Draw camera location
_map drawIcon ["\A3\ui_f\data\GUI\Rsc\RscDisplayMissionEditor\iconCamera_ca.paa", [0,0,0,1],getPos GVAR(camera),20,20,getDir GVAR(camera),"",0];

{
    // Check if we need to update our location
    private _grpCache = _x getVariable [QGVAR(grpCache),[0,[],[1,1,1,1],false]];
    //grpCache format:
    _grpCache params ["_grpTime","_avgpos","_color","_isAI"];
    private _fontSize = 0.04;

    if(count _avgpos <= 0 || time > _grpTime) then { _grpCache = ([_x] call FUNC(updateGroupCache)); };

    // extract the variables from the cache.
    _grpCache params ["_grpTime","_avgpos","_color","_isAI"];

    // Draw the group marker if we arent an AI group.
    if(!_isAI) then {
        // if we have a framework orbat marker, use it.
        private _twGrpMkr = [_x] call EFUNC(orbat,getGroupMarkerData);
        if(count _twGrpMkr >= 3) then {
            _twGrpMkr params ["_grpTexture","_gname","_grpTextureSize"];
            _map drawIcon [_grpTexture, [1,1,1,1],_avgpos, 32, 32, 0,"", 2,_fontSize,"PuristaSemibold" ];
            _map drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,1],_avgpos, 32, 32, 0,_gname, 2,_fontSize,"PuristaSemibold" ];
            if(_grpTextureSize != "") then { _map drawIcon [_grpTextureSize, [1,1,1,1],_avgpos, 32, 32, 0,"", 0,_fontSize,"PuristaSemibold" ]; };
        }
        else { // here we draw the default icons if TW grp makers arent present
            _map drawIcon ["\A3\ui_f\data\map\markers\nato\b_unknown.paa", _color,_avgpos, 32, 32, 0,"", 2,_fontSize,"PuristaSemibold" ];
            _map drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,1],_avgpos, 32, 32, 0,groupID _x, 2,_fontSize,"PuristaSemibold" ];
        };
    };

    _doneVehicles = [];
    {
        private _isVeh = false;
        private _pos = (getPosVisual _x);
        private _name = name _x;
        _render = true;
        // if vehicles, set the appropriate variables
        if(_veh != _x && effectiveCommander _veh == _x) then {
            _x = vehicle _x;
            _render = ((_renderedVehicles pushBackUnique _x) != -1);
            _isVeh = true;
        };
        if(alive _x && {_render}) then
        {
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

            _icon = _x getVariable [QGVAR(mapIcon),""];
            if(_icon == "") then {
                _icon = getText (configfile >> "CfgVehicles" >> typeOf (vehicle _x) >> "icon");
                _x setVariable [QGVAR(mapIcon),_icon];
            };

            _map drawIcon [_icon,_color,_pos,19,19,getdir _x,"",0,0.02,"EtelkaMonospacePro"];
            _map drawIcon ["#(argb,8,8,3)color(0,0,0,0)",_color,_pos,19,19,0,_name,1,0.02,"EtelkaMonospacePro"];
            if(GVAR(showlines)) then {_map drawLine [_pos,_avgpos,_color]};
        };
    } forEach units _x;
} forEach allGroups;

{
    private _data = _x getVariable [QGVAR(objectiveData),[]];
    if(count _data > 0) then {
        _data params ["_icon","_text","_color"];
        private _pos = getpos _x;
        _map drawIcon  [_icon, _color,_pos, 32, 32, 0,"", 2,0.04,"PuristaSemibold" ];
        if(_text != "") then {
            _map drawIcon ["#(argb,8,8,3)color(0,0,0,0)", [1,1,1,_color select 3],_pos, 32, 32, 0,_text, 2,0.04,"PuristaSemibold" ];
        };
    };
} foreach GVAR(objectives);




{
    if(!(_x isEqualType 0)) then {
        _x params ["_unit","_time"];
        _time = time - _time;
        if(_time <= 10) then {
            _map drawIcon ["\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa",[1,1,1,1 - (0.1 * _time)],getpos _unit,16,16,0,""];
        };
    };
} foreach GVAR(killedUnits);


if(GVAR(tracers)) then {
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
            _map drawIcon [_icon, [1,0,0,1], _pos, 10, 10,0,"",0];
            _map drawLine [_posArray select 0, _pos, [1,0,0,1]];
        }
        if(_type == 1 && !isNull _object) then {
             _futurepos = _pos vectorAdd ((vectorDirVisual _object) vectorAdd (velocity _object vectorMultiply 0.3));
             _map drawLine [_pos, _futurepos, [1,0,0,1]];
        };
    } forEach GVAR(rounds);
};
[QGVAR(draw2D), [_campos]] call EFUNC(event,emit);
