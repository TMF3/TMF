#include "\x\tmf\addons\adminmenu\script_component.hpp"
/*
 * Name = TMF_adminmenu_fnc_isAuthorized
 * Author = Freddo
 *
 * Parameters:
 * 0: Object. - Object to check
 *
 * Description:
 * Checks if player is defined as an admin in
 * class TMF_adminMenu_authorized_players
 *
 * If executed on server then will check if the remote object is a logged in admin.
 * If executed on a object local to the client, then it will check if the client is
 * a logged in admin.
 *
 * Return:
 * Boolean. - Whether player is an authorized admin
 */
params [["_unit", player,[objNull]], ["_perm","",[""]]];

TRACE_2("Checking if unit is authorized",_unit,_perm);

private _uid = getPlayerUID _unit;
private _classes = "true" configClasses (configFile >> QGVAR(authorized_players));
private _index = _classes findIf {getText (_x >> "uid") isEqualTo getPlayerUID _unit};

#ifdef DEBUG_MODE_FULL
private _authorized = switch true do {
#else
switch true do {
#endif
    case (isServer);
    case (!hasInterface);
    case ((local _unit || isNull _unit) && {[] call BIS_fnc_admin > 0});
    // Check if remote client is admin (only available for servers)
    case (isServer && {admin owner _unit > 0});
    case (!isMultiplayer);
    case (is3DEN);
    case (is3DENPreview): {true};

    // Player UID listed in authorized_players config
    case (_index != -1): {
        if (_perm != "") then {
            // Check specific permission
            private _class = _classes # _index;

            [_class,_perm] call FUNC(checkPermission)
        } else {
            // Overall true
            true
        };
    };

    default {false};
#ifndef DEBUG_MODE_FULL
}; // Because otherwise github validation fails
#else
};
TRACE_1("Authorization check complete",_authorized);
#endif
