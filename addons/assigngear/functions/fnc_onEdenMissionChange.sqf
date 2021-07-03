#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_onEdenMissionChange
 * Author = Snippers
 *
 * Arguments:
 * UI function do not use
 *
 * Return:
 * UI function do not use
 *
 * Description:
 * When a mission is changed.
 */
    
//Cache description.ext
GVAR(descriptionExt) = "";
if (fileExists "description.ext") then {
    GVAR(descriptionExt) = preprocessFile "description.ext";
};
