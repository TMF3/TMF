params ["_display"];
#include "\x\tmf\addons\spectator\script_component.hpp"

GVAR(unitUpdate) = -1; // Force unit list to update.
GVAR(vehicles) = [];
with uiNamespace do {
    GVAR(display) = _display;
    GVAR(unitlabel) = _display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_UNITLABEL;
    GVAR(unitlist) = _display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_UNITLIST;

    GVAR(vision) = _display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_VISION;

    GVAR(filter) = _display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_FILTER;
    GVAR(side) = _display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_BUTTON;
    GVAR(tagsbutton) = _display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_TAGS;
    GVAR(view) = _display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_VIEW;
    GVAR(mute) = _display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_MUTE;
    GVAR(map) = _display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_MAP;
    GVAR(compass) = [_display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_COMPASSLEFT,_display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_COMPASS,_display displayCtrl IDC_SPECTATOR_TMF_SPECTATOR_COMPASSRight];

    private _labelParent = _display displayCtrl 2300;
    GVAR(labels) = [
        _labelParent controlsGroupCtrl 6,
        _labelParent controlsGroupCtrl 7,
        _labelParent controlsGroupCtrl 8,
        _labelParent controlsGroupCtrl 9,
        _labelParent controlsGroupCtrl 10,
        _labelParent controlsGroupCtrl 11
    ];

    GVAR(map) ctrlShow (missionNamespace getVariable [QGVAR(showMap),false]);
    GVAR(map) mapCenterOnCamera false;

};




if(!getMissionConfigValue ["TMF_Spectator_AllSides",true]) then {
    GVAR(sides) = [tmf_spectator_entryside];
    GVAR(sides_button_mode) = [[tmf_spectator_entryside],[]];
    GVAR(sides_button_strings) = ["SHOWING YOUR SIDE","NONE"];
};

if (!isNil QGVAR(zeusPos) && { getMissionConfigValue ["TMF_Spectator_AllowFreeCam",true] }) then {

    GVAR(mode) = FREECAM;
    [] call FUNC(setTarget);

    private _pitch = GVAR(zeusPitchBank) select 0;
    GVAR(followcam_angle) = [GVAR(zeusDir),_pitch];
    GVAR(camera) setPos GVAR(zeusPos);
    GVAR(camera) setDir GVAR(zeusDir);
    [GVAR(camera),_pitch,0] call BIS_fnc_setPitchBank;
    GVAR(camera) camSetFov GVAR(followcam_fov);
    GVAR(camera) camCommit 0;
    GVAR(zeusPos) = nil;
} else {
    if (missionNamespace getVariable [QGVAR(mode),-1] isEqualTo - 1) then {
        private _allowedModes = [getMissionConfigValue ["TMF_Spectator_AllowFollowCam",true],getMissionConfigValue ["TMF_Spectator_AllowFreeCam",true],getMissionConfigValue ["TMF_Spectator_AllowFPCam",true]];
        {
            if(_x) exitWith {
                GVAR(mode) = _forEachIndex;
                [] call FUNC(setTarget);
            };
        } forEach _allowedModes;
    } else {
        // use pre-existing GVAR(mode)
        [] call FUNC(setTarget);
    };
};

// if ACRE2 is enabled, enable the mute button
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
    [true] call acre_api_fnc_setSpectator;
    private _data = ["ACRE2","HeadSet"] call CBA_fnc_getKeybind;
    GVAR(mute_key) = (_data select 5) select 0;
    GVAR(mute_modifers) = (_data select 5) select 1;

    // Add all languages
    if (!isNil "tmf_acre2_languagesTable") then {
        private _languages = tmf_acre2_languagesTable apply {_x select 0};
        _languages call acre_api_fnc_babelSetSpokenLanguages;
    };
}
else { // else remove it
    with uiNamespace do {
        GVAR(mute) ctrlShow false; // hide mute button
    };
};
