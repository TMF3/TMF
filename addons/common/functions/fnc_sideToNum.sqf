/*
 * Name: TMF_common_fnc_sideToNum
 * Author: Snippers
 *
 * Arguments:
 * side
 *
 * Return:
 * scalar
 *
 * Description:
 * Will return the number associated to a side as used by the BI configs. This allows lookup interaction with the side property for factions in factionclasses.
 */

private _return = [east, west, independent, civilian, sideUnknown, sideEnemy, sideFriendly, sideLogic, sideEmpty, sideAmbientLife] find _this;

if (_return isEqualTo -1) then {
    _return = 4; // sideUnknown
};

_return;