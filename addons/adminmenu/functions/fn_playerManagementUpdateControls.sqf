#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;
params ["_display"];

private _list = _display displayCtrl IDC_TMF_ADMINMENU_PMAN_LIST;
private _ctrlGrp = ctrlParentControlsGroup _list;

private _numControls = count GVAR(playerManagement_listControls);
private _adjustControls = (lbSize _list) - _numControls;

// match control rows with listbox
if (_adjustControls > 0) then { // create more
    for "_i" from _numControls to (_numControls + _adjustControls - 1) do {
        private _ctrlDead = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlGrp];
        _ctrlDead ctrlSetText "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";

        private _ctrlSide = _display ctrlCreate ["RscPicture", -1, _ctrlGrp];
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
            _toDelete append (GVAR(playerManagement_listControls) select _i);
        };

        GVAR(playerManagement_listControls) resize lbSize _list;

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
private _ctrlHeight = ((ctrlPosition _list) select 3) / ((lbSize _list) max 1);
(ctrlPosition _ctrlGrp) params ["_grpX", "_grpY"];

// update control rows data and position
{
    _x params ["_ctrlDead", "_ctrlSide", "_ctrlQResp", "_ctrlSteam"];

    private _player = (_list lbData _forEachIndex) call BIS_fnc_objectFromNetId;
    private _isSpectator = _player isKindOf QEGVAR(spectator,unit);
    private _side = side _player;

    private _sideColor = [1,1,1,0.8];
    private _sideTexture = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";

    if (_isSpectator) then {
        private _sideColor = _side call CFUNC(sideToColor);

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

    _ctrlSteam ctrlSetTooltip format ["Open Steam profile of '%1'", name _player];
    _ctrlSteam ctrlSetStructuredText parseText format [
        "<a href='http://steamcommunity.com/profiles/%1' size='0.9'><img image='%2'/></a>",
        name _player,
        "\a3\ui_f\data\GUI\RscCommon\RscButtonMenuSteam\steam_ca.paa"
    ];
} forEach GVAR(playerManagement_listControls);
