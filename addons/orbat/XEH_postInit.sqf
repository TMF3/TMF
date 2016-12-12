#include "\x\tmf\addons\orbat\script_component.hpp"

if (!hasInterface) exitWith {}; // Only needed on clients

// ====================================================================================

params["_unit"];

// ====================================================================================
// Init the variables.

GVAR(orbatMarkerArray) = [];
GVAR(markerUpdateInterval) = 3;
GVAR(fireteamMarkerArray) = [];
GVAR(directionalFTMarkers) = getMissionConfigValue ["TMF_ORBATMarkersFT_Directional",false];

// ====================================================================================
// Actively monitor the BIS displays so that they function properly.

// Briefing
if (isMultiplayer) then {
    [] spawn {
        uiSleep 2;
        if(isServer) then {
            waitUntil {!isNull (findDisplay 52)};
             ((findDisplay 52) displayctrl 51) ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
        } else {
            waitUntil {!isNull (findDisplay 53)};
             ((findDisplay 53) displayctrl 51) ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
        };
    };
} else {
    [] spawn { // Work for single player briefing (EDEN preview)
        uiSleep 2;
        disableSerialization;
        {
            private _control = _x displayCtrl 51;
            if (ctrlMapScale _control != 0) then { // Is Map scale component
                _control ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
            };
        } forEach allDisplays;
    };
};

// Ingame Map
[{
    if (isNull findDisplay 12) exitWith {};

    ((findDisplay 12) displayctrl 51) ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
    [_this select 1] call CBA_fnc_removePerFrameHandler;
}, 0] call CBA_fnc_addPerFrameHandler;

//GPS
[{
    if (isNull (uiNamespace getVariable "RscMiniMap")) exitWith {};

    if ((((uiNamespace getVariable "RscMiniMap") displayctrl 101) ctrlAddEventHandler ["draw",{_this call FUNC(draw)}]) > 0) then {
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
}, 1] call CBA_fnc_addPerFrameHandler;


// ====================================================================================
// Actively monitor displays that are not created using createDialog as they are not easily trackable e.g. tao's folding map.

//Tao Folding map support.
if (isClass(configFile >> "CfgPatches" >> "tao_foldmap_a3")) then {
    [] spawn {
        disableSerialization;
        while {true} do {
            waitUntil {sleep 1;!isNull (uiNamespace getVariable "tao_foldmap")};
            private _control1 = ((uiNamespace getVariable "tao_foldmap") displayctrl 40);
            ((uiNamespace getVariable "tao_foldmap") displayctrl 40) ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
            ((uiNamespace getVariable "tao_foldmap") displayctrl 41) ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
            waitUntil{sleep 1;isNull _control1};
        };
    };
};

//ACE3 Micro Dagr
if (isClass(configFile >> "CfgPatches" >> "ace_microdagr")) then {

    [{
        disableSerialization;
        params["_args"];
        _args params ["_gm_ace_md_display","_gm_ace_md_dialog"];

        if (isNull _gm_ace_md_display) then {
            if (!isNull (uiNamespace getVariable "ace_microdagr_rsctitledisplay")) then {
                _gm_ace_md_display = ((uiNamespace getVariable "ace_microdagr_rsctitledisplay") displayctrl 77702);
                _gm_ace_md_display ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
                _args set [0,_gm_ace_md_display];
            };
        };

        if (isNull _gm_ace_md_dialog) then {
            if (!isNull (uiNamespace getVariable "ace_microdagr_dialogdisplay")) then {
                _gm_ace_md_dialog = ((uiNamespace getVariable "ace_microdagr_dialogdisplay") displayctrl 77702);
                _gm_ace_md_dialog ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
                _args set [1,_gm_ace_md_dialog];
            };
        };

    }, 1,[controlNull,controlNull]] call CBA_fnc_addPerFrameHandler;

};


GVAR(orbatTrackerCodeCondition) = getMissionConfigValue ["TMF_ORBATTrackerCondition","true"];
GVAR(orbatTrackerCodeCached) = false;
if (count GVAR(orbatTrackerCodeCondition) == 0) then { GVAR(orbatTrackerCodeCondition) = "true";};

[] call {
    //Error check by calling once.
    GVAR(orbatTrackerCodeCondition) = compile GVAR(orbatTrackerCodeCondition);
    private _return = call GVAR(orbatTrackerCodeCondition);
    if (isNil "_return" or {!(_return isEqualType true)}) then {
        GVAR(orbatTrackerCodeCondition) = {false};
        GVAR(orbatTrackerCodeCached) = false;
    } else {
        GVAR(orbatTrackerCodeCached) = _return;
    }
};
//check if return is a boolean.


FUNC(PFHUpdate) = {
    GVAR(orbatTrackerCodeCached) = [] call GVAR(orbatTrackerCodeCondition);
    if (GVAR(orbatTrackerCodeCached)) then {
        GVAR(orbatMarkerArray) call FUNC(updateArray);
    };
    
    if (!(getMissionConfigValue ['TMF_ORBATMarkersFT', false])) exitWith {};
    private _fireTeamMarkers = [];
    {
        if (!isNull _x) then {
            private _color = switch (assignedTeam _x) do {
              case "RED": {[0.9,0,0,0.85]};
              case "GREEN": {[0.25,0.45,0.15,0.85]};
              case "BLUE": {[0,0,0.9,0.85]};
              case "YELLOW": {[0.9,0.9,0,0.85]};
              default {[0.81,0.81,0.81,0.85]};
            };
            _fireTeamMarkers pushBack [(getPos _x),(getDir _x),_color];
        };
    } forEach (units (group player));
    GVAR(fireteamMarkerArray) = _fireTeamMarkers; // atomic :)
};


// Ensure player is loaded.

[{
    if (isNull (uiNamespace getVariable "RscMiniMap")) exitWith {};

    if ((((uiNamespace getVariable "RscMiniMap") displayctrl 101) ctrlAddEventHandler ["draw",{_this call tmf_orbat_fnc_draw}]) > 0) then {
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
}, 1] call CBA_fnc_addPerFrameHandler;



// Force a 1 second wait.
[{
    if ([] call BIS_fnc_isLoading) exitWith {};
    [_this select 1] call CBA_fnc_removePerFrameHandler;
    [{
        //Ensure a 0.5 second delay.
        params ["_params"];
        _params params ["_tickTime"];
        if (diag_tickTime < _tickTime + 0.5) exitWith {};
        
        [_this select 1] call CBA_fnc_removePerFrameHandler; 
        
        [{
            if (isNull player) exitWith {};
            [_this select 1] call CBA_fnc_removePerFrameHandler;

            [player, true] call FUNC(setup);
            [player] call FUNC(createBriefingPage);
        }, 0.5] call CBA_fnc_addPerFrameHandler;  
    },0.5,[diag_tickTime]] call CBA_fnc_addPerFrameHandler;
}, 0.5] call CBA_fnc_addPerFrameHandler;  



//Spawn thread to update fireteam positions overtime.

// Do an update to set initial positions, then add PFH.
[] call FUNC(PFHUpdate);
[FUNC(PFHUpdate), GVAR(markerUpdateInterval), []] call CBA_fnc_addPerFrameHandler;
