#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display", "_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

private _ctrlTextLarge = _display ctrlCreate [QGVAR(RscTextLarge), -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlTextLarge];
_ctrlTextLarge ctrlSetPosition [0, 0, _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlTextLarge ctrlCommit 0;

//if (serverCommandAvailable "#kick") then {

if (true) then {
    _ctrlTextLarge ctrlSetText "You are about to kick the following player(s):";

    private _names = "";
    {
        if (_forEachIndex > 0) then {
            _names = format ["%1, ", _names]
        };
        _names = format ["%1%2", _names, name _x];
    } forEach GVAR(utilityData);

    private _ctrlText = _display ctrlCreate [QGVAR(RscTextMultiline), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlText;
    _ctrlText ctrlSetPosition [0.1 * TMF_ADMINMENU_STD_WIDTH, 1.1 * TMF_ADMINMENU_STD_HEIGHT, _ctrlGrpWidth - (0.2 * TMF_ADMINMENU_STD_WIDTH), _ctrlGrpHeight - (2.2 * TMF_ADMINMENU_STD_HEIGHT)];
    _ctrlText ctrlCommit 0;
    _ctrlText ctrlSetText _names;

    private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlButton;
    _ctrlButton ctrlSetPosition [(_ctrlGrpWidth * 0.85), _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, (_ctrlGrpWidth * 0.15), TMF_ADMINMENU_STD_HEIGHT];
    _ctrlButton ctrlCommit 0;
    _ctrlButton ctrlSetText "Confirm";
    _ctrlButton ctrlAddEventHandler ["buttonClick", {
    	disableSerialization;
    	ctrlEnable (GVAR(utilityTabControls) select 1);

        {
            serverCommand format ["#kick %1", name _x];
        } forEach GVAR(utilityData);
    	systemChat "[TMF Admin Menu] Player(s) kicked";
    }];
} else {
    _ctrlTextLarge ctrlSetText "The #kick command is not executable on this client.";
};


/*private _xPositions = [];
{
    private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
    GVAR(utilityTabControls) pushBack _ctrlButton;

    private _lineIndex = (_forEachIndex - (_forEachIndex % 4)) / 4;
    _ctrlButton ctrlSetPosition [_xPositions select (_forEachIndex % 4), _lineIndex * 1.1 * TMF_ADMINMENU_STD_HEIGHT, (_ctrlGrpWidth * 0.2), TMF_ADMINMENU_STD_HEIGHT];
    _ctrlButton ctrlCommit 0;
    _ctrlButton ctrlSetText format ["Kick %1", name _x];
    _ctrlButton ctrlAddEventHandler ["buttonClick", {
    	disableSerialization;
    	private _editText = ctrlText (GVAR(utilityTabControls) select 0);
    	if (_editText isEqualTo "") then {
    		systemChat "[TMF Admin Menu] Message can't be empty";
    	} else {
    		{
    			_x ctrlEnable false;
    		} forEach GVAR(utilityTabControls);

    		private _venue = ["systemChat", "hint", "hintC"] select (lbCurSel (GVAR(utilityTabControls) select 1));
    		_editText remoteExec [_venue, GVAR(utilityData)];
    		systemChat "[TMF Admin Menu] Message sent to player(s)";
    	};
    }];
} forEach GVAR(utilityData);*/
