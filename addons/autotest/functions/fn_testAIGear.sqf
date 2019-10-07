#include "\x\tmf\addons\autotest\script_component.hpp"

private _output = [];

{
    private _config = (_x getVariable "TMF_aiGear_config");
    private _faction = (_x getVariable "TMF_aiGear_faction");
    private _role = "AI";

    if (!isClass _config) then
    {
        _output append [0,format ["Missing AI Class", str _config]];
    }
    else
    {
        _output append ([GETGEAR("uniform"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("vest"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("backpack"), CFGVEHICLES, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("headgear"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("goggles"), CFGGLASSES, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("hmd"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("insignias"), _faction, _role] call FUNC(checkExists_insignia));
        _output append ([GETGEAR("faces"), _faction, _role] call FUNC(checkExists_faces));
        _output append ([GETGEAR("voices"), _faction, _role] call FUNC(checkExists_voices));
        _output append ([GETGEAR("primaryWeapon"), CFGWEAPONS, _faction, _role, PRIMARYSLOT] call FUNC(checkExists));
        _output append ([GETGEAR("scope"), CFGWEAPONS, _faction, _role] call FUNC(checkExists));
        _output append ([GETGEAR("secondaryWeapon"), CFGWEAPONS, _faction, _role, SECONDARYSLOT] call FUNC(checkExists));
        _output append ([GETGEAR("sidearmWeapon"), CFGWEAPONS, _faction, _role, HANDGUNSLOT] call FUNC(checkExists));
    };

} forEach (allMissionObjects "TMF_assignGear_moduleLoadoutMacro");

_output
