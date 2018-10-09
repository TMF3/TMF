#include "\x\tmf\addons\safeStart\script_component.hpp"

private _eh = player getVariable [QGVAR(firedEH),-1];
private _action = player getVariable [QGVAR(disableAction),-1];

if(_eh == -1 || _action == -1) exitWith {
    // do some form of error logging here ;D
};

// Allow damage
player allowDamage true;

// Remove EH
player removeEventHandler ["fired",_eh];

// Enable ACE throwing
ace_advanced_throwing_enabled = true;

// Remove action.
player removeAction _action;

// fade out the text!
DIALOG_IDD cutFadeOut 0;
DIALOG_IDD cutFadeOut 1;