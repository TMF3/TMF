#include "\x\tmf\addons\orbat\script_component.hpp"

params["_mapControl"];

//Fireteam markers
if ((ctrlMapScale _mapControl) < 0.25) then {
    if (!isNil QGVAR(fireteamMarkerArray)) then {
        {
            _x params ["_pos", "_dir", "_color"];
            _color set [3,( 125 - ( ( _pos distance2D ( getPos player ) ) min 125 ) ) / 125];
            if GVAR(directionalFTMarkers) then {
            	_mapControl drawIcon["\a3\ui_f_curator\Data\CfgCurator\area_ca.paa",_color,_pos,12,12,_dir];
            } else {
            	_mapControl drawIcon["\a3\ui_f\data\map\Markers\Military\dot_ca.paa",_color,_pos,12,12,0,"",true];
            };
        } forEach GVAR(fireteamMarkerArray);
    };
};

//Orbat Markers
if (GVAR(orbatTrackerCodeCached)) then {
    [GVAR(orbatMarkerArray), _mapControl] call FUNC(drawArrayRec);
};