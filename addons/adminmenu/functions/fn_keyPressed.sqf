#include "\x\tmf\addons\adminmenu\script_component.hpp"

params ["", "_keyPressed"];
private _modifiersPressed = _this select [2, 3];

private _authorized = call BIS_fnc_isDebugConsoleAllowed;

private _binding = ["TMF", QGVAR(openKey)] call CBA_fnc_getKeybind;
if (isNil "_binding") exitWith {};
(_binding select 5) params ["_DIK", "_modifiers"];

private _handleKeypress = (_keyPressed isEqualTo _DIK) && (_modifiersPressed isEqualTo _modifiers);
if (_handleKeypress) then {
    if (_authorized) then {
        if (dialog && !isNull (uiNamespace getVariable [QGVAR(display), displayNull])) then {
            systemChat "[TMF Admin Menu] The admin menu is already open"
        } else {
            if (!isNull (findDisplay 312)) then {
                systemChat "[TMF Admin Menu] Can't open the admin menu in the Zeus interface";
            } else {
                createDialog QUOTE(ADDON);
            };
        };
    };
} else {
    _binding = ["TMF", QGVAR(spectatorRemoteControl)] call CBA_fnc_getKeybind;
    if (isNil "_binding") exitWith {};
    (_binding select 5) params ["_DIK", "_modifiers"];

    _handleKeypress = (_keyPressed isEqualTo _DIK) && (_modifiersPressed isEqualTo _modifiers);
    if (_handleKeypress) then {
        if (_authorized) then {
            if (isNull (findDisplay 5454)) then {
                if (isNull (missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull])) then {
                    systemChat "[TMF Admin Menu] Remote Control is available only through TMF Spectator";
                } else {
                    if (player isKindOf QEGVAR(spectator,unit)) then {
                        systemChat "[TMF Admin Menu] Use scroll menu action to stop remote control";
                    };
                };
            } else {
                if (isNil QEGVAR(spectator,target)) then {
                    systemChat "[TMF Admin Menu] No unit selected for Remote Control.";
                } else {
                    [EGVAR(spectator,target), true] call FUNC(remoteControl);
                };
            };
        };
    };
};

if (_handleKeypress && !_authorized) then {
    systemChat "[TMF Admin Menu] You're not authorized to use the admin menu";
};

true;
