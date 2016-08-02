/*
 * Name: TMF_common_fnc_isAdmin
 * Author: Snippers
 *
 * Arguments:
 * None
 *
 * Return:
 * boolean
 *
 * Description:
 * Use this function to determine if the local client is admin
 */
 
private _return = false;

if (isServer or serverCommandAvailable "#kick") then {
	_return = true;
};

// Check 1Tac Admin IDs.
if (!isNil "tac1_adminIDs") then {
	if ( (getPlayerUID player) in tac1_adminIDs) then {
		_return = true;
	};
}; 

_return