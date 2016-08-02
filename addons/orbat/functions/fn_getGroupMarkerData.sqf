#include "\x\tmf\addons\orbat\script_component.hpp"

params ["_group"];

private _cachedData = _group getVariable ["TMF_groupMarker_Cached",-1];
if (_cachedData isEqualTo -1) exitWith {
    private _data = _group getVariable ["TMF_groupMarker",[]];
    if(_data isEqualType "") then {
        _data = call compile _data;
    };
    _data = +_data;
    
    private _useParentTexture = false;
    
    if (count _data == 0) then { 
        _useParentTexture = true;
    } else {
        if ((_data select 0) isEqualTo "") then {
            _useParentTexture = true;
            _data = [];
        };
    };
        
    if (_useParentTexture) then {
        private _parentData = [_group] call FUNC(findOrbatParent);
        //while {count _parentData > 0} do {

        _parentData params ["_parentMarkerData"];
        _parentMarkerData params ["","_parentMarkerShortName","_parentMarkerTexture","_parentMarkerSizeTexture"];
        if (_parentMarkerTexture != "") exitWith {
            _data = [_parentmarkerTexture,(groupID _group),""];
        }
        //  private _parentData = [_group] call FUNC(findOrbatParent);
       // };
    };
    
    if (count _data > 0) then {
        
        //Replace the icon depending on side.
        private _path = _data select 0;
        private _side = side _group;
        private _targetColor = switch (_side) do {
            case west: {"blue_"};
            case east: {"red_"};
            case resistance: {"green_"};
            default {"yellow_"};
        };
        call {
            if (_path find "yellow_" != -1) exitWith {
                _idx = _path find "yellow_";
                _path = (_path select [0,_idx]) + _targetColor + (_path select [_idx+7]);
            };
            if (_path find "red_" != -1) exitWith {
                _idx = _path find "red_";
                _path = (_path select [0,_idx]) + _targetColor + (_path select [_idx+4]);
            };
            if (_path find "green_" != -1) exitWith {
                _idx = _path find "green_";
                _path = (_path select [0,_idx]) + _targetColor + (_path select [_idx+6]);
            };
             if (_path find "blue_" != -1) exitWith {
                _idx = _path find "blue_";
                _path = (_path select [0,_idx]) + _targetColor + (_path select [_idx+5]);
            };
        };
        
        _data set [0,_path];
    };
    if (count _data > 3) then {
        _data resize 3;
    };
    _group setVariable ["TMF_groupMarker_Cached", _data];
    _data;
};

_cachedData;
