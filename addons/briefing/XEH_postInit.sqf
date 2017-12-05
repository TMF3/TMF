#include "\x\tmf\addons\briefing\script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(addLoadoutNotes) = getMissionConfigValue ["TMF_Briefing_Loadout",false];

//Ensure there is a delay...
//GVAR(briefingFrame) = 0;

//CBA PFH executes immedietly so force a delay.

[{
    if ([] call BIS_fnc_isLoading) exitWith {};
    [_this select 1] call CBA_fnc_removePerFrameHandler;

   // [{
        [{
            if (isNull player) exitWith {};
            if (isNil QEGVAR(common,VarSync)) exitWith {};
            //if (GVAR(briefingFrame) == 0) exitWith {GVAR(briefingFrame) = 1;};

            [player] call FUNC(generateBriefing);

            [_this select 1] call CBA_fnc_removePerFrameHandler;
            //GVAR(briefingFrame) = nil;
        }, 1] call CBA_fnc_addPerFrameHandler;

    //},[],15] call CBA_fnc_waitAndExecute;
}, 1] call CBA_fnc_addPerFrameHandler;  
