#include "\x\tmf\addons\acre2\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_acre2_fnc_testNets

Description:
    Checks if players have no radio nets assigned to them.
    Used with TMF Autotest.

Returns:
    Warning array [Array of Warnings]

Author:
    Freddo
---------------------------------------------------------------------------- */

private _warnings = [];

if (getmissionconfigvalue ["TMF_AcreNetworkEnabled",false]) then {
    LOG("Running Autotest on Radio Networks");
    private _networksArray = getMissionConfigValue ['TMF_AcreSettings', []];
    if IS_STRING(_networksArray) then {_networksArray = call compile _networksArray};

    private _playerGroups = (playableUnits + [player]) apply {group _x};
    UNIQUE(_playerGroups);

    {
        // Check side/faction conditions

        private _grp = _x;
        TRACE_1("Autotest checking Radio Networks",_grp);
        private _leader = leader _grp;
        private _index = _networksArray findIf {[_leader, _x # 0] call EFUNC(common,evaluateCondArray)};

        if (_index == -1) then {
            // Check the group condition

            private _groupCond = _grp getVariable ["TMF_Network", -1];
            if IS_STRING(_groupCond) then { _groupCond = call compile _groupCond; };

            if (_groupCond isEqualTo -1 || _groupCond > (count (_networksArray # 0)) - 1) then {
                // Check the unit conditions
                {
                    private _unit = _x;
                    TRACE_1("Autotest checking Radio Networks",_unit);
                    private _unitCond = _unit getVariable ["TMF_Network", -1];
                    if IS_STRING(_unitCond) then { _unitCond = call compile _unitCond; };

                    if (_unitCond isEqualTo -1 || _unitCond > (count (_networksArray # 0)) - 1) then {
                        // No nets assigned on each level, post warning.
                        WARNING_1("No Radio Nets assigned for %1",_unit);
                        _warnings pushBack [0,format ["%1 has no Radio Networks assigned", _unit]];
                    };
                } forEach (units _grp);
            };
        };
    } forEach _playerGroups;
    if (count _warnings == 0) then {
        LOG("Radio Net Autotest finished");
        _warnings pushBack [-1,"ACRE2 Radio Network checks complete"];
    } else {
        WARNING_1("Radio Networks Autotest finished with warnings: %1",_warnings);
    };
};

_warnings
