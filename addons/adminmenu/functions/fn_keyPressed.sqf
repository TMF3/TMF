#include "\x\tmf\addons\adminmenu\script_component.hpp"

systemChat "[TMF Admin Menu] Key pressed";

GVAR(fromSpectator) = !isNull (findDisplay 5454);

_authorized = true;
if (_authorized || isServer) then {
    if (dialog && !isNull (findDisplay IDD_TMF_ADMINMENU)) exitWith {
        systemChat "[TMF Admin Menu] The dialog is already open"
    };

    if (isNull (findDisplay 312)) then {
        /*if (!isNil "tmf_spectator_fnc_init") then {
            if ((random 1) > 0.5) then {
                closeDialog 5454;
                systemChat "[TMF Admin Menu] Attempted closing TMF Spectator /dialog";
            } else {
                (findDisplay 5454) closeDisplay 1;
                systemChat "[TMF Admin Menu] Attempted closing TMF Spectator /display";
            };
        };*/

        if ((random 1) > 0.5) then {
            createDialog QUOTE(ADDON);
            systemChat "[TMF Admin Menu] Attempted opening /immediate";
        } else {
            [{
                createDialog QUOTE(ADDON);
                systemChat "[TMF Admin Menu] Attempted opening /nextframe";
            }, 0] call CBA_fnc_execNextFrame;
        };
    } else {
        systemChat "[TMF Admin Menu] Can't open the admin menu while in Zeus";
    };
} else {
    systemChat "[TMF Admin Menu] You're not authorized to use the admin menu";
};

true;
