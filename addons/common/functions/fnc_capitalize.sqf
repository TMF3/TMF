/*
 * Name: TMF_common_fnc_capitalize
 * Author: Head
 *
 * Arguments:
 * String
 *
 * Return:
 * String with capatalized first letter
 *
 * Description:
 * Magic
 */
params ["_str"];
private _arr = toArray _str;
_arr set [0,(toArray (toUpper(_str select [0,1]))) select 0];
toString  _arr
