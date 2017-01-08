#include "\x\tmf\addons\autotest\script_component.hpp"

private _ctrlListbox = (_this controlsGroupCtrl 101);
_ctrlListbox lnbSetColumnsPos [0,0.05];

//private _lnbAdd = _ctrlListbox lnbAddRow ["","test"];

//_ctrlListbox lnbSetPicture [[_lnbAdd,0],"\x\tmf\addons\briefing\UI\check_small_ca.paa"];

// Do the tests.
private _output = [];
_output append ([] call FUNC(testGear));
_output append ([] call FUNC(testInit));
_output append ([] call FUNC(testEndings));


//Group count check.
{
    private _side = _x;
    private _groupCount = {(side _x isEqualTo _side)} count allGroups;
    if (_groupCount > 100) then {
        _output pushBack [1,format["Side %1 has %2 groups. Note Arma has a 144 group limit per side.",_side,_groupCount]];
    }
} forEach [west,east,civilian,resistance];

// AI Numbers check

private _array = playableUnits + [player];
private _aiCount = {!(_x in _array)} count allUnits;

if (_aiCount > 160) then {
    if (_aiCount > 200) then {
        _output pushBack [0,format["You have placed %1 AI. You may wish to consider the performance impact.",_aiCount]];
    } else {
        _output pushBack [1,format["You have placed %1 AI. You may wish to consider the performance impact.",_aiCount]];
    };
};

// TMF Spectator configured.

if (!((getMissionConfigValue ["respawn",0] == 1) and ("TMF_Spectator" in (getMissionConfigValue ["respawnTemplates",[]])))) then {
    _output pushBack [0,"TMF Spectator is not setup correctly. See wiki for instructions."];
};

// Process the Config based auto-tests.

{
    private _test = _x;
    private _code = getText (_test >> "code");

    private _outputTest = call compile _code;
    if (_outputTest isEqualType []) then {
        _output append _outputTest;
    }
} forEach (configProperties [configFile >> "TMF_autoTest","isClass _x"]);


// Display them on the auto-test UI page in Eden.
{
    _x params ["_type","_message"];
    _lnbAdd = _ctrlListbox lnbAddRow ["",_message];

    if (_type == 0) then { // Cross
        _ctrlListbox lnbSetPicture [[_lnbAdd,0],"\x\tmf\addons\briefing\UI\plus_small_ca.paa"];
    };
    if (_type == -1) then { // Tick
        _ctrlListbox lnbSetPicture [[_lnbAdd,0],"\x\tmf\addons\briefing\UI\check_small_ca.paa"];
    };
    if (_type == 1) then { //Warning
        _ctrlListbox lnbSetPicture [[_lnbAdd,0],"\x\tmf\addons\autotest\UI\warning.paa"];
    };

} forEach _output;
