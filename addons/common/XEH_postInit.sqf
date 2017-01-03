#include "\x\tmf\addons\common\script_component.hpp"

// IS TMF mission

if (isTMF) then {
    enableSaving [false, false]; // Disable mission saving
    enableSentences false; // Mute AI reports?

    STHud_NoSquadBarMode = true;
    if (hasInterface) then {
        [{
            if (time == 0) exitWith {};

            //Remove command bar from HUD.
            private _showHud = shownHUD;
            _showHud set [6,false];
            showHUD _showHud;
            

            // Turn on Weapon Safety.
            if (currentWeapon player != "" && {!isNil "ACE_safemode_fnc_lockSafety"} && {missionNamespace getVariable [QGVAR(weaponSafety),true]}) then {
                [player, currentWeapon player, currentMuzzle player] call ACE_safemode_fnc_lockSafety;
            };
            [_this select 1] call CBA_fnc_removePerFrameHandler;
        }, 0] call CBA_fnc_addPerFrameHandler;
    };
};

// TODO - Remove if added to ST HUD.
[{!isNil "STHud_GetName"},
{
    STHud_GetName =
    {
        params ["_unit", "_fullName"];
        private _value = _unit getVariable ["sth_name", []];
        if ((count(_value) isEqualTo 0) || {!(isPlayer(_unit) isEqualTo (_value select 0))}) then
        {
            private _newName = name (_unit);
            if (_newName != "") then {
                _value = [isPlayer(_unit), _newName, _unit call STHud_GetName_Short];
            } else {
                if (count _value > 0) then { // Already defined.
                    _value set [0,isPlayer(_unit)];
                } else {
                    _value = [isPlayer(_unit), "", ""];
                };
            };
            _unit setVariable ["sth_name", _value, false];
        };

        if (_fullName) then
        {
            _value select 1;
        }
        else
        {
            _value select 2;
        };
    };
}, []] call CBA_fnc_waitUntilAndExecute;
