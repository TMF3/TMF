#include "\x\tmf\addons\adminmenu\script_component.hpp"

private _given = [];
private _had = [];

{
    if (isNull (getAssignedCuratorLogic _x)) then {
        _x remoteExec [QFUNC(zeusServerMake), 2];
        _given pushBack _x;
    } else {
        _had pushBack _x;
    };
} forEach GVAR(utilityData);

if (count _given > 0) then {
    _given = str (_given apply {name _x});
    _given = _given select [1, (count _given) - 2];
    systemChat format ["[TMF Admin Menu] Zeus access was given to %1", _given];
};

if (count _had > 0) then {
    _had = str (_had apply {name _x});
    _had = _had select [1, (count _had) - 2];
    systemChat format ["[TMF Admin Menu] Zeus access was already given to %1", _had];
};
