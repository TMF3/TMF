#include "\x\tmf\addons\adminmenu\script_component.hpp"

#include "initKeybinds.sqf"

if (isTMF) then {
    GVAR(disconnectEH) = addMissionEventHandler ["HandleDisconnect",{
        params ["_unit", "_id", "_uid", "_name"];
        if (typeOf _unit isNotEqualTo QEGVAR(spectator,unit)) then {
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

        if (((count GVAR(activeClients))  0) && {!isNil QGVAR(fps_pfh)}) then {
            [GVAR(fps_pfh)] call CBA_fnc_removePerFrameHandler;
            GVAR(fps_pfh) = nil;
        };
    }];
};
