#include "\x\tmf\addons\orbat\script_component.hpp"

if (!hasInterface) exitWith {}; // Only needed on clients

// ====================================================================================

params["_unit"];

// ====================================================================================
// Init the variables.

GVAR(orbatMarkerArray) = [];
//GVAR(markerUpdateInterval) = 3; // Moved to CBA settings
GVAR(fireteamMarkerArray) = [];
GVAR(directionalFTMarkers) = getMissionConfigValue ["TMF_ORBATMarkersFT_Directional",false];

// ====================================================================================
// Actively monitor displays that are not created using createDialog as they are not easily trackable e.g. tao's folding map.

//Tao Folding map support.
if (isClass(configFile >> "CfgPatches" >> "tao_foldmap_a3")) then {
    [] spawn {
        disableSerialization;
        while {true} do {
            private _display = displayNull;
            waitUntil {sleep 1;_display = (uiNamespace getVariable ["tao_foldmap",displayNull]); !isNull _display};
            private _control1 = _display displayctrl 40;
            (_display displayctrl 40) ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
            (_display displayctrl 41) ctrlAddEventHandler ["draw",{_this call FUNC(draw)}];
            waitUntil{sleep 1;isNull _control1};
        };
    };
};

//ACE3 Micro Dagr
/*if (isClass(configFile >> "CfgPatches" >> "ace_microdagr")) then {

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

};*/


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

GVAR(ftMarkersEnabled) = getMissionConfigValue ['TMF_ORBATMarkersFT', false];
FUNC(PFHUpdate) = {
    GVAR(orbatTrackerCodeCached) = [] call GVAR(orbatTrackerCodeCondition);
    if (GVAR(orbatTrackerCodeCached)) then {
        GVAR(orbatMarkerArray) call FUNC(updateArray);
    };

    if (!GVAR(ftMarkersEnabled)) exitWith {};
    private _fireTeamMarkers = (units player) select {!isNull _x} apply {
        [getPos _x, getDir _x,
            ([[0.81,0.81,0.81,0.85],[0.9,0,0,0.85],[0.25,0.45,0.15,0.85],[0,0,0.9,0.85],[0.81,0.81,0.81,0.85]]
            select ((["RED","GREEN","BLUE","YELLOW"] find (assignedTeam _x))+1))
        ];
    };
    GVAR(fireteamMarkerArray) = _fireTeamMarkers; // atomic :)
};


// Force a 1 second wait.
[{time > 0 && {!([] call BIS_fnc_isLoading)} && {!isNull player} && {!isNil QEGVAR(common,VarSync)}},{
    [player, true] call FUNC(setup);
    [player] call FUNC(createBriefingPage);
}, [], 0.5] call CBA_fnc_waitUntilAndExecute;

//Spawn thread to update fireteam positions overtime.

// Do an update to set initial positions, then add PFH.
[] call FUNC(PFHUpdate);
GVAR(PFHandler) = [FUNC(PFHUpdate), GVAR(markerUpdateInterval), []] call CBA_fnc_addPerFrameHandler;
