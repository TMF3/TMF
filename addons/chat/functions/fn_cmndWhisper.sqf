/*
 * Name = TMF_chat_fnc_cmndWhisper
 * Author = Kingsley
 *
 * Syntax:
 * #whisper <player> <message>
 *
 * Arguments:
 * String.
 *
 * Return Value:
 * Void
 *
 * Description:
 * Sends a hint to target player.
 */

#include "\x\tmf\addons\chat\script_component.hpp"

params [["_arg", ""]];

if (_arg isEqualTo "") exitWith {
    systemChat "TMF Error: No argument passed. Command usage: #whisper <player> <message>";
};

private _parts = _arg splitString " ";
private _name = _parts select 0;

_parts deleteAt 0;

private _message = _parts joinString " ";
if (_message isEqualTo "") exitWith {
    systemChat "TMF Error: No message passed. Command usage: #whisper <player> <message>";
};
private _unit = [_name] call FUNC(findMatch);

if (!isNull _unit) then {
    parseText format ["<t size='1.25'>Whisper from %1</t><br />%2", name player, _message] remoteExecCall ["hint", _unit];
    systemChat format ["TMF: Whisper sent to %1", name _unit];
} else {
    systemChat FORMAT_1("TMF Error: No unit found containing %1, or more than one found.", str _message);
};
