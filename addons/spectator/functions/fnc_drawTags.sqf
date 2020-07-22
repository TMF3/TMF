#include "\x\tmf\addons\spectator\script_component.hpp"
if (!([] call FUNC(isOpen))) exitWith {};
if (GVAR(showMap) || !GVAR(tags)) exitWith {
    {_x ctrlShow false} forEach GVAR(controls);
};


// enable hud and grab the user settings variables
cameraEffectEnableHUD true;
private _camPos = getPosVisual GVAR(camera);
private _viewDistance = ((getObjectViewDistance) select 0);
private _screenSize = [(0.04 * safezoneW), (0.01 * safezoneH)];

{
    // grab the group infomation cache
    private _grpCache = _x getVariable [QGVAR(grpCache),[[0,0,0],[1,1,1,1],true]];
    _grpCache params ["_grpPos","_color","_isAI"];
    // If we don't have a average pos for the group, or the time since the last the update as expired, generate a new one
    if (count _grpPos <= 0) then {
        _grpCache = ([_x] call FUNC(updateGroupCache));
        _grpPos = _grpCache select 1; // update pos ASAP
    };

    // check if the average pos is on the screen
    private _screenPos = worldToScreen _grpPos;
    private _distToCam = _grpPos distance _camPos;
    private _render = (GVAR(showGroupMarkers) == 1 || !_isAI) && {count _screenPos > 0 && _distToCam <= _viewDistance};

    // circumevent the restriction on storing controls in namespace
    private _control = _x getVariable [QGVAR(tagControl), [controlNull]] select 0;
    if (isNull _control && (GVAR(showGroupMarkers) == 1 || !_isAI)) then {
        [_x] call FUNC(createGroupControl);
        _control = _x getVariable [QGVAR(tagControl), [controlNull]] select 0;
    };

    // Render group marker

    if (_render) then {
        _control ctrlShow true;
        (_control controlsGroupCtrl 2) ctrlShow (!_isAI && _distToCam <= 600); // Nametag
        (_control controlsGroupCtrl 3) ctrlShow (!_isAI && _distToCam <= 300); // Detail

        _control ctrlSetPosition [_screenPos # 0 - _screenSize # 0, _screenPos # 1 - _screenSize # 1];
        _control ctrlCommit 0;
    } else {
        _control ctrlShow false;
    };
    
    // Unit / vehicle tags
    {
        private _isVeh = !isNull (objectParent _x);
        private _control = _x getVariable [QGVAR(tagControl), [controlNull]] select 0;

        if (_isVeh) then {
            GVAR(vehicles) pushBackUnique (objectParent _x); // for speed reasons.
            _control ctrlShow false;
        } else {
            if (alive _x) then {
                private _pos = ([_x] call CFUNC(getPosVisual)) vectorAdd [0,0,3.1];
                private _screenPos = worldToScreen _pos;
                private _distToCam = _pos distance _camPos;

                // circumevent the restriction on storing controls in namespace

                if (count _screenPos > 0 && _distToCam <= 500) then {
                    if (isNull _control) then {
                        [_x] call FUNC(createUnitControl);
                        _control = _x getVariable [QGVAR(tagControl), [controlNull]] select 0;
                    };
                    private _unitColor = _color;
                    private _hasFired = _x getVariable [QGVAR(fired), 0];
                    if (_hasFired > 0) then {
                        _unitColor = [0.8,0.8,0.8,1];
                        _x setVariable [QGVAR(fired), _hasFired-1];
                    };

                    [_control,"",_unitColor] call FUNC(controlSetPicture);

                    _control ctrlShow true;

                    private _isPlayer = isPlayer _x;

                    (_control controlsGroupCtrl 2) ctrlShow (_isPlayer && _distToCam <= 300); // NameTag
                    (_control controlsGroupCtrl 3) ctrlShow (_isPlayer && _distToCam <= 150); // Detail

                    // Screenpos already has 2 elements
                    
                    _control ctrlSetPosition [_screenPos # 0 - _screenSize # 0, _screenPos # 1 - _screenSize # 1];

                    _control ctrlCommit 0;
                }
                else {
                    _control ctrlShow false;
                };
            } else {
                //Unit is dead.
                _x setVariable [QGVAR(tagControl), nil];
                ctrlDelete _control;
            };

        };


    } forEach units _x;
} forEach allGroups;


{
    private _pos = ([_x] call CFUNC(getPosVisual)) vectorAdd [0,0,2 + (((boundingBox _x) select 1) select 2)];
    // circumevent the restriction on storing controls in namespace
    private _control = _x getVariable [QGVAR(tagControl), [controlNull]] select 0;
    if (isNull _control) then {
        [_x] call FUNC(createVehicleControl);
        _control = _x getVariable [QGVAR(tagControl), [controlNull]] select 0;
    };

    private _screenPos = worldToScreen _pos;
    private _distToCam = _pos distance _camPos;

    if (alive _x && count _screenPos > 0 && {({alive _x} count crew _x) > 0} && {_distToCam <= 500} ) then {
        private _color = (side _x) call CFUNC(sideToColor);
        private _hasFired = _x getVariable [QGVAR(fired), 0];
        if (_hasFired > 0) then {
            _color = [0.8,0.8,0.8,1];
            _x setVariable [QGVAR(fired), _hasFired-1];
        };
        [_control,"",_color] call FUNC(controlSetPicture);

        private _commanderName = name (effectiveCommander _x);

        [_control,format ["%1 [%2]",_commanderName,count crew _x],[],true] call FUNC(controlSetText);

        _control ctrlShow true;

        private _hasPlayers = (crew _x findIf {isPlayer _x}) >= 0;
        (_control controlsGroupCtrl 2) ctrlShow (_distToCam <= 300);
        (_control controlsGroupCtrl 3) ctrlShow (_hasPlayers && {_distToCam <= 150});

        _control ctrlSetPosition [_screenPos # 0 - _screenSize # 0, _screenPos # 1 - _screenSize # 1];
        _control ctrlCommit 0;
    }
    else {
        _control ctrlShow false;
    };
} forEach GVAR(vehicles);



////////////////////////////////////////////////////////
// Objectives tags
////////////////////////////////////////////////////////
{
    private _data = _x getVariable [QGVAR(objectiveData),[]];
    if (count _data > 0) then {
        _data params ["_icon","_text","_color"];
        private _fontSize = 0.04;

        private _pos = ([_x] call CFUNC(getPosVisual));
        if (_camPos distance2d _pos > 400) then {_fontSize = 0};

        // draw icon
        drawIcon3D [_icon, _color,_pos, 1, 1, 0,"", 2,_fontSize,"PuristaSemibold" ];
        // draw text
        if (_text != "") then { drawIcon3D ["#(argb,1,1,1)color(0,0,0,0)", [1,1,1,_color select 3],_pos, 1, 1, 0,_text, 2,_fontSize,"PuristaSemibold" ]; };
    };
} forEach GVAR(objectives);

////////////////////////////////////////////////////////
// Dead units (skull icon upon death)
////////////////////////////////////////////////////////
{
    _x params ["_unit","_time","_killer","_deadSide","_killerSide","_dName","_kName","_weapon","_isplayer"];

    private _time = time - _time;

    private _pos = [_unit] call CFUNC(getPosVisual);
    _pos set [2,(_pos select 2)+1];
    private _name = "";
    if (_isplayer) then {_name = _dName;};
    if (_time <= 10 && {_camPos distance2d _pos <= 500}) then {
        drawIcon3D ["\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa", [1,1,1,1 - (0.1 * _time)],_pos, 0.5, 0.5, 0,_name, 2,0.04,"PuristaSemibold" ];
    };
} forEach GVAR(killedUnits);



////////////////////////////////////////////////////////
// Tracers / grenade / rocket tags
////////////////////////////////////////////////////////

if(!GVAR(tracers)) exitWith {};
{
    _x params ["_object","_posArray","_last","_time","_type"];
    private _pos = _posArray select (count _posArray-1);
    if (!isNull _object) then {
        private _pos = [_object] call CFUNC(getPosVisual);
    };
    private _render = (_camPos distance2d _pos <= 400);
    if (_type > 0 && _render) then {
        private _icon = switch (_type) do {
            case 1 : { GRENADE_ICON };
            case 2 : { SMOKE_ICON };
            case 3 : { MISSILE_ICON };
        };
        drawIcon3D[_icon,[1,0,0,0.7],_pos,0.5,0.5,0,"",1,0.02,"PuristaSemibold"];
        [_posArray,[1,0,0,0.7]] call CFUNC(drawLines);
    };
    if(GVAR(bulletTrails) && _type == 0 && _render) then {
        [_posArray,[1,0,0,0.7]] call CFUNC(drawLines);
    };
} forEach GVAR(rounds);

// emit event
[QGVAR(draw3D), [_camPos]] call CBA_fnc_localEvent;