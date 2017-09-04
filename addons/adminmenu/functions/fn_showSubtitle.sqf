#include "\x\tmf\addons\adminmenu\script_component.hpp"

/*
    Modified by Bear for TMF Admin Menu

    Author: Thomas Ryan

    Description:
    Displays a subtitle at the bottom of the screen.

    Parameters:
        _this select 0: STRING - Name of the person speaking.
        _this select 1: STRING - Contents of the subtitle.

    Returns:
    SCRIPT - Script controlling the displayed subtitle.
*/

params [
    ["_from", "", [""]],
    ["_text", "", [""]]
];

if (_from == "") exitWith {"No speaker defined!" call BIS_fnc_error; scriptNull};
if (_text == "") exitWith {"No text defined!" call BIS_fnc_error; scriptNull};

// Terminate previous script
if (!(isNil {BIS_fnc_showSubtitle_subtitle})) then {terminate BIS_fnc_showSubtitle_subtitle};

BIS_fnc_showSubtitle_subtitle = [_from, _text] spawn {
    disableSerialization;
    scriptName format ["BIS_fnc_showSubtitle: subtitle display - %1", _this];

    params ["_from", "_text"];

    // Create display and control
    "BIS_fnc_showSubtitle" cutRsc ["RscDynamicText", "PLAIN"];
    private "_display";
    waitUntil {_display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)};
    private _ctrl = _display displayCtrl 9999;
    uiNamespace setVariable ["BIS_dynamicText", displayNull];

    // Position control
    private _w = 0.4 * safeZoneW;
    private _x = safeZoneX + (0.5 * safeZoneW - (_w / 2));
    private _y = safeZoneY + (0.73 * safeZoneH);
    private _h = safeZoneH;

    _ctrl ctrlSetPosition [_x, _y, _w, _h];

    // Hide control
    _ctrl ctrlSetFade 1;
    _ctrl ctrlCommit 0;

    // Show subtitle
    _ctrl ctrlSetStructuredText parseText ("<t align = 'center' shadow = '2' size = '0.5'><t color = '#ff0000'>" + _from + ":</t> <t color = '#d0d0d0'>" + _text + "</t></t>");
    _ctrl ctrlSetFade 0;
    _ctrl ctrlCommit 0.5;

    sleep 12;

    // Hide subtitle
    _ctrl ctrlSetFade 1;
    _ctrl ctrlCommit 0.5;
};

BIS_fnc_showSubtitle_subtitle
