#include "\x\tmf\addons\zeus\script_component.hpp"

[{
    // Exit interface if interface is closed.
    private _display = (findDisplay 312);
    if (isNull _display) exitWith { [_this select 1] call CBA_fnc_removePerFrameHandler; };

    private _curator = (getAssignedCuratorLogic player);
    
    //Add all units to Zeus active.
    if (_curator getVariable [QGVAR(addAllUnits), false]) then {
        (_display displayCtrl IDC_ToggleUnitsZeus) ctrlSetTextColor [0,1,0,1];
    } else {
        (_display displayCtrl IDC_ToggleUnitsZeus) ctrlSetTextColor [1,1,1,1];
    };
    if (_curator getVariable [QGVAR(addAllStatics), false]) then {
        (_display displayCtrl IDC_ToggleStaticsZeus) ctrlSetTextColor [0,1,0,1];
    } else {
        (_display displayCtrl IDC_ToggleStaticsZeus) ctrlSetTextColor [1,1,1,1];
    };
    if (missionNamespace getVariable ["ACRE_IS_SPECTATOR", true]) then {
        (_display displayCtrl IDC_ToggleACRESpectator) ctrlSetTextColor [0,1,0,1];
    } else {
        (_display displayCtrl IDC_ToggleACRESpectator) ctrlSetTextColor [1,1,1,1];
    };
        
}, 0.5, []] call CBA_fnc_addPerFrameHandler;


private _curator = (getAssignedCuratorLogic player);

// Send to server.
_curator remoteExecCall [QFUNC(openedZeusServer),2];
