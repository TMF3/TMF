#include "\x\tmf\addons\zeus\script_component.hpp"

private _curator = (getAssignedCuratorLogic player);

// Send to server.
_curator remoteExecCall [QFUNC(toggleAllUnitsZeusServer),2];

