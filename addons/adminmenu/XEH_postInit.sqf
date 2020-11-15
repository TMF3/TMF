#include "\x\tmf\addons\adminmenu\script_component.hpp"

#include "initKeybinds.sqf"

GVAR(tabPFHHandles) = [];
GVAR(playerManagement_listControls) = [];
GVAR(playerManagement_players) = [];
GVAR(playerManagement_selected) = [];

if (isTMF) then {
    [
        {time > 5 && [player, "logs"] call FUNC(isAuthorized)},
        {
            _this call FUNC(resyncLog);

            GVAR(endedEH) = addMissionEventHandler ["Ended", {
                params ["_endType"];

                GVAR(logEntries) pushBack [CBA_missionTime, format ["Mission Ended, endtype: %1",_endType], false];

                if GVAR(endLogToRPT) then {
                    [] call FUNC(printLogToRPT);
                };

                // Print to debriefing
                private _strArr = GVAR(logEntries) apply {
                    _x params [
                        ["_time",CBA_missionTime,[-1]],
                        ["_text","",[""]],
                        ["_isWarning",false,[false]]
                    ];

                    private _text = format ["[%1]: %2", [_time,"MM:SS"] call BIS_fnc_secondsToString, _text];
                    private _warning = if (_isWarning) then [{"[WARNING] "},{""}];
                    (_warning + _text)
                };
                GVAR(debrief) = _strArr joinString "<br/>";
            }];
        },
        clientOwner,
        30, // Timeout after 30 seconds
        {}
    ] call CBA_fnc_waitUntilAndExecute;

};



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
