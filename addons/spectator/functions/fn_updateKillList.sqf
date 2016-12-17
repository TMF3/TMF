#include "\x\tmf\addons\spectator\script_component.hpp"
for "_i" from 1 to 6 do {
    private _index = count GVAR(killedUnits) - _i;
    private _control = (uiNamespace getvariable [QGVAR(labels),[]]) select _i;
    if(_index < (count GVAR(killedUnits)) && _index >= 0 ) then {
        private _data = GVAR(killedUnits) select (count GVAR(killedUnits) - _i);
        _data params ["_unit","_time","_killer","_deadSide","_killerSide","_dName","_kName","_weapon"];
        private _deltaTime = time - _time;
        if(_deltaTime <= 12 && _i < 6) then {
            if(_killer == _unit || isNull _killer) then {
                _control ctrlSetStructuredText parseText format ["<img image='\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa'/><t color='%2'>%1</t>",_dName,_deadSide call CFUNC(sidetohexcolor)];
            }
            else {
                _control ctrlSetStructuredText parseText format ["<t color='%4'>%1</t>  [%3]  <t color='%5'>%2</t>",_kName,_dName,_weapon,_killerSide call CFUNC(sidetohexcolor),_deadSide call CFUNC(sidetohexcolor)];
            };
        };
        if(_deltaTime > 12) then {
            GVAR(killedUnits) set [_index,0];
        };
    }
    else {
        _control ctrlSetStructuredText parseText "";
    }
};
GVAR(killedUnits) = GVAR(killedUnits) - [0];