#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_vehicleGear_save
 * Author = Head
 *
 * Arguments:
 * None.
 *
 * Return:
 * Data to store
 *
 * Description:
 * Internal Use Only
 */
#include "\x\tmf\addons\assignGear\script_component.hpp"
private _data = (missionNamespace getVariable [QGVAR(vehicleGear_data), ['', '', []]]);
TRACE_1('SAVE', _data);
private _gear = (_data # 2);
{
    private _arr = _x select { (_x # 1) > 0};
    _gear set [_forEachIndex, _arr];
} forEach _gear;
_data