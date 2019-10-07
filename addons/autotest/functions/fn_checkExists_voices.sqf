#include "\x\tmf\addons\autotest\script_component.hpp"

params ["_voices", "_faction", "_role"];

private _output = [];

{
    private _voice = toLower _x;
     if ((_voice find "voiceset:") isEqualTo 0) then
     {
        private _voicesetName = _voice select [9];
        private _array = uiNamespace getVariable [QEGVAR(assignGear,voiceset_) + _voicesetName,0];
        if (_array isEqualTo 0) then
        {
            _output pushBack [0,format["Invalid voiceset: %1 (for: %2 - %3)", _voice,_faction,_role]];
        };
    }
    else
    {
        if (!(_voice in EGVAR(assignGear,validVoices))) then
        {
            _output pushBack [0,format["Invalid voice classname: %1 (for: %2 - %3)", _voice,_faction,_role]];
        };
    };
} forEach _voices;

_output
