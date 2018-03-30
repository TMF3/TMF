#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_ctrlGroup"];

(ctrlPosition _ctrlGroup) params ["", "", "_ctrlGrpWidth", "_ctrlGrpHeight"];

// Control setVariable Array (since Arma 3 v1.55.133553)
// ! ! ! ! !

/*GVAR(utility_assigngear_itemctrls) = [
    [combobox,x,x],
    [checkbox,x,x]
] ??
ctrlAddEventHandler format [
    "%1 select %2",
    QGVAR(utility_assigngear_itemctrls),
    _forEachIndex
]*/

/* create faction combo, checkbox
checkbox EH to populate combo
trigger EH with script command and have it populated immediately
remember last toggle setting, faction?

for role combos, have EH tick the change checkbox when new item selected
*/


private _ctrlCheckFaction = _display ctrlCreate ["RscCheckBox", -1, _ctrlGroup];
GVAR(utilityTabControls) = [_ctrlCheckFaction];
_ctrlCheckFaction ctrlSetPosition [0, 0, TMF_ADMINMENU_STD_WIDTH, TMF_ADMINMENU_STD_HEIGHT];
_ctrlCheckFaction ctrlCommit 0;

private _ctrlLabelFaction = _display ctrlCreate [QGVAR(RscTextLarge), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelFaction;
_ctrlLabelFaction ctrlSetPosition [TMF_ADMINMENU_STD_WIDTH, 0, (0.25 * _ctrlGrpWidth), TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelFaction ctrlCommit 0;
_ctrlLabelFaction ctrlSetText "Change Faction";


private _ctrlCheckFromMission = _display ctrlCreate ["RscCheckBox", -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlCheckFromMission;
_ctrlCheckFromMission ctrlSetPosition [(2 * TMF_ADMINMENU_STD_WIDTH) + (0.25 * _ctrlGrpWidth), 0, TMF_ADMINMENU_STD_WIDTH, TMF_ADMINMENU_STD_HEIGHT];
_ctrlCheckFromMission ctrlCommit 0;
_ctrlCheckFromMission ctrlAddEventHandler ["onCheckedChanged", {
    params ["_ctrlCheckBox", "_onlyPresent"];
    GVAR(utility_assigngear_onlypresent) = [false, true] select _onlyPresent;

    private _factions = [];

    if (GVAR(utility_assigngear_onlypresent)) then {
        _missionFactionsFound = [];
        {
            private _faction = _x getVariable [QEGVAR(assigngear,faction), ""];
            if !(_faction isEqualTo "") then {
                _missionFactionsFound pushBackUnique toLower _faction;
            };
        } forEach allPlayers;

        {
            private _displayName = getText (missionConfigFile >> "CfgLoadouts" >> _x >> "displayName");
            private _fromMissionConfig = 1;
            if (_displayName isEqualTo "") then {
                _displayName = getText (configFile >> "CfgLoadouts" >> _x >> "displayName");
                _fromMissionConfig = 0;
            };

            _factions pushBack [_displayName, _x, _fromMissionConfig];
        } forEach _missionFactionsFound;
    } else {
        private _missionConfigFactions = [];
        {
            _missionConfigFactions pushBack toLower configName _x;
            _factions pushBack [getText (_x >> "displayName"), configName _x, true];
        } forEach "true" configClasses (missionConfigFile >> "CfgLoadouts");

        {
            if !((toLower configName _x) in _missionConfigFactions) then {
                _factions pushBack [getText (_x >> "displayName"), configName _x, false];
            };
        } forEach "true" configClasses (configFile >> "CfgLoadouts");
    };

    _factions sort true;

    private _ctrlComboFaction = _ctrlCheckBox getVariable [QGVAR(association), controlNull];
    {
        params ["_displayName", "_className", "_fromMissionConfig"];
        if (_isFromMissionConfig isEqualTo 1) then {
            _displayName = format ["%1 [mission file]", _displayName];
        };

        _ctrlComboFaction lbAdd _displayName;
        _ctrlComboFaction lbSetData [_forEachIndex, _className];
        _ctrlComboFaction lbSetValue [_forEachIndex, _fromMissionConfig];
    } forEach _missionFactions;
}];

// ADD FACTIONS TO COMBO, ATTACH USER COUNT
// ADD CHECK EH; SELECT ITEM 0 ?
// TRIGGER EH BY SCRIPT ? (AFTER ADDING COMBO EH)

private _ctrlLabelFromMission = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelFromMission;
_ctrlLabelFromMission ctrlSetPosition [(3 * TMF_ADMINMENU_STD_WIDTH) + (0.25 * _ctrlGrpWidth), 0, (0.6 * _ctrlGrpWidth), TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelFromMission ctrlCommit 0;
_ctrlLabelFromMission ctrlSetText "List factions present in scenario only";

private _ctrlComboFaction = _display ctrlCreate ["RscCombo", -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlComboFaction;
_ctrlComboFaction ctrlSetPosition [(0.1 * TMF_ADMINMENU_STD_WIDTH), (1.1 * TMF_ADMINMENU_STD_HEIGHT), _ctrlGrpWidth - (0.2 * TMF_ADMINMENU_STD_WIDTH), TMF_ADMINMENU_STD_HEIGHT];
_ctrlComboFaction ctrlCommit 0;
_ctrlCheckFromMission setVariable [QGVAR(association), _ctrlComboFaction];
_ctrlComboFaction ctrlAddEventHandler ["onLBSelChanged", {
    params ["_ctrlComboFaction", "_index"];
    private _faction = _ctrlComboFaction lbData _index;

    private _factionConfig = configNull;
    if ((_ctrlComboFaction lbValue _index) isEqualTo 1) then {
        _factionConfig = (missionConfigFile >> "CfgLoadouts" >> _faction);
    } else {
        _factionConfig = (configFile >> "CfgLoadouts" >> _faction);
    };

    private _roles = ("true" configClasses _factionConfig) apply {[format ["%1 [%2]", getText (_x >> "displayName"), configName _x], toLower configName _x]};
    _roles sort true;
    private _rolesSimple = _roles apply {_x select 1};
    private _tickCheckbox = false;

    {
        (_x getVariable [QGVAR(association), [objNull, controlNull]]) params ["_player", "_ctrlComboRole"];

        private _playerRole = toLower (_player getVariable [QEGVAR(assigngear,role), ""]);
        if (_playerRole isEqualTo "" || !(_playerRole in _rolesSimple)) then {
            _playerRole = "r";
            _tickCheckbox = true;
        };

        while {(count _roles) < (lbSize _ctrlComboRole)} do {
            _ctrlComboRole lbDelete ((lbSize _ctrlComboRole) - 1);
        };

        {
            if (_forEachIndex >= (lbSize _ctrlComboRole)) then {
                _ctrlComboRole lbAdd (_x select 0);
            } else {
                _ctrlComboRole lbSetText [_forEachIndex, _x select 0];
            };

            _ctrlComboRole lbSetData [_forEachIndex, _x select 1];
            if ((_x select 1) isEqualTo _playerRole) then {
                _ctrlComboRole lbSetCurSel _forEachIndex;
            };
        } forEach _roles;

        if (_tickCheckbox) then {
            _x cbSetChecked true;
        };
    } forEach GVAR(utility_assigngear_rolectrls);
}];

private _ctrlLabelBracketNumbers = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelBracketNumbers;
_ctrlLabelBracketNumbers ctrlSetPosition [0, (2.2 * TMF_ADMINMENU_STD_HEIGHT), _ctrlGrpWidth, TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelBracketNumbers ctrlCommit 0;
_ctrlLabelBracketNumbers ctrlSetText "Number in brackets tell how many players use the loadout. * denotes a mission config loadout.";

private _ctrlLabelRoles = _display ctrlCreate [QGVAR(RscTextLarge), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlLabelRoles;
_ctrlLabelRoles ctrlSetPosition [0, (4.2 * TMF_ADMINMENU_STD_HEIGHT), (0.25 * _ctrlGrpWidth), TMF_ADMINMENU_STD_HEIGHT];
_ctrlLabelRoles ctrlCommit 0;
_ctrlLabelRoles ctrlSetText "Change Roles";

private _ctrlGrpRolesWidth = _ctrlGrpWidth - (0.2 * TMF_ADMINMENU_STD_WIDTH);
private _ctrlGrpRoles = _display ctrlCreate ["RscControlsGroup", -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlGrpRoles;
_ctrlGrpRoles ctrlSetPosition [(0.1 * TMF_ADMINMENU_STD_WIDTH), (5.3 * TMF_ADMINMENU_STD_HEIGHT), _ctrlGrpRolesWidth, _ctrlGrpHeight - (6.4 * TMF_ADMINMENU_STD_HEIGHT)];
_ctrlGrpRoles ctrlCommit 0;
_ctrlGrpRoles ctrlSetText "Number within brackets tell how many players use the loadout";

GVAR(utility_assigngear_rolectrls) = [];
private _ctrlLabelPlayerW = 0.4 * _ctrlGrpRolesWidth;
private _ctrlComboRoleX = 0.5 * _ctrlGrpRolesWidth;
private _ctrlComboRoleW = (0.5 * _ctrlGrpRolesWidth) - TMF_ADMINMENU_STD_WIDTH;
private _ctrlCheckChangeX = _ctrlGrpRolesWidth - TMF_ADMINMENU_STD_WIDTH;
{
    private _ctrlLineY = _forEachIndex * (1.1 * TMF_ADMINMENU_STD_HEIGHT);

    private _ctrlLabelPlayer = _display ctrlCreate [QGVAR(RscText), -1, _ctrlGrpRoles];
    GVAR(utilityTabControls) pushBack _ctrlLabelPlayer;
    _ctrlLabelPlayer ctrlSetPosition [0, _ctrlLineY, _ctrlLabelPlayerW, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlLabelPlayer ctrlCommit 0;
    _ctrlLabelPlayer ctrlSetText format ["%1 [%2]", name _x, _x getVariable [QEGVAR(assigngear,role), "no role"]];

    private _ctrlComboRole = _display ctrlCreate ["RscCombo", -1, _ctrlGrpRoles];
    GVAR(utilityTabControls) pushBack _ctrlComboRole;
    _ctrlComboRole ctrlSetPosition [_ctrlComboRoleX, _ctrlLineY, _ctrlComboRoleW, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlComboRole ctrlCommit 0;

    // ADD ROLES
    // SELECT ROLE OR RIFLEMAN IF UNDEF
    // ADD COMBO SELECT EH: TICK CHECKBOX

    private _ctrlCheckChange = _display ctrlCreate ["RscCheckBox", -1, _ctrlGrpRoles];
    GVAR(utilityTabControls) pushBack _ctrlCheckChange;
    GVAR(utility_assigngear_rolectrls) pushBack _ctrlCheckChange;
    _ctrlCheckChange ctrlSetPosition [_ctrlCheckChangeX, _ctrlLineY, TMF_ADMINMENU_STD_WIDTH, TMF_ADMINMENU_STD_HEIGHT];
    _ctrlCheckChange ctrlCommit 0;
    _ctrlCheckChange setVariable [QGVAR(association), [_x, _ctrlComboRole]];
} forEach GVAR(utilityData);

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1, _ctrlGroup];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [_ctrlGrpWidth - (_ctrlGrpWidth * 0.2), _ctrlGrpHeight - TMF_ADMINMENU_STD_HEIGHT, (_ctrlGrpWidth * 0.2), TMF_ADMINMENU_STD_HEIGHT];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Assign Gear";
_ctrlButton setVariable [QGVAR(association), [_ctrlCheckFaction, _ctrlComboFaction]];
_ctrlButton ctrlAddEventHandler ["buttonClick", {
    params ["_ctrlButton"];
    _ctrlButton call FUNC(debounceButton);

    (_ctrlButton getVariable [QGVAR(association), [controlNull, controlNull]]) params ["_ctrlCheckFaction", "_ctrlComboFaction"];
    private _setFaction = cbChecked _ctrlCheckFaction;
    private _selectedFaction = _ctrlComboFaction lbData (lbCurSel _ctrlComboFaction);

    {
        (_x getVariable [QGVAR(association), [objNull, controlNull]]) params ["_player", "_ctrlComboRole"];

        private _playerRole = _player getVariable [QEGVAR(assigngear,role), ""];
        if (cbChecked _x || _playerRole isEqualTo "") then {
            _playerRole = _ctrlComboRole lbData (lbCurSel _ctrlComboRole);
        };

        private _playerFaction = _player getVariable [QEGVAR(assigngear,faction), ""];
        if (_setFaction || _playerFaction isEqualTo "") then {
            _playerFaction = _selectedFaction;
        };

        [_player, _playerFaction, _playerRole] remoteExecCall [QEFUNC(assigngear,assigngear), _player];
    } forEach GVAR(utility_assigngear_rolectrls);

    systemChat format ["[TMF Admin Menu] Assigned gear to %1 players", count GVAR(utility_assigngear_rolectrls)];
}];
