#include "\x\tmf\addons\adminmenu\script_component.hpp"

#include "initKeybinds.sqf"

GVAR(tabPFHHandles) = [];
GVAR(playerManagement_listControls) = [];
GVAR(playerManagement_players) = [];
GVAR(playerManagement_selected) = [];

if (isMultiplayer && hasInterface) then {
    QGVAR(fps) addPublicVariableEventHandler {
        disableSerialization;

        private _ctrl = (uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl IDC_TMF_ADMINMENU_FPS;
        if (isNull _ctrl) exitWith {};

        _ctrl ctrlSetText format ["%1 SFPS", _this select 1];
    };
    QGVAR(headlessInfo) addPublicVariableEventHandler {
        disableSerialization;

        private _ctrl = ((uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl IDC_TMF_ADMINMENU_G_DASH) controlsGroupCtrl IDC_TMF_ADMINMENU_DASH_HEADLESS;
        if (isNull _ctrl) exitWith {};

        _ctrl ctrlSetText (_this select 1);
        _ctrl ctrlSetTooltip (_this select 1);
    };

    QGVAR(currentAdmin) addPublicVariableEventHandler {
        disableSerialization;

        private _ctrl = ((uiNamespace getVariable [QGVAR(display), displayNull]) displayCtrl IDC_TMF_ADMINMENU_G_DASH) controlsGroupCtrl IDC_TMF_ADMINMENU_DASH_CURRADMIN;
        if (isNull _ctrl) exitWith {};

        _ctrl ctrlSetText (_this select 1);
    };

    [QGVAR(quickRespawn), {
        call FUNC(utility_quickRespawn_local);
    }] call CBA_fnc_addEventHandler;
};
