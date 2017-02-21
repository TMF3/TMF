/*
 * Name = TMF_assignGear_fnc_onEdenMessageRecieved
 * Author = Snippers
 *
 * Arguments:
 * UI function do not use
 *
 * Return:
 * UI function do not use
 *
 * Description:
 * When a message is recieved
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"

params ["_messageId"];
private _return = false;

if (_messageId isEqualTo 0) then { //Mission saved.
    if (isNil QGVAR(descriptionExt)) then { GVAR(descriptionExt) = "";}; // on mission load will be niled.

    private _fnc_fileExists = {
        disableSerialization;
        private _ctrl = (findDisplay 0) ctrlCreate ["RscHTML", -1];
        _ctrl htmlLoad _this;
        private _exists = ctrlHTMLLoaded _ctrl;
        ctrlDelete _ctrl;
        _exists
    };

    if ("description.ext" call _fnc_fileExists) then {
        // Check if description.ext has changed
        private _newdescription = preprocessFile "description.ext";
        if (!(_newdescription isEqualTo GVAR(descriptionExt))) then {


            //Re-apply gear attributes to take care of potential gear changes.
            {
                (_x get3DENAttribute "TMF_assignGear_full") params ["_value"];
                [_x,_value] call tmf_assignGear_fnc_helper;
            } forEach (allUnits);
            GVAR(descriptionExt) = _newdescription;
            ["Scenario Saved - description.ext changed, reapplying TMF gear"] call BIS_fnc_3DENNotification;
            _return = true;
        };
    } else {
        GVAR(descriptionExt) = "";
    };
    
};

_return;
