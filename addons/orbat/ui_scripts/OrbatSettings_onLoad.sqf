TRACE_1("OrbatSettings onLoad",_params);
//Add EH On touch
private _ctrlGroup = _params select 0;
OrbatSettings_ctrlGroup = _ctrlGroup;

private _playableUnits = playableUnits;
_playableUnits pushBackUnique player;
cacheAllPlayerGroups = allGroups select {{_x in _playableUnits} count (units _x) > 0};

_ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {OrbatSettings_ctrlGroup = _this select 0;};}];
_ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {OrbatSettings_ctrlGroup = nil;};}];
{(_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MAIN_IDCS);
{(_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
{(_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);


OrbatSettings_Array = ("TMF_ORBAT_Settings" get3DENMissionAttribute "TMF_ORBATSettings");
if (OrbatSettings_Array isEqualType "") then {
    OrbatSettings_Array = call compile OrbatSettings_Array;
};

if (count OrbatSettings_array > 0) then {
    if ((((OrbatSettings_array) select 0) select 0) isEqualType 0) then {
        {
            _x set [0,(_x select 0) call EFUNC(common,numToSide)];
        } forEach OrbatSettings_Array;
    };
};

// DIK_RETURN = 0x1C
// Use enter key on controls seems to not work.
/*
{
    (_ctrlGroup controlsGroupCtrl _x) ctrladdeventhandler ["keyDown",{
        params ["_control","_key"];
        if (_key == 0x1C) exitWith {
            with uinamespace do {["editOrbatEntryClickOkay"] call OrbatSettings_script;};
            true;
        };
        false;
    }];
} forEach [115,123];
*/

// Test for now....
// parameters, children
//orbat [[],[]],

//Setup array in recursive manner....

// UNIQUE_ID will be used for verifying that an entity should be in the current thing.
// start at 0, then use next free available UNIQUE_ID?
// data = UNIQUE_ID , display name, texture1, texture2
//texture 2 is designed for size

// child = [[data],children]
//children [child,child,child]

/*OrbatSettings_Array = [
    [west,[
            [0,"1PLT","x\tmf\addons\orbat\textures\yellow.paa","x\tmf\addons\orbat\textures\modif_3dot.paa"],
            [
                [[1,"A","x\tmf\addons\orbat\textures\red_inf.paa","x\tmf\addons\orbat\textures\modif_dot.paa"],[]]
            ]
           ]],
    [east,[
            [2,"2PLT","x\tmf\addons\orbat\textures\yellow.paa","x\tmf\addons\orbat\textures\modif_3dot.paa"],
            [
                [[3,"A","x\tmf\addons\orbat\textures\red_inf.paa","x\tmf\addons\orbat\textures\modif_dot.paa"],[]]
            ]
           ]]
];*/


private _ctrlBin = _ctrlGroup controlsGroupCtrl 100;
private _ctrlToggle = _ctrlGroup controlsGroupCtrl 101;
private _ctrlTree = _ctrlGroup controlsGroupCtrl 102;

OrbatFactionsPresent = [];
OrbatSidesPresent = [];

{
    OrbatFactionsPresent pushBackUnique (faction (leader _x));
    OrbatSidesPresent pushBackUnique (side _x);
} forEach cacheAllPlayerGroups;


private _string = "";
private _found = false;
//Open on last open thing if valid.
if (!isNil "OrbatSelection") then {
    {
        if ((_x select 0) isEqualTo OrbatSelection) exitWith {_found = true;};
    } forEach OrbatSettings_Array;
};

if (!_found) then {
    //Default
    if (count OrbatSidesPresent > 0) then {
        OrbatSelection = OrbatSidesPresent select 0;
    } else {
        OrbatSelection = east;
    };
    if (count OrbatSettings_Array > 0) then {
        private _entry = ((OrbatSettings_Array select 0) select 0);
        OrbatSelection = _entry;
        if (_entry isEqualType east) then {
            _ctrlBin lbSetCurSel 0;
        } else {
            _ctrlBin lbSetCurSel 1;
        };
    };
};
if (OrbatSelection isEqualType east) then {
    _string = OrbatSelection call EFUNC(common,sideToString);
};
if (OrbatSelection isEqualType "") then {
    _string = getText (configfile >> "CfgFactionClasses" >> OrbatSelection >> "displayName");
};

_ctrlToggle ctrlSetText format["< %1 >", _string];



["refreshTree"] call OrbatSettings_script;
