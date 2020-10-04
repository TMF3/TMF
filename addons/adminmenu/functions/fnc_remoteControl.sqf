#include "\x\tmf\addons\adminmenu\script_component.hpp"

params [["_unit", objNull, [objNull]], ["_toggle", true, [true]], ["_skipModal", false, [false]]];

if (!_toggle) exitWith { // Bad, can still command group via map click when back in spectator
    private _rcUnit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull];
    if (!isNull _rcUnit && ((_rcUnit getVariable ["bis_fnc_moduleRemoteControl_owner", objNull]) isEqualTo player)) then {
        _rcUnit setVariable ["bis_fnc_moduleRemoteControl_owner", nil, true];
        objNull remoteControl _rcUnit;
        bis_fnc_moduleRemoteControl_unit = nil;
        selectPlayer EGVAR(spectator,unit);
    };
};

private _crew = [];
if (!isNull objectParent _unit && !_skipModal) then {
    _crew = (fullCrew vehicle _unit) select {alive (_x # 0) && !isPlayer (_x # 0)};
};

if ((count _crew > 1) && !_skipModal) exitWith {
    GVAR(remoteControlUnits) = [_crew, objectParent _unit];
    createDialog QGVAR(spectatorControlUnitDialog);
};

private _error = "";
call {
    if (isNull _unit) exitWith {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorNull";};
    if (isPlayer _unit) exitWith {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer";};
    if !(alive _unit) exitWith {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorDestroyed";};
    if !(_unit isKindOf "CAManBase") exitWith {_error = "Target must be a unit.";};
    if !((side group _unit) in [east, west, resistance, civilian]) exitWith {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorEmpty";};
    private _tempOwner = _unit getVariable ["bis_fnc_moduleRemoteControl_owner", objnull];
    if (!isNull _tempOwner && {_tempOwner in allPlayers}) exitWith {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorControl";};
    if (isUAVConnected vehicle _unit) exitWith {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorControl";};
};

if (_error isEqualTo "") then {
    bis_fnc_moduleRemoteControl_unit = _unit;
    _unit setVariable ["bis_fnc_moduleRemoteControl_owner", player, true];

    [{
        if (dialog) then {
            closeDialog 2;
        } else {
            [_this select 1] call CBA_fnc_removePerFrameHandler;
        };
    }, 0, 0] call CBA_fnc_addPerFrameHandler;

    [{!dialog}, {
        private _vehicle = vehicle _this;
        player remoteControl _this;
        if (cameraOn != _vehicle) then {
            _vehicle switchCamera cameraView;
        };

        [{
            !alive _this ||
            (_this getVariable ["ACE_isUnconscious", false]) ||
            (cameraOn isEqualTo player) ||
            !(player isKindOf QEGVAR(spectator,unit)) ||
            ((missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull]) isNotEqualTo _this) ||
            ((_this getVariable ["bis_fnc_moduleRemoteControl_owner", objNull]) isNotEqualTo player)
        }, {
            private _reasons = [];
            if (!alive _this) then {
                _reasons pushBack "RC unit is dead";
            };
            if (_this getVariable ["ACE_isUnconscious", false]) then {
                _reasons pushBack "RC unit is unconscious";
            };
            if (cameraOn isEqualTo player) then {
                _reasons pushBack "Camera is on player";
            };
            if (!(player isKindOf QEGVAR(spectator,unit))) then {
                _reasons pushBack "Player is not a spectator unit (respawned?)";
            };
            if ((missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull]) isNotEqualTo _this) then {
                _reasons pushBack "Mission RC var says current unit shouldn't be RC'd";
            };
            if ((_this getVariable ["bis_fnc_moduleRemoteControl_owner", objNull]) isNotEqualTo player) then {
                _reasons pushBack "Unit RC var says player shouldn't be remote controlling it";
            };
            systemChat format [
                "[TMF Admin Menu] Remote Control stopped because: %1",
                _reasons joinString " | "
            ];

            if ((_this getVariable ["bis_fnc_moduleRemoteControl_owner", objNull]) isEqualTo player) then {
                _this setVariable ["bis_fnc_moduleRemoteControl_owner", nil, true];
                objNull remoteControl _this;
                bis_fnc_moduleRemoteControl_unit = nil;
            };

            [{
                if (isNull (findDisplay 5454)) then {
                    createDialog QEGVAR(spectator,dialog);
                };
            }, 0, 0.33] call CBA_fnc_waitAndExecute;
        }, _this] call CBA_fnc_waitUntilAndExecute;
    }, _unit] call CBA_fnc_waitUntilAndExecute;
} else {
    systemChat format [
        "[TMF Admin Menu] Spectator Remote Control error: %1",
        _error
    ];
};
