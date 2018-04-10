/*
 * Name: TMF_common_fnc_sideToTexture
 * Author: Snippers
 *
 * Arguments:
 * side
 *
 * Return:
 * string: Texture
 *
 * Description:
 * Will return a texture for the given side.
 */

if (_this == west) exitWith {"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_west_ca.paa";};
if (_this == east) exitWith {"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_east_ca.paa";};
if (_this == independent) exitWith {"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_guer_ca.paa";};
if (_this == civilian) exitWith {"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_civ_ca.paa";};
if (_this == sideLogic) exitWith {"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_custom_ca.paa";};
"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_empty_ca.paa"