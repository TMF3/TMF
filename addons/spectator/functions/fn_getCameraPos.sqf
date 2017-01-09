
#include "\x\tmf\addons\spectator\script_component.hpp"
private _pos = [];
switch (GVAR(mode)) do {
    case FOLLOWCAM: {
        _pos = getPos GVAR(target) vectorAdd GVAR(relpos);
    };
    case FREECAM: {
        _pos = getPos GVAR(freeCam);
    };
    default {
    };
};
_pos
