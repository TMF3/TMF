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
