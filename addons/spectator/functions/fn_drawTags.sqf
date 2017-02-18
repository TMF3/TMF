#include "\x\tmf\addons\spectator\script_component.hpp"
if (!([] call FUNC(isOpen))) exitWith {};
if (GVAR(showMap) || !GVAR(tags)) exitWith {
    {_x ctrlShow false} forEach GVAR(controls);
};


// enable hud and grab the user settings variables
cameraEffectEnableHUD true;
private _campos = getPosVisual GVAR(camera);
private _grpTagSize = 1 * GVAR(grpTagScale);
private _unitTagSize = 1 * GVAR(unitTagScale);
private _viewDistance = ((getObjectViewDistance) select 0);
private _screenSizeX = (0.04 * safezoneW);
private _screenSizeY = (0.01 * safezoneW);

{
    // grab the group infomation cache
    private _grpCache = _x getVariable [QGVAR(grpCache),[0,[0,0,0],[1,1,1,1],true]];
    _grpCache params ["_grpTime","_avgpos","_color","_isAI"];

    // circumevent the restriction on storing controls in namespace
    private _control = _x getVariable [QGVAR(tagControl), [controlNull]] select 0;
    if (isNull _control) then {
        [_x] call FUNC(createGroupControl);
        _control = _x getVariable [QGVAR(tagControl), [controlNull]] select 0;
    };
    // If we don't have a average pos for the group, or the time since the last the update as expired, generate a new one
    if (count _avgpos <= 0 || time > _grpTime) then {
        _grpCache = ([_x] call FUNC(updateGroupCache));
        _avgpos = _grpCache select 1; // update pos ASAP
    };

    // check if the average pos is on the screen

    private _screenPos = worldToScreen _avgpos;
    private _distToCam = _avgpos distance _campos;
    private _render = !_isAI && {count _screenPos > 0 && _distToCam <= _viewDistance};

    ////////////////////////////////////////////////////////
    // Group tags
    ////////////////////////////////////////////////////////
    // Only draw the icon if the grp tags are "enabled"
    if (_render) then {
        _control ctrlShow true;
        (_control controlsGroupCtrl 2) ctrlShow (!_isAI && _distToCam <= 600);
        (_control controlsGroupCtrl 3) ctrlShow (!_isAI && _distToCam <= 300);

        _control ctrlSetPosition [(_screenPos select 0) - _screenSizeX,(_screenPos select 1) - _screenSizeY];
        _control ctrlCommit 0;
    } else {
        _control ctrlShow false;
    };
    ////////////////////////////////////////////////////////
    // Unit / vehicle tags
    ////////////////////////////////////////////////////////

    {
        private _isVeh = !isNull (objectParent _x);
        private _pos = ([_x] call CFUNC(getPosVisual)) vectorAdd [0,0,3.1];
        // circumevent the restriction on storing controls in namespace
        private _control = _x getVariable [QGVAR(tagControl), [controlNull]] select 0;

        if (_isVeh && {isNull (((objectParent _x) getVariable [QGVAR(tagControl),[controlNull]]) select 0)}) then {
            [objectParent _x] call FUNC(createVehicleControl);
            GVAR(vehicles) pushBackUnique (objectParent _x); // for speed reasons.
        };

        private _screenPos = worldToScreen _pos;
        private _distToCam = _pos distance _campos;

        if (alive _x && count _screenPos > 0 && {!_isVeh && _distToCam <= 500}) then {
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

            (_control controlsGroupCtrl 2) ctrlShow (_isPlayer && _distToCam <= 300);
            (_control controlsGroupCtrl 3) ctrlShow (_isPlayer && _distToCam <= 150);

            // Screenpos already has 2 elements
            _control ctrlSetPosition [(_screenPos select 0) - _screenSizeX,(_screenPos select 1) - _screenSizeY];

            _control ctrlCommit 0;
        } 
        else {
            _control ctrlShow false;
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
    private _distToCam = _pos distance _campos;

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

        private _isAI = {isPlayer _x} count crew _x <= 0;
        (_control controlsGroupCtrl 2) ctrlShow (_distToCam <= 300);
        (_control controlsGroupCtrl 3) ctrlShow (!_isAI && {_distToCam <= 150});

        _control ctrlSetPosition [(_screenPos select 0) - _screenSizeX,(_screenPos select 1) - _screenSizeY];
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
        if (_campos distance2d _pos > 400) then {_fontSize = 0};

        // draw icon
        drawIcon3D [_icon, _color,_pos, 1, 1, 0,"", 2,_fontSize,"PuristaSemibold" ];
        // draw text
        if (_text != "") then { drawIcon3D ["#(argb,1,1,1)color(0,0,0,0)", [1,1,1,_color select 3],_pos, 1, 1, 0,_text, 2,_fontSize,"PuristaSemibold" ]; };
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

    private _pos = [_unit] call CFUNC(getPosVisual);
    _pos set [2,(_pos select 2)+1];
    private _name = "";
    if (_isplayer) then {_name = _dName;};
    if (_time <= 10 && {_campos distance2d _pos <= 500}) then {
        drawIcon3D ["\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa", [1,1,1,1 - (0.1 * _time)],_pos, _unitTagSize/2, _unitTagSize/2, 0,_name, 2,0.04,"PuristaSemibold" ];
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
    private _render = (_campos distance2d _pos <= 400);
    if (_type > 0 && _render) then {
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
