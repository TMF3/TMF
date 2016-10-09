/*
 * Name: TMF_common_fnc_numToColor
 * Author: Snippers
 *
 * Arguments:
 * scalar
 *
 * Return:
 * array: color array
 *
 * Description:
 * Use this function to extract bright colours to display to the user for indicating relationship between elements. This is used in the ACRE2 briefing pages to illustrate the connection between assigned radios to different radio channels.
 */

params["_number"];
private _color = switch (_number) do {
    case -1: {"#FFFFFF"};
    case 0: {"#1AFF00"};
    case 1: {"#0071FF"};
    case 2: {"#E8DF06"};
    case 3: {"#06E8B1"};
    default {"#FFAB06"};
};
// return color
_color