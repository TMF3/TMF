/*
 * Name = TMF_briefing_fnc_parseBriefingHtml
 * Author = Freddo
 *
 * Arguments:
 * 0: String. Path to file
 *
 * Return:
 * 0: Array. - Format [[_header, _text],[_header, _text]...]
 *
 * Description:
 * Parses a .html file to sections createDiaryRecord can use
 */
#include "\x\tmf\addons\briefing\script_component.hpp"

params ["_path"];

private _text = loadFile "_path";
private _textArr = [];

while {true} do {
    // Split text into section indicated by "<hr>"
    private _index = _text find "<hr>";
    if (_index isEqualTo -1) exitWith {};

    _textArr pushBack (_text select [0, _index]);
    _text = _text select [_index + 4, count _text];
};

// Diary records are added in reverse order
reverse _textArr;
private _rtrn = [];
{
    private _ind1 = _x find "<a name=""";
    private _ind2 = _x find """>";
    private _ind3 = _x find "</a>";
    if (_ind1 == -1 || _ind2 == -1 || _ind3 == -1) exitWith {};

    private _header = _x select [_ind1 + 9, _ind2 - (_ind1 + 9)];
    private _text = _x select [_ind3 + 4, count _x];

    player pushBack [_header, _text];
} forEach _textArr;

_rtrn
