#include "\x\tmf\addons\adminmenu\script_component.hpp"

#include "initKeybinds.sqf"

if (isTMF) then {
    ["Mission Started"] call FUNC(log);
    GVAR(endedEH) = addMissionEventHandler ["Ended", {
        params ["_endType"];
        [format ["Mission Ended, endtype: %1",_endType]] call FUNC(log);

        if GVAR(endLogToRPT) then {
            diag_log "[TMF Adminmenu] Printing complete log to RPT";
            {
                _x params [
                    ["_time",CBA_missionTime,[-1]],
                    ["_text","",[""]],
                    ["_isWarning",false,[false]]
                ];

                private _text = format ["[%1]: %2", [_time,"MM:SS"] call BIS_fnc_secondsToString, _text];
                private _warning = if (_isWarning) then [{"[WARNING] "},{""}];
                diag_log (_warning + _text);
            } forEach GVAR(listEntries);
            diag_log "[TMF Adminmenu] Log end";
        };

        // Print to debriefing
        private _strArr = GVAR(listEntries) apply {
            _x params [
                ["_time",CBA_missionTime,[-1]],
                ["_text","",[""]],
                ["_isWarning",false,[false]]
            ];

            private _text = format ["[%1]: %2", [_time,"MM:SS"] call BIS_fnc_secondsToString, _text];
            private _warning = if (_isWarning) then [{"[WARNING] "},{""}];
            (_warning + _text)
        };
        GVAR(debrief) = _strArr joinString "<br/>";
        {
            _x publicVariableClient QGVAR(debrief);
        } forEach ((allPlayers select {[_x] call FUNC(isAuthorized)}) apply {owner _x});
    }];

    GVAR(disconnectEH) = addMissionEventHandler ["HandleDisconnect",{
        params ["_unit", "_id", "_uid", "_name"];
        if !(typeOf _unit isEqualTo QEGVAR(spectator,unit)) then {
            [format ["Player disconnected while not spectator: %1", _name], true] call FUNC(log);
        };
    }];
};

// Trigger Hunt.
[QGVAR(hunt), {
    // Find player side
    private _playerSide = west; // Default.
    private _playerCount = {side _x == west && {isPlayer _x}} count (playableUnits + switchableUnits);

    private _eastCount = {side _x == east && {isPlayer _x}} count (playableUnits + switchableUnits);
    if (_eastCount > _playerCount) then {
        _playerSide = east;
        _playerCount = _eastCount;
    };
    private _indCount = {side _x == independent && {isPlayer _x}} count (playableUnits + switchableUnits);
    if (_indCount > _playerCount) then {
        _playerSide = independent;
        _playerCount = _indCount;
    };

    // Find AI Sides.
    private _aiSides = [west, east, independent] select {[_playerSide, _x] call BIS_fnc_sideIsEnemy};

    private _hunters = allUnits select {(!isPlayer _x) && {(side _x) in _aiSides}};


    // Setup units.
    private _oldGroups = [];
    {
        private _unit = _x;
        _oldGroups pushBackUnique (group _unit);

        [_unit] joinSilent grpNull;
        _unit setUnitPos "UP";
        _unit disableAI "SUPPRESSION";
        _unit disableAI "AUTOCOMBAT"; // Already applied at init but reapply.
        _unit setBehaviour "AWARE";
        _unit setSpeedMode "FULL";

        // Just in case MM went crazy.
        _unit enableAI "PATH";
        _unit enableAI "MOVE";

        _unit allowFleeing 0;
        doStop _unit;


    } forEach _hunters;

    // Cleanup groups no longer used.
    {
        if (count (units _x) == 0) then {deleteGroup _x;};
    } forEach (_oldGroups - [grpNull]);

    //params ["_hunters", "_targetSide", "_position", "_range",["_targets",[]]]
    private _targets = allUnits select {side _x == _playerSide && isPlayer _x};
    [_hunters,_playerSide,[0,0,0],6000,_targets] spawn EFUNC(ai,huntLoop);
}] call CBA_fnc_addEventHandler;

if (isMultiplayer) then {
    GVAR(activeClients) = [];

    private _id = addMissionEventHandler ["HandleDisconnect", {
        private _clientOwnerId = _this select 4;
        GVAR(activeClients) = GVAR(activeClients) - [_clientOwnerId];

        if (((count GVAR(activeClients)) isEqualTo 0) && {!isNil QGVAR(fps_pfh)}) then {
            [GVAR(fps_pfh)] call CBA_fnc_removePerFrameHandler;
            GVAR(fps_pfh) = nil;
        };
    }];

    if (hasInterface) then {
        QGVAR(fps) addPublicVariableEventHandler {
            disableSerialization;

            private _ctrl = (uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl IDC_TMF_ADMINMENU_FPS;
            if (isNull _ctrl) exitWith {};

            _ctrl ctrlSetText format ["%1 SFPS", _this select 1];
        };
        QGVAR(headlessInfo) addPublicVariableEventHandler {
            disableSerialization;

            private _ctrl = ((uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl IDC_TMF_ADMINMENU_G_DASH) controlsGroupCtrl IDC_TMF_ADMINMENU_DASH_HEADLESS;
            if (isNull _ctrl) exitWith {};

            _ctrl ctrlSetText (_this select 1);
            _ctrl ctrlSetTooltip (_this select 1);
        };

        QGVAR(currentAdmin) addPublicVariableEventHandler {
            disableSerialization;

            private _ctrl = ((uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl IDC_TMF_ADMINMENU_G_DASH) controlsGroupCtrl IDC_TMF_ADMINMENU_DASH_CURRADMIN;
            if (isNull _ctrl) exitWith {};

            _ctrl ctrlSetText (_this select 1);
        };

        [QGVAR(quickRespawn), {
            call FUNC(utility_quickRespawn_local);
        }] call CBA_fnc_addEventHandler;
    };
};
