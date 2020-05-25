#include "\x\tmf\addons\orbat\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_orbat_fnc_setMarkerUpdateInterval

Description:
    Sets the orbat marker update interval.
    Local function.

Parameters:
    _interval - Time in seconds between updates. 0 for every frame. [Number]

Returns:
    New per frame handle. -1 if not created.

Author:
    Freddo
---------------------------------------------------------------------------- */

params [["_interval",3,[-1]],["_global",false,[false]]];

if (_global) then {
    // Places this on the JIP queue with a predefined ID.
    // Any other entries with the same ID will be overwritten.
    [_interval,false] remoteExecCall [QFUNC(setMarkerUpdateInterval),0,QGVAR(markerUpdateInterval)];
};

LOG_1("Setting new marker update interval",_interval);

GVAR(markerUpdateInterval) = _interval;

if (isNil QGVAR(PFHandler) || !(time > 0)) exitWith {-1};

// Remove old handler
[GVAR(PFHandler)] call CBA_fnc_removePerFrameHandler;

// Add new handler
GVAR(PFHandler) = [FUNC(PFHUpdate), GVAR(markerUpdateInterval), []] call CBA_fnc_addPerFrameHandler;
TRACE_1("New marker PFH",GVAR(PFHandler));

// Return handle
GVAR(PFHandler)
