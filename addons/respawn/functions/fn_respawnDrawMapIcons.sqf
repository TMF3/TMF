#include "\x\tmf\addons\respawn\script_component.hpp"

disableSerialization;
params["_fullmapWindow"];

{
	if(alive _x) then {
		private _name = "";
		if(isPlayer _x) then {_name = name _x};
		if(leader _x == _x && {isPlayer _x} count units _x > 0) then {_name = format["%1 - %2",toString(toArray(groupID (group _x)) - [45]),_name]};
		if(vehicle _x != _x && crew (vehicle _x) select 0 == _x || vehicle _x == _x) then
		{
			private _icon = (vehicle _x getVariable ["f_cam_icon",""]);
			if(_icon == "") then {_icon = gettext (configfile >> "CfgVehicles" >> typeOf (vehicle _x) >> "icon");vehicle _x setVariable ["f_cam_icon",_icon]};
            private _color = (side _x) call tmf_common_fnc_sideToColor;
			_fullmapWindow drawIcon [_icon,_color,getpos _x,19,19,getDir (vehicle _x),_name,1];
		};
	};

} forEach allUnits;

{
    private _markerShape = markerShape _x;
    private _markerPos = getMarkerPos _x;
    private _markerSize = getMarkerSize _x;
    private _markerColor = (configfile >> "CfgMarkerColors" >> getMarkerColor _x >> "color") call BIS_fnc_colorConfigToRGBA;
    private _markerDir = markerDir _x;
    
    switch (_markerShape) do {
        case "RECTANGLE": {
            private _markerBrush = getText (configfile >> "cfgMarkerBrushes" >> markerBrush _x >> "texture"); 
            _fullmapWindow drawRectangle [_markerPos, _markerSize select 0, _markerSize select 1, _markerDir, _markerColor, _markerBrush]
        };
        case "ELLIPSE": {
            private _markerBrush = getText (configfile >> "cfgMarkerBrushes" >> markerBrush _x >> "texture"); 
            _fullmapWindow drawEllipse  [_markerPos, _markerSize select 0, _markerSize select 1, _markerDir, _markerColor, _markerBrush]
        };
        case "ICON": {
            private _markerType = getMarkerType _x;
            if (_markerType != "Empty") then {
                _multiplier = 20;
                _markerIcon = getText (configfile >> "CfgMarkers" >> _markerType >> "icon");
                _markerText = markerText _x;
                _fullmapWindow drawIcon [_markerIcon, _markerColor, _markerPos, (_markerSize select 0) * _multiplier, (_markerSize select 1) * _multiplier, _markerDir, _markerText, 1];
            };
        };
    };    
} forEach allMapMarkers;


private _mousePos = GVAR(respawnMousePos);
private _i = 1;
while {true} do {
    private _var = missionNamespace getVariable[format["tmf_respawnPoint%1",_i],objNull];
    if (isNull _var) exitWith {};
    private _pos = (position _var);
    
    if (_i isEqualTo _mousePos) then {
        _fullmapWindow drawIcon ["\A3\ui_f\data\map\markers\military\start_CA.paa",[1,0,0,0.5],_pos,40,40,0];   
    };
    _fullmapWindow drawIcon ["\A3\ui_f\data\map\markers\military\start_CA.paa",[1,1,0,1],_pos,32,32,0,format["Respawn point %1",_i],1];
    
    _i = _i + 1;
};

if (_mousePos isEqualType []) then {
    if (count _mousePos > 1) then {
        private _text = "User selected respawn location";
        if (GVAR(respawnHalo)) then {
          _text = "User selected respawn location (HALO)";
        };
        _fullmapWindow drawIcon ["\A3\ui_f\data\map\markers\military\start_CA.paa",[1,0,0,1],_mousePos,20,20,0,_text,1];
    };
};