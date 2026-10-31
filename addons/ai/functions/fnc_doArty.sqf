#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_areas","_vehicles"];

{
    private _area = selectRandom _areas;
    private _bounds = [getPos _area] + (_area getVariable ["objectArea",0]);
    private _pos = [_bounds] call CFUNC(randPosArea);
    private _magazine = _logic getVariable ["Round", ""];
    _x setVehicleAmmo 1;
    if(!(_magazine isEqualType "") || _magazine == "" || !(_magazine in (magazines vehicle _x)) ) then {_magazine = currentMagazine _x;};
    (gunner _x) doArtilleryFire [_pos, _magazine, _logic getVariable ["RoundsPerSalvo", 1]];
} forEach _vehicles;

private _salvos = (_logic getVariable ["Salvos", 5]) -1;
_logic setVariable ["Salvos",_salvos];
if(_salvos > 0 || _salvos == -1) then {
    [FUNC(doArty),_this, (_logic getVariable ["TimeBetweenShots",5]) max 1] call CBA_fnc_waitAndExecute;
};
