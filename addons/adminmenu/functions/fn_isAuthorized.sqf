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

#include "\x\tmf\addons\adminmenu\script_component.hpp"

params [["_unit", player]];

private _index = ("true" configClasses (configFile >> QGVAR(authorized_players))) findIf {getText (_x >> "uid") isEqualTo getPlayerUID _unit};

(_index != -1 || {local _unit && [] call BIS_fnc_admin > 0} || {isServer && {admin owner _unit > 0}} || {!isMultiplayer || is3DEN || is3DENMultiplayer})
