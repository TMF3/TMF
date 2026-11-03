#include "\x\tmf\addons\spectator\script_component.hpp"
// TMF Spectator configured.
private _output = [];

if (!((getMissionConfigValue ["respawn",0] == 1) and ("TMF_Spectator" in (getMissionConfigValue ["respawnTemplates",[]])))) then {
    _output pushBack [0,"TMF spectator is not set up: description.ext needs respawn = 1 and TMF_Spectator in respawnTemplates."];
};



_output
