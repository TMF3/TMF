// Updates the group names on the slotting/lobby screen.

#include "\x\tmf\addons\common\script_component.hpp"

params ["_display"];

private _fn_update_group_names_in_lobby = {
    params ["_display"];
    private _slotListControl = _display displayCtrl 109;

    private _lastCallsign = "";
    for "_playerListIdx" from 1 to (lbSize _slotListControl) do {
        private _currentText = _slotListControl lbText 0;
        private _currentValue = _slotListControl lbValue 0;

        // delete old lb entry (replace later)
        _slotListControl lbDelete 0;

        if (_currentValue isEqualTo -1) then {
            // Value is -1 when it's a groupname.
            
            // Collect descriptions of upcoming roles/terminate if another group appears.
            private _descriptions = [];
            for "_idx" from 0 to (lbSize _slotListControl -1) do {
                private _currentValue = _slotListControl lbValue _idx;
                if (_currentValue isEqualTo -1) exitWith {}; // Terminate upon reaching next group.
                _descriptions pushBack (_slotListControl lbText _idx);
            };
            _descriptions = _descriptions apply {(/*toLower*/ _x) splitString " "};
            if (count _descriptions > 1) then {
                private _common = _descriptions select 0;
                {
                    // Ensure common is not more tokens than the present description.
                    _common resize ((count _x) min (count _common));
                    for "_idx2" from 0 to (count _common -1) do {
                        if (_common select _idx2 != _x select _idx2) exitWith { _common resize _idx2;}
                    };
                } forEach _descriptions;
                _lastCallsign = _common joinString " ";
            } else {
                _lastCallsign = "";
            };

            if (_lastCallsign != "") then {
                _currentText = _lastCallsign;
            };
        } else {
            _currentText = _currentText select [count _lastCallsign];
        };

        // Add new entry.
        private _slotListIdx = _slotListControl lbAdd _currentText;
        _slotListControl lbSetValue [_slotListIdx, _currentValue];
    };
};

_display call _fn_update_group_names_in_lobby;

// Refresh constantly.
_display displayAddEventHandler ["MouseMoving", _fn_update_group_names_in_lobby];
_display displayAddEventHandler ["MouseHolding", _fn_update_group_names_in_lobby];
