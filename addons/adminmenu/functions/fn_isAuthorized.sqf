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
 * Return:
 * Boolean. - Whether player is an authorized admin
 */

#include "\x\tmf\addons\adminmenu\script_component.hpp"

params [["_unit", player]];

private _index = ("true" configClasses (configFile >> QGVAR(authorized_players))) findIf {getText (_x >> "uid") isEqualTo getPlayerUID _unit};

!(_index isEqualTo -1)
