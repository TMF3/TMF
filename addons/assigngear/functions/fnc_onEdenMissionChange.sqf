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

private _fnc_fileExists = {
        disableSerialization;
        private _ctrl = (findDisplay 0) ctrlCreate ["RscHTML", -1];
        _ctrl htmlLoad _this;
        private _exists = ctrlHTMLLoaded _ctrl;
        ctrlDelete _ctrl;
        _exists
};
    
//Cache description.ext
GVAR(descriptionExt) = "";
if ("description.ext" call _fnc_fileExists) then {
    GVAR(descriptionExt) = preprocessFile "description.ext";
};
