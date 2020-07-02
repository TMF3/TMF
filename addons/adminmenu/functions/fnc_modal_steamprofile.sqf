#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlGroup"];

private _ctrlTextPos = [0, 0];
_ctrlTextPos append ((ctrlPosition _ctrlGroup) select [2, 2]);
private _ctrlText = (uiNamespace getVariable [QGVAR(modalDisplay), displayNull]) ctrlCreate ["RscStructuredText", -1, _ctrlGroup];
_ctrlText ctrlSetPosition _ctrlTextPos;
_ctrlText ctrlCommit 0;

private _textArray = GVAR(utilityData) apply {
    format [
        "<t size='1'><a color='#FFC04D' href='http://steamcommunity.com/profiles/%1'>%2</a></t>",
        getPlayerUID _x,
        name _x
    ]
};

_ctrlText ctrlSetStructuredText parseText (_textArray joinString ", ");
