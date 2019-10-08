#include "script_component.hpp"

// This file is called from fn_moduleAIMacro, may need changes if edited

params [["_unit", objNull]];

// Assign AI gear
[_unit] call FUNC(unitInit);
