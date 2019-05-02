#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params["_fullmapWindow"];

// Render Triggers
{
    (triggerArea _x) params ["_a","_b","_angle","_isRectangle","_c"];
    private _pos = getPos _x;

    private _color = [0,0,1,0.6];
    (triggerActivation _x) params ["_by", "_type", "_repeating"];
    private _activated = triggerActivated _x;

    //If Activated.
    if (!_repeating && _activated) then {
        _color = [0,0,0,0.4];
    };

    if (_isRectangle) then {
        _fullmapWindow drawRectangle [_pos,_a,_b,_angle,_color,""];
    } else {
        _fullmapWindow drawEllipse [_pos,_a,_b,_angle,_color,""];
    };


     //Render Trigger Icon on top.
    _fullmapWindow drawIcon ["\a3\ui_f\data\map\markers\military\flag_ca.paa",_color,_pos,19,19,getDir (vehicle _x),"",0];
} forEach GVAR(Triggers);

// Wave Spawners
{
    private _pos = getPos _x;

    //background
    _fullmapWindow drawIcon ["\a3\3den\data\cfg3den\logic\texturebackgroundmodule_ca.paa",[1,1,1,0.5],_pos,26,26,0];
    _fullmapWindow drawIcon ["\x\tmf\addons\common\UI\logo_tmf_small_ca.paa",[0,0,0,0.5],_pos,20,20,0];

    private _text = "";
    private _wavesRemaining = _x getVariable ["Waves",1];
    if (_wavesRemaining > 0) then {
        _text = format["%1 waves remaining",_wavesRemaining];

        //Render linked Units.
        private _data = _x getVariable [QEGVAR(ai,waveData), []];
        {
            _x params ["_side","_units","_vehicles"];
            {
                _x params ["_type", "_unitPos", "_unitDir", "_loadout"];

                _fullmapWindow drawLine [_pos, _unitPos, [1,1,0,0.4]];
                _fullmapWindow drawIcon ["\a3\ui_f\data\map\vehicleicons\iconman_ca.paa",[1,1,0,0.3],_unitPos,19,19,_unitDir,"",0];
            } forEach _units;

            {
                _x params ["_type","_vehPos","_vehDir"];
                private _icon = getText (configfile >> "CfgVehicles" >> _type >> "icon");

                _fullmapWindow drawLine [_pos, _vehPos, [1,1,0,0.4]];
                _fullmapWindow drawIcon [_icon,[1,1,0,0.3],_vehPos,19,19,_vehDir,"",0];
            } forEach _vehicles;
        } forEach _data;
    } else {
        _text = "All spawned";
    };


    _fullmapWindow drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,1],_pos, 26, 26,0,_text,2,0.035,'PuristaSemibold','right'];
    
    


    {
         _fullmapWindow drawLine [_pos, getPos _x, [0,0,1,0.3]];
    } forEach (synchronizedObjects _x);
} forEach GVAR(WaveSpawners);

//Garrison.
{
    private _pos = getPos _x;


    //Render area.
    (_x getVariable ["objectArea",[0,0,0,false,0]]) params ["_a","_b","_angle","_isRectangle"];
    if (_isRectangle) then {
        _fullmapWindow drawRectangle [_pos,_a,_b,_angle,[0,0,0,0.6],""];
    } else {
        _fullmapWindow drawEllipse [_pos,_a,_b,_angle,[0,0,0,0.6],""];
    };

    //background
    _fullmapWindow drawIcon ["\a3\3den\data\cfg3den\logic\texturebackgroundmodule_ca.paa",[1,1,1,0.5],_pos,26,26,0];
    _fullmapWindow drawIcon ["\x\tmf\addons\common\UI\logo_tmf_small_ca.paa",[0,0,0,0.5],_pos,20,20,0];

    private _text = format["Garrison (Quantity: %1)",_x getVariable ["aiNumberToSpawn", 0]];

    //Text.
    _fullmapWindow drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,1],_pos, 26, 26,0,_text,2,0.035,'PuristaSemibold','right'];
    
    //Render syncrhoncised
    {
         _fullmapWindow drawLine [_pos, getPos _x, [0,0,1,0.3]];
    } forEach (synchronizedObjects _x);
} forEach GVAR(Garrison);

// Units
{
    if(alive _x) then {
        
        if(vehicle _x != _x && crew (vehicle _x) select 0 == _x || vehicle _x == _x) then
        {
            private _icon = (vehicle _x getVariable ["f_cam_icon",""]);
            if(_icon == "") then {
                _icon = getText (configfile >> "CfgVehicles" >> typeOf (vehicle _x) >> "icon");
                (vehicle _x) setVariable ["f_cam_icon",_icon];
            };

            private _color = (side _x) call tmf_common_fnc_sideToColor;

            private _pos = getPos _x;
            private _sizeX = 20;
            private _sizeY = 20;

            private _name = "";
            
            if (leader _x == _x && {isPlayer _x} count units _x > 0) then {_name = format["%1 - %2",toString(toArray(groupID (group _x)) - [45]),_name]};


            if (isPlayer _x) then {
                _name = name _x;
            } else {
                _color set [3,0.6]; // Alpha for AI.
            };
            if (_name != "") then {
                // Orbat style
                //_fullmapWindow drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,1],_pos, _sizeX, _sizeY,0,_name,2,0.035,'PuristaSemibold','right'];
                // Spectator
                _fullmapWindow drawIcon ["#(argb,8,8,3)color(0,0,0,0)",_color,_pos,19,19,0,_name,1,0.02,"EtelkaMonospacePro"];
            }; 

            //_fullmapWindow drawIcon [_icon,_color,_pos,19,19,getDir (vehicle _x),"",0,0.02,"EtelkaMonospacePro"];
            
            
            //Draw Icon
            //_fullmapWindow drawIcon [_texture1, _color, _pos, _sizeX, _sizeY, 0];
            _fullmapWindow drawIcon [_icon,_color,_pos,19,19,getDir (vehicle _x),"",0];
        };
    };

} forEach allUnits;

//TODO - Spectator map already has markers without having to render them manually like this.
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

