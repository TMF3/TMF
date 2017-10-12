#include "\x\tmf\addons\adminmenu\script_component.hpp"

/*systemChat format [
    "RC _this: %1",
    _this
];*/

params [["_unit", objNull, [objNull]], ["_toggle", true, [true]]];

if (!_toggle) exitWith { // Bad or toggle off
    systemChat "RC: toggle off A";
    private _rcUnit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull];
    if (!isNull _rcUnit && ((_rcUnit getVariable ["bis_fnc_moduleRemoteControl_owner", objNull]) isEqualTo player)) then {
        systemChat "RC: toggle off B";
        _rcUnit setVariable ["bis_fnc_moduleRemoteControl_owner", nil, true];
        objNull remoteControl _rcUnit;
        bis_fnc_moduleRemoteControl_unit = nil;
    };
};

systemChat format [
    "RC UNIT: %1 | %2 | %3 | %4 | %5 | %6 | %7 | %8",
    vehicleVarName _unit,
    name _unit,
    getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName"),
    typeOf _unit,
    side _unit,
    getText (configFile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "displayName"),
    typeOf (vehicle _unit),
    assignedVehicleRole _unit
];

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
    systemChat "RC: no error";

    bis_fnc_moduleRemoteControl_unit = _unit;
    _unit setVariable ["bis_fnc_moduleRemoteControl_owner", player, true];

    [{
        if (dialog) then {
            closeDialog 2;
        } else {
            [_this select 1] call CBA_fnc_removePerFrameHandler;
            systemChat "RC: removePFH";
        };
    }, 0, 0] call CBA_fnc_addPerFrameHandler;

    [{!dialog}, {
        systemChat "RC: waitUntilAndExecute 1";
        private _vehicle = vehicle _this;
        player remoteControl _this;
        if (cameraOn != _vehicle) then {
            _vehicle switchCamera cameraView;
        };

        [{
            !alive _this ||
            (cameraOn isEqualTo player) ||
            !(player isKindOf QEGVAR(spectator,unit)) ||
            !((missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull]) isEqualTo _this) ||
            !((_this getVariable ["bis_fnc_moduleRemoteControl_owner", objNull]) isEqualTo player)
        }, {
            systemChat format [
                "RC: w2: %1 %2 %3 %4 %5",
                !alive _this,
                (cameraOn isEqualTo player),
                !(player isKindOf QEGVAR(spectator,unit)),
                !((missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull]) isEqualTo _this),
                !((_this getVariable ["bis_fnc_moduleRemoteControl_owner", objNull]) isEqualTo player)
            ];
            if ((_this getVariable ["bis_fnc_moduleRemoteControl_owner", objNull]) isEqualTo player) then {
                _this setVariable ["bis_fnc_moduleRemoteControl_owner", nil, true];
                objNull remoteControl _this;
                bis_fnc_moduleRemoteControl_unit = nil;
            };

            [{
                systemChat "RC: waitAndExecute 3";
                if (isNull (findDisplay 5454)) then {
                    createDialog QEGVAR(spectator,dialog);
                };
            }, 0, 1] call CBA_fnc_waitAndExecute;
        }, _this] call CBA_fnc_waitUntilAndExecute;
    }, _unit] call CBA_fnc_waitUntilAndExecute;
} else {
    systemChat format [
        "[TMF Admin Menu] Spectator Remote Control: %1",
        _error
    ];
};
