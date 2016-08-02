#include "\x\tmf\addons\respawn\script_component.hpp"

// Goes through GVAR(respawnedGroupsMarkerData), ensuring all groups already have markers.
if (isNil QGVAR(respawnedGroupsMarkerData)) exitWith {};

{
    //Check if Group already has a group marker.
    if (!isNil (_x select 0)) then {
        private _found = false;

        //Check if the entity is already setup to be drawn (aka in f_grpMkr_groups)
        private _entity = missionNamespace getVariable[(_x select 0),objNull];
        
        _found = (count ([EGVAR(orbat,orbatMarkerArray),_entity] call BIS_fnc_findNestedElement) != 0);

        //If not add the new group.
        if (!_found) then {
          //Check if we should be adding the group.
            private _toAdd = false;
            if(_entity isEqualType grpNull) then {
                _toAdd = faction player == faction leader _entity;
            } else {
                _toAdd = faction player == faction _entity;
            };

            if (_toAdd) then {
               // private _markerTexture = ((GVAR(respawnMenuMarkers) select (_x select 2)) select 0);
                //private _markerColorRGB = (GVAR(respawnMenuMarkerColours) select (_x select 3)) select 0;
                //private _size = [28,28];
                

				private _color = ((GVAR(respawnMenuMarkerColours) select (_x select 3)) select 2);
				private _type = ((GVAR(respawnMenuMarkers) select (_x select 2)) select 2);
				private _markerTexture = "x\tmf\addons\orbat\textures\" + _color + "_" + _type;
				private _markerColorRGB = [1,1,1,1];
				private _size = [32,32];

                ["",(_x select 1),[_markerTexture,_markerColorRGB,_size],"",_entity] call EFUNC(orbat,add);
            };
        };
    };
} forEach GVAR(respawnedGroupsMarkerData);