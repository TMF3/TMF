#include "\x\tmf\addons\spectator\script_component.hpp"
/*
 * Author: Head
 * Handles mode switching
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 *
 * Public: Not really
 */
switch(GVAR(mode)) do {
    case FREECAM : {
        if(GVAR(followCameraEnabled)) exitWith {
            GVAR(mode) = FOLLOWCAM;
            private _pitch = (GVAR(camera) call BIS_fnc_getPitchBank) select 0;
            GVAR(followcam_angle) = [(getDir GVAR(camera) + 180) mod 360,(_pitch+180) mod 360];
        };
        if(GVAR(firstPersonCameraEnabled)) exitWith {
            GVAR(mode) = FIRSTPERSON;
        };
    };
    case FOLLOWCAM: {
        if(GVAR(freeCameraEnabled)) exitWith {
            GVAR(mode) = FREECAM;
            GVAR(followcam_angle) = [getDir GVAR(camera), (GVAR(camera) call BIS_fnc_getPitchBank) select 0];
        };
        if(GVAR(firstPersonCameraEnabled)) exitWith {
            GVAR(mode) = FIRSTPERSON;
        };
    };
    case FIRSTPERSON: {
        if(GVAR(freeCameraEnabled)) exitWith {
            GVAR(mode) = FREECAM;
        };
        if(GVAR(followCameraEnabled)) exitWith {
            GVAR(mode) = FOLLOWCAM;
        };
    };
};