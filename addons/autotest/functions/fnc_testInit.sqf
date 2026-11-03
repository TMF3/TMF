#include "\x\tmf\addons\autotest\script_component.hpp"
/*
 * Name = TMF_autotest_fnc_testInit
 * Author = Nick
 *
 * Arguments:
 * None.
 *
 * Return:
 * 0: ARRAY. Array with nested arrays of warning messages.
 *
 * Description:
 * Check the init attribute for all placed units and
 * raises a warning if it contains a lot of code,
 * VA code or doesn't contain isServer.
 */
private _output = [];

{
    private _init = toLower ((_x get3DENAttribute 'Init') param [0,""]);
    private _count = count _init;
    private _VA = (_init find "exported from arsenal") >= 0;
    private _isServer = (_init find "isserver") >= 0;
    private _isLocal = (_init find "local") >= 0;
    switch (true) do {
        case (_count < 50): {/* Nothing*/};
        case (_count < 150): {
            // check _isServer
            if ((!_isServer) && (!_isLocal)) then {
                _output pushBack [1,format["%1 has a large init field (%2 characters) that runs on every machine. Wrap it in an isServer or local check.",_x,_count]];
            };
        };
        // >= 150
        default {
            // check _VA
            if _VA then {
                if (_isServer or _isLocal) then {
                    _output pushBack [1,format["%1 adds a Virtual Arsenal in its init field.",_x]];
                } else {
                    _output pushBack [0,format["%1 adds a Virtual Arsenal in its init field on every machine. Wrap it in an isServer or local check.",_x]];
                };
            } else {
                // Check _isServer
                if ((!_isServer) && (!_isLocal)) then {
                    _output pushBack [1,format["%1 has a very large init field (%2 characters) that runs on every machine. Wrap it in an isServer or local check.",_x,_count]];
                };
            };
        };
    };
} forEach (all3DENEntities select 0);

_output pushBack [-1,format["Init field check done, %1 issues found",count _output]];

_output
