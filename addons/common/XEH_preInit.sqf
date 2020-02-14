#include "\x\tmf\addons\common\script_component.hpp"

isTMF = ((getMissionConfigValue ["tmf_version",[0,0,0]] select 0) > 0);

if ( isNil QGVARMAIN(namespace) ) then {
    GVARMAIN(namespace) = true call CBA_fnc_createNamespace;
    publicVariable QGVAR(namespace);
};
