/*
 * Name = TMF_assignGear_fnc_setUnitTrait
 * Author = Freddo
 *
 * Arguments:
 * 0: Object. Unit to assign trait to
 * 1: String or Array. Trait to assign
 *  0: String. - Trait to assign
 *  1: Number. - Number value to assign
 *
 * Return:
 * None
 *
 * Description:
 * Assigns a trait to a unit, and handles custom traits
 */

#include "\x\tmf\addons\assignGear\script_component.hpp"
params ["_unit", "_trait"];

#define DEFAULTTRAITS ["audibleCoef", "camouflageCoef", "loadCoef", "engineer", "explosiveSpecialist", "medic", "UAVHacker"]
; // Travis
if (_trait isEqualType []) then {
    _trait params ["_trait", "_value"];

    if !(_trait in DEFAULTTRAITS) then {
        // Custom trait
        _unit setUnitTrait [
            _trait,
            [false, true] select _value, // Custom traits can only be bool
            true
        ];
    } else {
        // Vanilla trait
        _unit setUnitTrait [_trait, _value];
    };
} else { // Assumed to be string
    if !(_trait in DEFAULTTRAITS) then {
        // Custom trait
        _unit setUnitTrait [_trait, true, true];
    } else {
        // Vanilla trait
        _unit setUnitTrait [_trait, true];
    };
};
