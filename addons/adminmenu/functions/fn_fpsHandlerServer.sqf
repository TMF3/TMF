#include "\x\tmf\addons\adminmenu\script_component.hpp"

if (!isServer) exitWith {};
params [["_add", true, [true]]];

if (isMultiplayer) then {
    if (_add) then {
        if (isNil QGVAR(fps_pfh)) then {
            GVAR(fps_pfh) = [{
                GVAR(fps) = round diag_fps;

                private _allGroups = allGroups;
                private _headlessString = format["Server: %1",{groupOwner _x == 2} count _allGroups];
                {
                    private _headless = _x;
                    private _headlessClientId = owner _headless;
                    if (_headlessClientId != 2) then { // not server.
                        private _varName = vehicleVarName _headless;
                        if (count _varName == 0) then {
                            _varName = roleDescription _headless;
                        };
                        _headlessString = _headlessString + format[", %1: %2",_varName,{groupOwner _x == _headlessClientId} count _allGroups];
                    };
                } forEach (entities "HeadlessClient_F");
                GVAR(headlessInfo) = _headlessString;


                {
                    _x publicVariableClient QGVAR(fps);
                    _x publicVariableClient QGVAR(headlessInfo);
                } forEach GVAR(activeClients);
            }, 1] call CBA_fnc_addPerFrameHandler;
        };

        GVAR(activeClients) pushBackUnique remoteExecutedOwner;
    } else {
        GVAR(activeClients) = GVAR(activeClients) - [remoteExecutedOwner];

        if (((count GVAR(activeClients)) isEqualTo 0) && {!isNil QGVAR(fps_pfh)}) then {
            [GVAR(fps_pfh)] call CBA_fnc_removePerFrameHandler;
            GVAR(fps_pfh) = nil;
        };
    };
} else { // Singleplayer
    if (_add && isNil QGVAR(fps_pfh)) then {
        GVAR(fps_pfh) = [{
            disableSerialization;

            private _ctrl = (uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl IDC_TMF_ADMINMENU_FPS;
            if (isNull _ctrl) exitWith {};

            _ctrl ctrlSetText format ["%1 SFPS", round diag_fps];
        }, 1] call CBA_fnc_addPerFrameHandler;
    } else {
        if (!isNil QGVAR(fps_pfh)) then {
            [GVAR(fps_pfh)] call CBA_fnc_removePerFrameHandler;
            GVAR(fps_pfh) = nil;
        };
    };
};
