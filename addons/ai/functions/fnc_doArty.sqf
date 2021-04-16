#include "\x\tmf\addons\ai\script_component.hpp"
params ["_logic","_areas","_vehicles"];

{
    private _area = selectRandom _areas;
    private _bounds = [getpos _area] + (_area getvariable ["objectArea",0]);
    private _pos = [_bounds] call CFUNC(randPosArea);
    private _magazine = _logic getVariable ["Round", ""];
    _x setVehicleAmmo 1;
    if(!(_magazine isEqualType "") || _magazine == "" || !(_magazine in (magazines vehicle _x)) ) then {_magazine = currentMagazine _x;};
    (gunner _x) doArtilleryFire [_pos, _magazine, _logic getVariable ["RoundsPerSalvo", 1]];
} foreach _vehicles;

private _salvos = (_logic getVariable ["Salvos", 5]) -1;
_logic setvariable ["Salvos",_salvos];
if(_salvos > 0 || _salvos == -1) then {
    [FUNC(doArty),_this, (_logic getvariable ["TimeBetweenShots",5]) max 1] call CBA_fnc_waitAndExecute;
};
