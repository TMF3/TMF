#include "\x\tmf\addons\autotest\script_component.hpp"

private _output = [];

// Check if endings are set.
if (isClass (missionConfigFile >> "CfgDebriefing" >> "CustomEnding1")) then {
    _output pushBack [1,"CustomEnding1 is still present. Mission endings are probably not configured."];
};

_output
