#include "script_component.hpp"

// Cache the facesets to uiNamespace.

// Collect valid face classes.
private _faceClasses = [];
{
    _faceClasses append (("true" configClasses _x) apply {toLower (configName _x)});
} forEach ("true" configClasses(configfile >> "CfgFaces"));

uiNamespace setVariable [QGVAR(validFaces),_faceClasses];

{
    private _class = _x;
    private _name = configName _x;

    private _weightedArray = [];
    {
        private _faceClass = _x;
        private _faceName = toLower (configName _faceClass);

        private _probability = getNumber (_x >> "probability");
        if (_probability isEqualTo 0) then {_probability = 1;};
        // Validate it's a valid face.
        if (_faceName in _faceClasses) then {
            _weightedArray append [_faceName,_probability];
        };
    } forEach ("true" configClasses _class);
    if (count _weightedArray > 0) then {
        uiNamespace setVariable [QGVAR(faceset_)+_name,_weightedArray];
    };
} forEach ("true" configClasses (configFile >> QGVAR(facesets)));

// Collect valid voice classes.

private _voiceClasses = "true" configClasses (configfile >> "CfgVoice");
MAP(_voiceClasses, toLower configName _x);

uiNamespace setVariable [QGVAR(validVoices),_voiceClasses];

// Cache the voicesets to uiNamespace.
{
    private _name = configName _x;

    private _voiceSet = getArray _x;

    MAP(_voiceSet, toLower _x);
    INTERSECTION(_voiceSet, _voiceClasses);

    if (count _voiceSet > 0) then
    {
        uiNamespace setVariable [QGVAR(voiceset_)+_name,_voiceSet]
    };

} forEach configProperties [configFile >> QGVAR(voicesets)];
