#include "\x\tmf\addons\adminmenu\script_component.hpp"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"

disableSerialization;
params ["_ctrlGroup"];

GVAR(utility_teleport_toggle) = false;
GVAR(utility_teleport_drawEnemy) = 0;
GVAR(utility_teleport_paradrop) = 0;

(ctrlPosition _ctrlGroup) params ["_ctrlGrpX", "_ctrlGrpY", "_ctrlGrpWidth", "_ctrlGrpHeight"];
_ctrlGroup ctrlEnable false;

private _display = uiNamespace getVariable [QGVAR(modalDisplay), displayNull];
private _ctrlMap = _display ctrlCreate ["RscMapControl", -1];
GVAR(utilityTabControls) pushBack _ctrlMap;
_ctrlMap ctrlSetPosition [_ctrlGrpX, _ctrlGrpY, _ctrlGrpWidth, _ctrlGrpHeight - (2.2 * GUI_GRID_H)];
_ctrlMap ctrlCommit 0;
if (!isNull cameraOn) then {
    _ctrlMap ctrlMapAnimAdd [0, ctrlMapScale _ctrlMap, cameraOn];
    ctrlMapAnimCommit _ctrlMap;
};
_ctrlMap ctrlAddEventHandler ["mouseButtonClick", {
    params ["_ctrlMap", "", "_pos_x", "_pos_y"];

    private _toggle = missionNamespace getVariable [QGVAR(utility_teleport_toggle), false];
    if (_toggle) then {
        GVAR(utility_teleport_toggle) = !_toggle;
        (_ctrlMap getVariable [QGVAR(association), controlNull]) ctrlSetText (["Enable Teleport", "Disable Teleport"] select GVAR(utility_teleport_toggle));

        private _numPlayers = count GVAR(utilityData);

        { // swap vehicle crew with their vehicle
            if (!isNull objectParent _x) then {
                GVAR(utilityData) set [_forEachIndex, objectParent _x];
            };
        } forEach GVAR(utilityData);
        GVAR(utilityData) = GVAR(utilityData) arrayIntersect GVAR(utilityData);

        private _pos = _ctrlMap ctrlMapScreenToWorld [_pos_x, _pos_y];

        [{
            params ["_args", "_pfh"];
            _args params ["_pos", "_units"];

            if (count _units == 0) exitWith {
                [_pfh] call CBA_fnc_removePerFrameHandler;
            };
            private _isParadropped = (missionNamespace getVariable [QGVAR(utility_teleport_paradrop), 0]) == 1;

            private _unit = _units deleteAt 0;

            if (_unit isKindOf "CAManBase") then { // humans
                if (_isParadropped) then {
                    private _parachute = createVehicle ["Steerable_Parachute_F", _pos, [], 50, "FLY"];
                    _parachute allowDamage false;
                    private _newPos = getPos _parachute;
                    _newPos set [2, 500];
                    _parachute setPos _newPos;

                    _unit moveInAny _parachute;

                    "[TMF Admin Menu] You were paradropped" remoteExec ["systemChat", _unit];
                } else {
                    _unit setVehiclePosition [_pos, [], 0, "FORM"];
                    "[TMF Admin Menu] You were teleported" remoteExec ["systemChat", _unit];
                };
            } else { // vehicles
                if (_unit isKindOf "AirVehicle" && !isTouchingGround _unit) then { // flying aircraft
                    private _velocity = velocity _unit;

                    private _height = ((getPosATL _unit) select 2) max 100;
                    if (_unit isKindOf "Plane") then {
                        _height = _height max 500;
                    };
                    private _newPos = +_pos;
                    _newPos set [2, _height];
                    _unit setPos _newPos;
                    [_unit, _newPos] remoteExec ["setPos", _unit];

                    if (_unit isKindOf "Plane") then { // only planes need velocity; for helicopters this is risky
                        _velocity set [2, 0 max (_velocity select 2)];
                        if (vectorMagnitude _velocity < 100) then {
                            _velocity = _velocity vectorMultiply (100 / vectorMagnitude _velocity);
                        };

                        [_unit, _velocity] remoteExec ["setVelocity", _unit];
                    };
                } else {
                    _unit setVehiclePosition [_pos, [], 0, "FORM"];
                };

                private _crew = crew _unit;
                "[TMF Admin Menu] Your vehicle was teleported" remoteExec ["systemChat", _crew];
            };
        }, 0.1, [_pos, +GVAR(utilityData)]] call CBA_fnc_addPerFrameHandler;

        systemChat format ["[TMF Admin Menu] Teleported %1 players", _numPlayers];

        [format [
            "%1 %2 %3 %4 %5",
            profileName,
            if _isParadropped then [{"Paradropped"},{"Teleported"}],
            GVAR(utilityData) apply {name _x},
            if _isParadropped then [{"at"},{"to"}],
            _pos
        ],false,"Admin Menu"] call FUNC(log);
    };
}];
_ctrlMap ctrlAddEventHandler ["draw", {
    params ["_ctrlMap"];
    if ((missionNamespace getVariable [QGVAR(utility_teleport_drawEnemy), 0]) == 1) then {
        {
            _ctrlMap drawIcon ["\a3\ui_f\data\Map\Markers\Military\dot_CA.paa", (side _x) call FUNC(sideToColor), getPos _x, 24, 24, 0];
        } forEach allUnits;
    } else {
        private _pos = [];
        {
            if ((side _x) isEqualTo (side player)) then {
                _pos = getPos _x;
                _ctrlMap drawIcon ["\a3\ui_f\data\Map\Markers\Military\dot_CA.paa", [0,0,0,1], _pos, 24, 24, 0];
                _ctrlMap drawIcon ["\a3\ui_f\data\Map\Markers\Military\dot_CA.paa", (side _x) call FUNC(sideToColor), _pos, 20, 20, 0];
            };
        } forEach playableUnits;
    };
}];

private _ctrlCheckDrawAllSides = _display ctrlCreate ["RscCheckBox", -1];
GVAR(utilityTabControls) pushBack _ctrlCheckDrawAllSides;
_ctrlCheckDrawAllSides ctrlSetPosition [_ctrlGrpX, _ctrlGrpY + _ctrlGrpHeight - (2.2 * GUI_GRID_H), GUI_GRID_W, GUI_GRID_H];
_ctrlCheckDrawAllSides ctrlCommit 0;
_ctrlCheckDrawAllSides ctrlAddEventHandler ["CheckedChanged", {
    GVAR(utility_teleport_drawEnemy) = param [1];
}];

private _ctrlLabelDrawAllSides = _display ctrlCreate [QGVAR(RscText), -1];
GVAR(utilityTabControls) pushBack _ctrlLabelDrawAllSides;
_ctrlLabelDrawAllSides ctrlSetPosition [_ctrlGrpX + GUI_GRID_W, _ctrlGrpY + _ctrlGrpHeight - (2.2 * GUI_GRID_H), (0.2 * _ctrlGrpWidth) - GUI_GRID_W, GUI_GRID_H];
_ctrlLabelDrawAllSides ctrlCommit 0;
_ctrlLabelDrawAllSides ctrlSetText "Draw enemy units on map";

//private _paradropCheckX = (ctrlPosition _ctrlLabelDrawAllSides) select 0 + ctrlTextWidth _ctrlLabelDrawAllSides + GUI_GRID_W;
private _ctrlCheckParadropInfantry = _display ctrlCreate ["RscCheckBox", -1];
GVAR(utilityTabControls) pushBack _ctrlCheckParadropInfantry;
_ctrlCheckParadropInfantry ctrlSetPosition [_ctrlGrpX + (0.2 * _ctrlGrpWidth), _ctrlGrpY + _ctrlGrpHeight - (2.2 * GUI_GRID_H), GUI_GRID_W, GUI_GRID_H];
_ctrlCheckParadropInfantry ctrlCommit 0;
_ctrlCheckParadropInfantry ctrlAddEventHandler ["CheckedChanged", {
    GVAR(utility_teleport_paradrop) = param [1];
}];

private _ctrlLabelParadropInfantry = _display ctrlCreate [QGVAR(RscText), -1];
GVAR(utilityTabControls) pushBack _ctrlLabelParadropInfantry;
_ctrlLabelParadropInfantry ctrlSetPosition [_ctrlGrpX + (0.2 * _ctrlGrpWidth) + GUI_GRID_W, _ctrlGrpY + _ctrlGrpHeight - (2.2 * GUI_GRID_H), (0.2 * _ctrlGrpWidth) - GUI_GRID_W, GUI_GRID_H];
_ctrlLabelParadropInfantry ctrlCommit 0;
_ctrlLabelParadropInfantry ctrlSetText "Drop infantry in parachute";

private _ctrlHint = _display ctrlCreate [QGVAR(RscText), -1];
GVAR(utilityTabControls) pushBack _ctrlHint;
_ctrlHint ctrlSetPosition [_ctrlGrpX, _ctrlGrpY + _ctrlGrpHeight - GUI_GRID_H, 0.8 * _ctrlGrpWidth, GUI_GRID_H];
_ctrlHint ctrlCommit 0;
_ctrlHint ctrlSetText "After locating the destination area, press the Enable Teleport button and then click the desired location on the map.";

private _ctrlButton = _display ctrlCreate [QGVAR(RscButtonMenu), -1];
GVAR(utilityTabControls) pushBack _ctrlButton;
_ctrlButton ctrlSetPosition [_ctrlGrpX + 0.8 * _ctrlGrpWidth, _ctrlGrpY + _ctrlGrpHeight - GUI_GRID_H, 0.2 * _ctrlGrpWidth, GUI_GRID_H];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Enable Teleport";
_ctrlButton ctrlAddEventHandler ["buttonClick", {
    params ["_ctrlButton"];
    GVAR(utility_teleport_toggle) = !(missionNamespace getVariable [QGVAR(utility_teleport_toggle), false]);
    _ctrlButton ctrlSetText (["Enable Teleport", "Disable Teleport"] select GVAR(utility_teleport_toggle));
}];

_ctrlMap setVariable [QGVAR(association), _ctrlButton];
