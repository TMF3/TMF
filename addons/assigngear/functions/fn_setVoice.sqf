/*
 * Name = TMF_assignGear_fnc_setVoice
 * Author = Freddo
 *
 * Arguments:
 * 0: Object. Unit
 * 1: ARRAY. Array of voices to choose from
 *
 * Return:
 * Nothing
 *
 * Description:
 * Will set a units voice to a randomly chosen one from the supplied list.
 * Also accepts voicesets (ex. "voiceset:americanEnglish")
 */
 #include "\x\tmf\addons\assignGear\script_component.hpp"
params ["_unit","_voices"];

if (isNil "_unit" || isNil "_voices") exitWith {};

private _voiceArr = [];

{
    if ((_x find "voiceset:") == 0) then
    {
        private _voicesetName = _x select [9];

        {
            PUSH(_voiceArr, toLower _x);
        } forEach (uiNamespace getVariable [QGVAR(voiceset_) + _voicesetName,[]]);
    }
    else
    {
        PUSH(_voiceArr, toLower _x);
    };
} forEach _voices;

if (count _voiceArr > 0) then
{
    private _voice = selectRandom _voiceArr;
    [_unit,_voice] remoteExec ["setSpeaker",0,_unit];
    _unit setSpeaker _voice;
};
