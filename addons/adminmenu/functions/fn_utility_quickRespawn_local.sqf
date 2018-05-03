#include "\x\tmf\addons\adminmenu\script_component.hpp"

private _oldUnit = player;
private _oldUnitdata = _oldUnit getVariable [QEGVAR(spectator,unitData), false];

if (_oldUnitdata isEqualType []) then {
    _oldUnitdata params ["_group", "_faction", "_role", "_side", "_pos", "_objectParent"];

    private _unitType = switch (_side) do {
        case blufor: {"B_Soldier_F"};
        case opfor: {"O_Soldier_F"};
        case independent: {"I_soldier_F"};
        default {"C_man_1"};
    };
    private _newUnit = _group createUnit [_unitType, _pos, [], 0, "NONE"];
    _newUnit setVariable [QGVARMAIN(isRespawnUnit), true];

    if (!isNull _objectParent && {alive _objectParent}) then {
        _newUnit moveInAny _objectParent;
    };

    if !(_faction isEqualTo "" || _role isEqualTo "") then {
        [_newUnit, _faction, _role] call EFUNC(assigngear,assigngear);
    };

    setPlayable _newUnit;
    selectPlayer _newUnit;
    deleteVehicle _oldUnit;

    [{ // Close spectator
        if (dialog) then {
            closeDialog 2;
        } else {
            [_this select 1] call CBA_fnc_removePerFrameHandler;
        };
    }, 0, 0] call CBA_fnc_addPerFrameHandler;
} else {
    systemChat "[TMF Admin Menu] Quick Respawn failed: old unit data unavailable";
};
