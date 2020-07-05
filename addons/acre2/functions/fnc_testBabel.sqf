#include "\x\tmf\addons\acre2\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_acre2_fnc_testBabel

Description:
    Checks if players have no Babel assigned to them.
    Used with TMF Autotest.

Returns:
    Warning array [Array of Warnings]

Author:
    Freddo
---------------------------------------------------------------------------- */

private _warnings = [];

if (getmissionconfigvalue ["TMF_AcreBabelEnabled",false]) then {
    LOG("Running Autotest on Babel");
    private _babelArray = getMissionConfigValue ["TMF_AcreBabelSettings", []];
    if IS_STRING(_babelArray) then {_babelArray = call compile _babelArray};

    private _playerGroups = (playableUnits + [player]) apply {group _x};
    UNIQUE(_playerGroups);

    {
        // Check side/faction conditions

        private _grp = _x;
        TRACE_1("Autotest checking babel",_grp);
        private _leader = leader _grp;
        private _index = _babelArray findIf {[_leader, _x # 1] call EFUNC(common,evaluateCondArray)};

        if (_index == -1) then {
            // Check the group condition

            private _groupCond = _grp getVariable ["TMF_BabelLanguages", []];
            if IS_STRING(_groupCond) then { _groupCond = call compile _groupCond; };

            if (_groupCond isEqualTo []) then {
                // Check the unit conditionz
                {
                    private _unit = _x;
                    TRACE_1("Autotest checking babel",_unit);
                    private _unitCond = _unit getVariable ["TMF_BabelLanguages", []];
                    if IS_STRING(_unitCond) then { _unitCond = call compile _unitCond; };

                    if (_unitCond isEqualTo []) then {
                        // No languages assigned on each level, post warning.
                        LOG("No languages assigned for %1",_unit);
                        _warnings pushBack [0,format ["%1 has no Babel languages assigned", _unit]];
                    };
                } forEach (units _grp);
            };
        };
    } forEach _playerGroups;
    if (count _warnings == 0) then {
        LOG("Babel Autotest finished");
        _warnings pushBack [[-1,"Babel checks complete"]];
    } else {
        WARNING_1("Babel Autotest finished with warnings: %1",_warnings);
    };
};

_warnings
