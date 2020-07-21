
TRACE_1("OrbatSettings editOrbatEntryClickOkay",_params);
with uiNamespace do {
    private _ctrlIconToolbox = OrbatSettings_ctrlGroup controlsGroupCtrl 111;
    private _ctrlColourToolBox = OrbatSettings_ctrlGroup controlsGroupCtrl 113;
    private _ctrlNameEdit = OrbatSettings_ctrlGroup controlsGroupCtrl 115;
    private _ctrlSize = OrbatSettings_ctrlGroup controlsGroupCtrl 117;
    private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
    private _ctrlFullNameEdit = OrbatSettings_ctrlGroup controlsGroupCtrl 123;

    private _toolBoxIcon = ["", "_inf.paa", "_inf_airmobile.paa", "_inf_mech.paa", "_inf_mech_wheeled.paa", "_inf_motor.paa", "_inf_para.paa", "_amphi.paa", "_amphi_mech_inf.paa", "_airdef.paa", "_airdef_not_a_nipple.paa", "_antitank.paa", "_antitank_rocket.paa", "_armor.paa", "_armor_wheeled.paa", "_arm_airdef.paa", "_arm_spaag.paa", "_artillery.paa", "_rotarywing.paa", "_helo_attack.paa", "_helo_cargo.paa", "_fixedwing.paa", "_hq.paa", "_logistics.paa", "_mg.paa", "_mg_m.paa", "_mg_h.paa", "_mortar.paa", "_motor.paa", "_para.paa", "_para_mech.paa", "_recon.paa", "_recon_mech.paa", "_recon_mech_wheeled.paa", "_recon_motor.paa", "_engineer.paa", "_service.paa", "_sf.paa", "_signal.paa", "_spaag.paa", "_transport.paa", "_uav.paa", ".paa"];
    private _colours = ["yellow", "blue", "green", "red", "orange", "gray", "purple"];
    private _sizeMod = ["x\tmf\addons\orbat\textures\empty.paa", "x\tmf\addons\orbat\textures\modif_o.paa","x\tmf\addons\orbat\textures\modif_dot.paa","x\tmf\addons\orbat\textures\modif_2dot.paa","x\tmf\addons\orbat\textures\modif_3dot.paa", "x\tmf\addons\orbat\textures\modif_company.paa"];

    private _icon = _toolBoxIcon select (lbCurSel _ctrlIconToolbox);
    private _path = "";

    if (_icon != "") then {
        _path = "x\tmf\addons\orbat\textures\" + (_colours select  (lbcursel _ctrlColourToolBox)) + _icon;
    };

    private _idx = (lbCurSel _ctrlSize);
    private _mod = "";
    if (_idx > 0) then {
        _mod = _sizeMod select _idx;
    };

    private _value = OrbatTree_Data select (_ctrlTree tvValue (tvCurSel _ctrlTree));
    if (OrbatEditMode == 0) then { // Add Entry.

        private _data = [[call fn_findNextFreeId, (ctrlText _ctrlNameEdit), _path, _mod, (ctrlText _ctrlFullNameEdit), 0],[]];
        //append to children
        (OrbatSettingsCurrentEntity select 1) pushBack _data;
    } else { // Edit Entry
        if (_value isEqualType 0) then {
            private _data = (OrbatSettingsCurrentEntity select 0);
            _data set [1, (ctrlText _ctrlNameEdit)]; //
            _data set [2, _path];
            _data set [3, _mod];
            _data set [4, (ctrlText _ctrlFullNameEdit)];
            // _data set [5, -1]; Do not edit the order thing.
        };
        if (_value isEqualType grpNull) then {
            private _groupMarkerArray = [_path, (ctrlText _ctrlNameEdit), _mod, uiNameSpace getVariable ["GroupMarker_numID",0]];
            _value set3DENAttribute ["TMF_groupMarker",str _groupMarkerArray];
        };
    };
    OrbatSettingsCurrentEntity = nil;
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MAIN_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);
    ["refreshTree"] call OrbatSettings_script;
};
