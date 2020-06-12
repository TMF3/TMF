#include "\x\tmf\addons\common\script_component.hpp"

// IS TMF mission

if (isTMF) then {
    enableSaving [false, false]; // Disable mission saving
    enableSentences false; // Mute AI reports?

    if (hasInterface && GVAR(weaponSafety)) then {
        [{time > 0},
         {
            // Turn on Weapon Safety.
            if (currentWeapon player != "") then {
                [player, currentWeapon player, currentMuzzle player] call ACE_safemode_fnc_lockSafety;
            };
        }, 0] call CBA_fnc_waitUntilAndExecute;
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


if (isServer) then {
    // As group init variables are sent frame after init, wait double frames before sending VarSync.
    // This should then go to the end of the network traffic queue.
    [{
        [{
            GVAR(VarSync) = true;
            publicVariable QGVAR(VarSync);
        }] call CBA_fnc_execNextFrame;
    }] call CBA_fnc_execNextFrame;
};
