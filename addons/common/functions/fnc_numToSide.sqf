/*
 * Name: TMF_common_fnc_numToSide
 * Author: Snippers
 *
 * Arguments:
 * scalar
 *
 * Return:
 * side
 *
 * Description:
 * Will return the side associated with the number as used by the BI configs. This allows lookup interaction with the side property for factions in factionclasses.
 */

_this = ((_this max 0) min 9);

[east, west, independent, civilian, sideUnknown, sideEnemy, sideFriendly, sideLogic, sideEmpty, sideAmbientLife] select _this;
