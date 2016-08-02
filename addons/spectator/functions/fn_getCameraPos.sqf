
#include "\x\tmf\addons\spectator\script_component.hpp"
_pos = [];
switch (GVAR(mode)) do {
    case 0: {
    	_pos = getpos GVAR(target) vectoradd GVAR(relpos);
    };
    case 1: {
    	_pos = getpos GVAR(freecam);
    };
    default {
     	/* STATEMENT */
    };
};
_pos