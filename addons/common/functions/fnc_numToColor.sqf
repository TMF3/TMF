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
    case 2: {"#abe806"};
    case 3: {"#06E8B1"};
    case 4: {"#E84200"};
    case 5: {"#FF009E"};
    case 6: {"#4400E8"};
    case 7: {"#a24b98"};
    case 8: {"#224726"};
    case 9: {"#963f3f"};
    case 10: {"#005046"};
    case 11: {"#68341F"};
    case 12: {"#746299"};
    case 13: {"#996264"};
    case 14: {"#997C62"};
    case 15: {"#51FF8D"};
    default {"#FFAB06"};
};
// return color
_color