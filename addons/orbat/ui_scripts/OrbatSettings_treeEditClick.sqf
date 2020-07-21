
TRACE_1("OrbatSettings treeEditClick",_params);
with uiNamespace do {

    private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
    if ( count (tvCurSel _ctrlTree) == 0 ) exitWith {};

    private _treeSel = tvCurSel _ctrlTree;
    private _value = OrbatTree_Data select (_ctrlTree tvValue _treeSel);

    private _ctrlIconToolbox = OrbatSettings_ctrlGroup controlsGroupCtrl 111;
    private _ctrlColourToolBox = OrbatSettings_ctrlGroup controlsGroupCtrl 113;
    private _ctrlNameEdit = OrbatSettings_ctrlGroup controlsGroupCtrl 115;
    private _ctrlFullNameEdit = OrbatSettings_ctrlGroup controlsGroupCtrl 123;
    private _ctrlSize = OrbatSettings_ctrlGroup controlsGroupCtrl 117;
    _ctrlNameEdit ctrlSetText "";
    _ctrlColourToolBox lbsetcursel 0;
    _ctrlIconToolbox lbsetcursel 0;
    _ctrlSize lbsetcursel 0;

    //TODO : edit Object/specialist marker
    if (_value isEqualType objNull) exitWith {};
    OrbatEditMode = 1; // 1 for edit

    OrbatSettingsCurrentEntity = [];
    if (_value isEqualType 0) then {
        //find  our side/facion entry.
        private _idx = -1;
        {
            if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
        } forEach OrbatSettings_Array;
        private _entry = (OrbatSettings_Array select _idx) select 1;


        fn_editSearchHelper = {
            params["_entry", "_value"];
            _entry params ["_data","_children"];
            if ((_data select 0) == _value) exitWith {
                OrbatSettingsCurrentEntity = _entry;
                true
            };
            {
                if ([_x, _value] call fn_editSearchHelper) exitWith {};
            } forEach _children;
            false
        };
        [_entry, _value] call fn_editSearchHelper;
        //};
    };

    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MAIN_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (EDIT_IDCS);
    {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);

    //Find element in the tree
    if (_value isEqualType grpNull) then {
        GroupMarker_numID = 0;
        private _groupMarkerArray = (_value get3DENAttribute "TMF_groupMarker") select 0;
        if (_groupMarkerArray isEqualType "") then {
            _groupMarkerArray = call compile _groupMarkerArray;
        };
        //Hide the full name editor.
        {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach [122,123];

        if (count _groupMarkerArray > 0) then {
            _groupMarkerArray params ["_icon", "_mName", "_size", "_numId"];
            GroupMarker_numID = _numId;
            if (_icon != "") then {
                private _parts = _icon splitString '\';
                private _lastPart = _parts select (count _parts -1);
                private _parts = _lastPart splitString '_';
                private _colour = _parts select 0;

                _parts deleteAt 0;
                _parts = "_" + (_parts joinString '_');

                private _toolBoxIcon = ["", "_inf.paa", "_inf_airmobile.paa", "_inf_mech.paa", "_inf_mech_wheeled.paa", "_inf_motor.paa", "_inf_para.paa", "_amphi.paa", "_amphi_mech_inf.paa", "_airdef.paa", "_airdef_not_a_nipple.paa", "_antitank.paa", "_antitank_rocket.paa", "_armor.paa", "_armor_wheeled.paa", "_arm_airdef.paa", "_arm_spaag.paa", "_artillery.paa", "_rotarywing.paa", "_helo_attack.paa", "_helo_cargo.paa", "_fixedwing.paa", "_hq.paa", "_logistics.paa", "_mg.paa", "_mg_m.paa", "_mg_h.paa", "_mortar.paa", "_motor.paa", "_para.paa", "_para_mech.paa", "_recon.paa", "_recon_mech.paa", "_recon_mech_wheeled.paa", "_recon_motor.paa", "_engineer.paa", "_service.paa", "_sf.paa", "_signal.paa", "_spaag.paa", "_transport.paa", "_uav.paa", ".paa"];
                private _colours = ["yellow", "blue", "green", "red", "orange", "gray", "purple"];

                _ctrlColourToolBox lbsetcursel (_colours find _colour);
                _ctrlIconToolbox lbsetcursel (_toolBoxIcon find _parts);
            };
            if (_size != "") then {
                private _sizeMod = ["x\tmf\addons\orbat\textures\empty.paa", "x\tmf\addons\orbat\textures\modif_o.paa","x\tmf\addons\orbat\textures\modif_dot.paa","x\tmf\addons\orbat\textures\modif_2dot.paa","x\tmf\addons\orbat\textures\modif_3dot.paa", "x\tmf\addons\orbat\textures\modif_company.paa"];
                _ctrlSize lbsetcursel (_sizeMod find _size);
            };
            _ctrlFullNameEdit ctrlSetText _fName;
            _ctrlNameEdit ctrlSetText _mName;
        } else {
            _ctrlNameEdit ctrlSetText (GroupID _entity);
            _ctrlFullNameEdit ctrlSetText "";
        };
    };

    if (count OrbatSettingsCurrentEntity > 0) then {
        OrbatSettingsCurrentEntity params ["_data"];
        _data params ["","_mName","_icon","_size", ["_fName",""]];
        if (_icon != "") then {
            private _parts = _icon splitString '\';
            private _lastPart = _parts select (count _parts -1);
            private _parts = _lastPart splitString '_';
            private _colour = _parts select 0;

            _parts deleteAt 0;
            _parts = "_" + (_parts joinString '_');

            private _toolBoxIcon = ["", "_inf.paa", "_inf_airmobile.paa", "_inf_mech.paa", "_inf_mech_wheeled.paa", "_inf_motor.paa", "_inf_para.paa", "_amphi.paa", "_amphi_mech_inf.paa", "_airdef.paa", "_airdef_not_a_nipple.paa", "_antitank.paa", "_antitank_rocket.paa", "_armor.paa", "_armor_wheeled.paa", "_arm_airdef.paa", "_arm_spaag.paa", "_artillery.paa", "_rotarywing.paa", "_helo_attack.paa", "_helo_cargo.paa", "_fixedwing.paa", "_hq.paa", "_logistics.paa", "_mg.paa", "_mg_m.paa", "_mg_h.paa", "_mortar.paa", "_motor.paa", "_para.paa", "_para_mech.paa", "_recon.paa", "_recon_mech.paa", "_recon_mech_wheeled.paa", "_recon_motor.paa", "_engineer.paa", "_service.paa", "_sf.paa", "_signal.paa", "_spaag.paa", "_transport.paa", "_uav.paa", ".paa"];
            private _colours = ["yellow", "blue", "green", "red", "orange", "gray", "purple"];

            _ctrlColourToolBox lbsetcursel (_colours find _colour);
            _ctrlIconToolbox lbsetcursel (_toolBoxIcon find _parts);
        };
        if (_size != "") then {
            private _sizeMod = ["x\tmf\addons\orbat\textures\empty.paa", "x\tmf\addons\orbat\textures\modif_o.paa","x\tmf\addons\orbat\textures\modif_dot.paa","x\tmf\addons\orbat\textures\modif_2dot.paa","x\tmf\addons\orbat\textures\modif_3dot.paa", "x\tmf\addons\orbat\textures\modif_company.paa"];
            _ctrlSize lbsetcursel (_sizeMod find _size);
        };
        _ctrlNameEdit ctrlSetText _mName;
        _ctrlFullNameEdit ctrlSetText _fName;
    };

};
