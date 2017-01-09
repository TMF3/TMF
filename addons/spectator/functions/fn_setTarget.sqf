
#include "\x\tmf\addons\spectator\script_component.hpp"
params [["_target",GVAR(target),[objNull]]];

if(isNull _target) exitWith {};

_oldunit = GVAR(target);
GVAR(target) = _target;

switch (GVAR(mode)) do {
    case FOLLOWCAM: {
        GVAR(camera) cameraEffect ["internal","back"];
        selectPlayer tmf_spectator_unit;
    };

    case FREECAM: {
        GVAR(camera) cameraEffect ["internal","back"];
        selectPlayer GVAR(unit);
        if(_target == _oldunit) exitWith {};
        private _camPos = getPosASL GVAR(camera);
        private _targetPos = getPosASL GVAR(target);
        private _newPos = _targetPos vectorAdd ((vectorNormalized (_camPos vectorDiff _targetPos)) vectorMultiply 30);/*_camPos vectorAdd ((_targetPos vectorDiff _camPos) vectorMultiply 0.5);*/
        _newPos params ["_x","_y","_z"];
        
        _camPos = [_x,_y,(_z max (getTerrainHeightASL[_x,_y] + 10))];
        GVAR(camera) setPosASL _camPos;
        _dir = (getPos GVAR(camera)) getDir (getpos GVAR(target));
       // GVAR(camera) setDir _dir;
        private _angleY = atan (((_targetPos select 2) - (_camPos select 2))/ (_camPos distance2D _targetPos));
        GVAR(followcam_angle) = [_dir,_angleY];
    };
    case FIRSTPERSON: {
        GVAR(target) SwitchCamera "internal";
        if(vehicle GVAR(target) != GVAR(target)) then
        {
            _vehicle = vehicle GVAR(target);
            _mode = "internal";
            if((assignedVehicleRole GVAR(target) select 0) != "Cargo") then {_mode = "gunner"};
            _vehicle switchCamera _mode;
        };
        GVAR(camera) cameraEffect ["Terminate","back"];
    };
};

if(GVAR(showMap)) then {
    if(_target == _oldunit) exitWith {};
    with uiNamespace do {
        GVAR(map) ctrlMapAnimAdd [0.3,ctrlMapScale GVAR(map),_target ];
        ctrlMapAnimCommit GVAR(map);
    };
};