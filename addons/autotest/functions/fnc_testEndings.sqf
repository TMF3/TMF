#include "\x\tmf\addons\autotest\script_component.hpp"

private _output = [];

// Check if endings are set.
if (isClass (missionConfigFile >> "CfgDebriefing" >> "CustomEnding1")) then {
    _output pushBack [1,"The template ending CustomEnding1 is still in description.ext. Replace the CfgDebriefing endings with your own."];
};

_output
