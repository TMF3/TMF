#include "\x\tmf\addons\adminmenu\script_component.hpp"

params [
    ["_class", configNull, [configNull]],
    ["_perm", "", [""]]
];
TRACE_2("Checking permission",_class,_perm);

_perm = toLower _perm;
private _defaultsClass = (configFile >> QGVAR(authorized_players));

// Check cached values
private _cachedPerms = uiNamespace getVariable QGVAR(storedPerms);
private _entry = [configName _class, _perm] joinString "_";
if ([_cachedPerms,_entry] call CBA_fnc_hashHasKey) exitWith {
    TRACE_1("Found cached permission value",_entry);
    [_cachedPerms, _entry] call CBA_fnc_hashGet
};

#define CHECK_BOOL(var1)                                   \
if (isNumber (_class >> var1)) then {                      \
    (_class >> var1) call BIS_fnc_getCfgDataBool           \
} else {                                                   \
    (_defaultsClass >> var1)   call BIS_fnc_getCfgDataBool \
};
#define CHECK_BITWISE(var1,var2)                                            \
if (isNumber (_class >> var1)) then {                                       \
    [getNumber (_class >> var1), var2] call BIS_fnc_bitflagsCheck;          \
} else {                                                                    \
    [getNumber (_defaultsClass >> var1), var2]  call BIS_fnc_bitflagsCheck; \
};

private _hasPerm = switch _perm do {
    /* Go to default instead
    case "debugconsole";
    case "zeus";
    case "spectatorrc";
    case "map";
    case "safestart";
    case "adminmenu":       {CHECK_BOOL(_perm))};
    */
    case "dashboard":       {CHECK_BITWISE("adminmenu",TMF_ALLOW_DASHBOARD)};
    case "playermanagement":{CHECK_BITWISE("adminmenu",TMF_ALLOW_PLAYERMANAGEMENT)};
    case "respawn":         {CHECK_BITWISE("adminmenu",TMF_ALLOW_RESPAWN)};
    case "endmission":      {CHECK_BITWISE("adminmenu",TMF_ALLOW_ENDMISSION)};
    case "logs":            {CHECK_BITWISE("adminmenu",TMF_ALLOW_LOGS)};

    default {CHECK_BOOL(_perm)};
};

// Store value
TRACE_2("Caching permission value",_entry,_hasPerm);
[_cachedPerms, _entry, _hasPerm] call CBA_fnc_hashSet;

_hasPerm
