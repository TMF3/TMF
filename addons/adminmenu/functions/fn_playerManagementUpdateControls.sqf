#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;
private _ctrlGrp = ctrlParentControlsGroup _list;

private _numControls = count GVAR(playerManagement_listControls);
private _adjustControls = (lbSize _list) - _numControls;

//systemChat format ["CONTROL PRE  Players: %1 | List rows: %2 | _adjustControls: %3 | Controls: %4", count GVAR(playerManagement_players), lbSize _list, _adjustControls, count GVAR(playerManagement_listControls)];
diag_log format ["CONTROL PRE  Players: %1 | List rows: %2 | _adjustControls: %3 | Controls: %4", count GVAR(playerManagement_players), lbSize _list, _adjustControls, count GVAR(playerManagement_listControls)];

// match control rows with listbox
if (_adjustControls > 0) then { // create more
    for "_i" from _numControls to (_numControls + _adjustControls - 1) do {
        private _ctrlDead = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlGrp];
        _ctrlDead ctrlSetText "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";

        private _ctrlSide = _display ctrlCreate ["RscPicture", -1, _ctrlGrp];
        //_ctrlSide ctrlSetText QPATHTOF(square_ca.paa);
        _ctrlSide ctrlSetText "\a3\ui_f\data\Map\Markers\Military\box_CA.paa";
        _ctrlSide ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);

        private _ctrlQResp = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlGrp];
        _ctrlQResp ctrlSetText "\a3\ui_f\data\IGUI\RscTitles\MPProgress\respawn_ca.paa";

        private _ctrlSteam = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];

        GVAR(playerManagement_listControls) pushBack [_ctrlDead, _ctrlSide, _ctrlQResp, _ctrlSteam];
    };
} else {
    if (_adjustControls < 0) then { // delete overflow
        private _toDelete = [];
        for "_i" from (lbSize _list) to ((count GVAR(playerManagement_listControls)) - 1) do {
            _toDelete append (GVAR(playerManagement_listControls) param [_i]);
        };

        GVAR(playerManagement_listControls)    resize lbSize _list;

        {
            ctrlDelete _x;
        } forEach _toDelete;
    };
};


private _xPos = [
    TMF_ADMINMENU_PMAN_X_DEAD,
    TMF_ADMINMENU_PMAN_X_SIDE,
    TMF_ADMINMENU_PMAN_X_QRESP,
    TMF_ADMINMENU_PMAN_X_STEAM
];
private _stdWidth = TMF_ADMINMENU_STD_WIDTH;
private _stdHeight = 0.978 * TMF_ADMINMENU_STD_HEIGHT;
private _ctrlHeight = ((ctrlPosition _list) param [3]) / ((lbSize _list) max 1);

diag_log "_stdHeight _ctrlHeight a/b";
diag_log _stdHeight;
diag_log _ctrlHeight;
diag_log (_stdHeight / _ctrlHeight);

(ctrlPosition _ctrlGrp) params ["_grpX", "_grpY"];


// update control rows data and position
{
    _x params ["_ctrlDead", "_ctrlSide", "_ctrlQResp", "_ctrlSteam"];

    /*for "_i" from 0 to ((count _x) - 1) do {
        (_x param [_i]) ctrlSetPosition [
            _grpX + (_xPos param [_i]),
            _grpY + (_stdHeight * (_forEachIndex - 1)) - (0.1 * _stdHeight),
            [_stdWidth, _stdWidth * 2.5] select (_i isEqualTo 3),
            _stdHeight
        ];
        (_x param [_i]) ctrlCommit 0;
    };*/

    /*{
        _x ctrlSetPosition [
            _grpX + (_xPos param [_forEachIndex]),
            _grpY + (_ctrlHeight * (_i - 1)),
            _stdWidth,
            _ctrlHeight
        ];
        _x ctrlCommit 0;
    } forEach [_ctrlDead, _ctrlSide, _ctrlQResp, _ctrlSteam];*/

    private _player = (_list lbData _forEachIndex) call BIS_fnc_objectFromNetId;
    private _isSpectator = _player isKindOf QEGVAR(spectator,unit);
    private _side = side _player;
    /*if (_isSpectator || isPlayer _player) then { // debug
        //_side = _player getVariable [QEGVAR(spectator,side), sideUnknown];
        _ctrlDead ctrlShow true; // player must be dead; show dead icon
        _ctrlDead ctrlSetTooltip format ["'%1' is in spectator", name _player];

         // debug
        if (true || count (_player getVariable [QEGVAR(spectator,deathData), []]) >= 5) then { // enough data available for quick respawn
            _ctrlQResp ctrlRemoveAllEventHandlers "MouseButtonClick";
            _ctrlQResp ctrlAddEventHandler ["MouseButtonClick", format ["(param [0]) ctrlEnable false; %1 call %2", [_list lbData _forEachIndex], QFUNC(quickRespawn)]];
            _ctrlQResp ctrlShow true;
            _ctrlQResp ctrlEnable true;
            _ctrlQResp ctrlSetTooltip format ["Quick Respawn '%1' to their pre-death state", name _player];
        } else {
            _ctrlQResp ctrlShow false;
            _ctrlQResp ctrlEnable false;
        };
    } else {
        _ctrlDead ctrlShow false;
        _ctrlQResp ctrlShow false;
        _ctrlQResp ctrlEnable false;
    };*/

    private _sideColor = [1,1,1,0.8];
    private _sideTexture = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";

    if (_isSpectator) then {
        switch (_side) do {
            case blufor: { 
                _sideColor = GVAR(sideColors) param [0];
            };
            case opfor: { 
                _sideColor = GVAR(sideColors) param [1];
            };
            case independent: { 
                _sideColor = GVAR(sideColors) param [2];
            };
            case civilian: { 
                _sideColor = GVAR(sideColors) param [3];
            };
            case sideLogic: {
                _sideColor = [0.9,0.8,0,0.8];
            };
        };
        
        _list lbSetPicture [_forEachIndex, _sideTexture];
        _list lbSetPictureColor [_forEachIndex, _sideColor];
    } else {
        switch (_side) do {
            case blufor: { 
                _sideTexture = "W:\Steam\SteamApps\common\Arma 3\Addons\ui_f_data\a3\ui_f\data\Map\Diary\Icons\playerWest_ca.paa"; 
            };
            case opfor: { 
                _sideTexture = "W:\Steam\SteamApps\common\Arma 3\Addons\ui_f_data\a3\ui_f\data\Map\Diary\Icons\playerEast_ca.paa";
            };
            case independent: { 
                _sideTexture = "W:\Steam\SteamApps\common\Arma 3\Addons\ui_f_data\a3\ui_f\data\Map\Diary\Icons\playerGuer_ca.paa";
            };
            case civilian: { 
                _sideTexture = "W:\Steam\SteamApps\common\Arma 3\Addons\ui_f_data\a3\ui_f\data\Map\Diary\Icons\playerCiv_ca.paa";
            };
            case sideLogic: {
                _sideTexture = "W:\Steam\SteamApps\common\Arma 3\Addons\ui_f_data\a3\ui_f\data\Map\Diary\Icons\playerVirtual_ca.paa";
            };
            default {
                _sideTexture = "W:\Steam\SteamApps\common\Arma 3\Addons\ui_f_data\a3\ui_f\data\Map\Diary\Icons\playerBriefUnknown_ca.paa";
            };
        };

        _list lbSetPicture [_forEachIndex, _sideTexture];
        _list lbSetPictureColor [_forEachIndex, _sideColor];
    };
    
    /*if (random 2 > 1) then {
        _ctrlSide ctrlSetText "\a3\ui_f\data\Map\Markers\Military\box_CA.paa";
    };*/
    //_ctrlSide ctrlCommit 0;

    //_ctrlSide ctrlSetText format (["#(argb,8,8,3)color(%1,%2,%3,%4)"] + _color);
    //_ctrlSide ctrlSetText format ["#(argb,8,8,3)color(%1,%2,%3,%4)", _color param [0], _color param [1], _color param [2], _color param [3]];

    _ctrlSteam ctrlSetTooltip format ["Open Steam profile of '%1'", name _player];
    _ctrlSteam ctrlSetStructuredText parseText format [
        "<a href='http://steamcommunity.com/profiles/%1' size='0.9'><img image='%2'/></a>", 
        name _player,
        "\a3\ui_f\data\GUI\RscCommon\RscButtonMenuSteam\steam_ca.paa"
    ];
    //_ctrlSteam ctrlSetStructuredText parseText format ["<a href='http://steamcommunity.com/profiles/%1' size='0.8'>S</a>", getPlayerUID _player];
    //_ctrlSteam ctrlSetStructuredText parseText format ["<a href='http://steamcommunity.com/profiles/%1' size='0.8'>S</a>", name _player];
} forEach GVAR(playerManagement_listControls);

//systemChat format ["CONTROL POST Players: %1 | List rows: %2 | _adjustControls: %3 | Controls: %4", count GVAR(playerManagement_players), lbSize _list, _adjustControls, count GVAR(playerManagement_listControls)];
diag_log format ["CONTROL POST Players: %1 | List rows: %2 | _adjustControls: %3 | Controls: %4", count GVAR(playerManagement_players), lbSize _list, _adjustControls, count GVAR(playerManagement_listControls)];