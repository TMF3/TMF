#include "\x\tmf\addons\zeus\script_component.hpp"

if !(isServer) exitWith {};

params [["_curator",objNull]];

if (!(_curator getVariable [QGVAR(addAllUnits),false])) then {

    if (!(missionNamespace getVariable [QGVAR(addAllUnitsInit),false])) then {
        GVAR(curatorSharedUnits) = [];
        GVAR(curatorsShareAllUnits) = [_curator];
        ["AllVehicles", "InitPost", {
            params ["_unit"];
            if (side _unit != sideLogic) then {
                {
                    _x addCuratorEditableObjects [[_unit],true];
                } forEach GVAR(curatorsShareAllUnits);
                GVAR(curatorSharedUnits) pushBack _unit;
            };
        }, true, [], true] call CBA_fnc_addClassEventHandler;

        GVAR(addAllUnitsInit) = true;
    } else {
        GVAR(curatorSharedUnits) = GVAR(curatorSharedUnits) select {!isNull _x};
        _curator addCuratorEditableObjects [GVAR(curatorSharedUnits),true];
        GVAR(curatorsShareAllUnits) pushBackUnique _curator;
    };

    _curator setVariable [QGVAR(addAllUnits),true,true];
} else {
    //Ensure it is inited.
    if (missionNamespace getVariable [QGVAR(addAllUnitsInit),false]) then {
        // Remove units from being edited.
        GVAR(curatorSharedUnits) = GVAR(curatorSharedUnits) select {!isNull _x};
        private _units = ((GVAR(curatorSharedUnits) - switchableUnits) - playableUnits) - allPlayers; // Ensure players are still visible.
        _curator removeCuratorEditableObjects [_units,true];
        
        // Remove curator from various variables.
        GVAR(curatorsShareAllUnits) = GVAR(curatorsShareAllUnits) - [_curator];
        _curator setVariable [QGVAR(addAllBuildingObjectsToZeus),false,true];
    };
    _curator setVariable [QGVAR(addAllUnits),false,true];
};

