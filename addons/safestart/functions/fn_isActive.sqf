#include "\x\tmf\addons\safeStart\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: TMF_safestart_fnc_isActive

Description:
    Checks whether safestart is active

Returns:
    Whether safestart is active [Boolean]

Examples:
    (begin example)
        _isActive = [] call TMF_safestart_fnc_isActive
    (end)

Author:
    Freddo
---------------------------------------------------------------------------- */

!isNil QGVAR(instance)
