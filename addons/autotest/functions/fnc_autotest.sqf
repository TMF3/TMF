#include "\x\tmf\addons\autotest\script_component.hpp"

private _ctrlListbox = (_this controlsGroupCtrl 101);
_ctrlListbox lnbSetColumnsPos [0,0.05];

private _output = [];

// Process the Config based auto-tests.
{
    private _test = _x;
    LOG_1("Running test: %1",configName _x);
    private _code = getText (_test >> "code");

    private _outputTest = call compile _code;
    if (_outputTest isEqualType []) then {
        _output append _outputTest;
        TRACE_2("Appending to output",_output,_outputTest);
    };
} forEach ("true" configClasses (configFile >> 'ADDON'));


// Display them on the auto-test UI page in Eden.
{
    _x params ["_type","_message"];
    _lnbAdd = _ctrlListbox lnbAddRow ["",_message];

    if (_type == 0) then { // Cross
        _ctrlListbox lnbSetPicture [[_lnbAdd,0],QPATHTOEF(briefing,UI\plus_small_ca.paa)];
    };
    if (_type == -1) then { // Tick
        _ctrlListbox lnbSetPicture [[_lnbAdd,0],QPATHTOEF(briefing,UI\check_small_ca.paa)];
    };
    if (_type == 1) then { //Warning
        _ctrlListbox lnbSetPicture [[_lnbAdd,0],QPATHTOEF(autotest,UI\warning.paa)];
    };

} forEach _output;
