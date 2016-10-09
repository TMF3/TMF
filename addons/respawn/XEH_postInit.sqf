#include "\x\tmf\addons\respawn\script_component.hpp"


GVAR(respawnMenuMarkers) = [
    ["\A3\ui_f\data\map\markers\nato\b_hq.paa","HQ","hq"],
    ["\A3\ui_f\data\map\markers\nato\b_inf.paa","Infantry","inf"],
    ["\A3\ui_f\data\map\markers\nato\b_support.paa","MG Team","mg_m"],
    ["\A3\ui_f\data\map\markers\nato\b_motor_inf.paa","Missle (AT/AA) Team","antitank"],
    ["\A3\ui_f\data\map\markers\nato\b_recon.paa","Sniper","recon"],
    ["\A3\ui_f\data\map\markers\nato\b_mortar.paa","Mortar Team","mortar"],
    ["\A3\ui_f\data\map\markers\nato\b_motor_inf.paa","APC/IFV","inf_mech"],
    ["\A3\ui_f\data\map\markers\nato\b_armor.paa","Armour","armor"],
    ["\A3\ui_f\data\map\markers\nato\b_air.paa","Heli","helo_cargo"],
    ["\A3\ui_f\data\map\markers\nato\b_plane.paa","Airplane/Jet","fixedwing"]   
];

// Respawn Marker Colours
// Format [r,g,b,alpha], GUI display name, colour name for optional pbo

GVAR(respawnMenuMarkerColours) = [
    [[1,0,0,1],"Red","red"],
    [[0,0,1,1],"Blue","blue"],
    [[0,1,0,1],"Green","green"],
    [[1,1,0,1],"Yellow","yellow"]
];

/*  [[1,0.647,0,1],"Orange","orange"],
    [[0,0,0,1],"Black","yellow"],
    [[1,1,1,1],"White","yellow"]*/

// SERVER INIT


if (isServer) then {
    
    //Counters to allow for unique IDs of respawned players and groups.
    GVAR(serverRespawnPlayerCounter) = 1;
    GVAR(serverRespawnGroupCounter) = 1;

    //Stores the marker information for all respawned groups
    GVAR(respawnedGroupsMarkerData) = [];
};

// CLIENT INIT

if (hasInterface) then {
    
    // Add a eventhandler to await for respawned group marker data.
    if (!isNil "tmf_script_setGroupMarkers") then {
        QGVAR(respawnedGroupsMarkerData) addPublicVariableEventHandler {
            [] call FUNC(respawnGroupMarkerUpdate);
        };
        
        // Create markers for any respawned markers that have occured before the client has joined.
        [] call FUNC(respawnGroupMarkerUpdate);
    };
};


