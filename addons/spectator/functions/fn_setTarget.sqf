
#include "\x\tmf\addons\spectator\script_component.hpp"
params [["_target",GVAR(target),[objNull]]];



_oldunit = GVAR(target);
GVAR(target) = _target;

switch (GVAR(mode)) do {
    case 0: {
        GVAR(camera) cameraEffect ["internal","back"];
        selectPlayer tmf_spectator_unit;
    };

    case 1: {
        GVAR(camera) cameraEffect ["internal","back"];
        selectPlayer GVAR(unit);
        if(_target == _oldunit) exitWith {};
        (getpos GVAR(target)) params ["_x","_y","_z"];

        _xrand = random 15;
        if(random 1 > 0.5) then { _xrand = -_xrand;};
        _yrand = random 15;
        if(random 1 > 0.5) then { _yrand = -_yrand;};

        GVAR(camera) setPosASL [_x+_xrand,_y+_yrand,(_z max getTerrainHeightASL[_x,_y])+2];
        _dir = (getPos GVAR(camera)) getDir (getpos GVAR(target));
        GVAR(followcam_angle) set [0,_dir];
    };
    case 2: {
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
