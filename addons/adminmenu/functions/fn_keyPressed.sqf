#include "\x\tmf\addons\adminmenu\script_component.hpp"

systemChat "[TMF Admin Menu] Key pressed";

if (((getPlayerUID player) in (getArray (configFile >> QGVAR(authorized_uids)))) || (serverCommandAvailable "#kick") || isServer) then {
    if (dialog && !isNull (findDisplay IDD_TMF_ADMINMENU)) exitWith {
        systemChat "[TMF Admin Menu] The dialog is already open"
    };

    GVAR(fromSpectator) = !isNull (findDisplay 5454);

    if (isNull (findDisplay 312)) then {
        createDialog QUOTE(ADDON);
    } else {
        systemChat "[TMF Admin Menu] Can't open the admin menu in the Zeus interface";
    };
} else {
    systemChat "[TMF Admin Menu] You're not authorized to use the admin menu";
};

true;
