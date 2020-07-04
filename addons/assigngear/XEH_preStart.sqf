#include "script_component.hpp"

#include "XEH_PREP.sqf"

// Cache the facesets to uiNamespace.

// Collect valid face classes.
private _faceClasses = [];
{
    _faceClasses append (("true" configClasses _x) apply {toLower (configName _x)});
} forEach ("true" configClasses(configfile >> "CfgFaces"));

uiNamespace setVariable ["tmf_assignGear_validFaces",_faceClasses];

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
    } forEach configProperties [_class, "isClass _x", true];

    if (count _weightedArray > 0) then {
        uiNamespace setVariable ["tmf_assignGear_faceset_"+_name,_weightedArray];
    };
} forEach ("true" configClasses (configFile >> "tmf_assignGear_facesets"));

