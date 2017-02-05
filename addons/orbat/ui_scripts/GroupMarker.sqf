params ["_mode",["_params",[]]];

// with uiNameSpace do { RadioChannels_script = compile preprocessFileLineNumbers "RadioChannels.sqf"; };  with uiNameSpace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };  with uiNameSpace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; }; with uiNameSpace do { ORBATSettings_script = compile preprocessFileLineNumbers "OrbatSettings.sqf"; }; with uiNameSpace do { GroupMarker_script = compile preprocessFileLineNumbers "GroupMarker.sqf"; };

//with uiNameSpace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };  with uiNameSpace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; };
// with uiNameSpace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; }; with uiNameSpace do { ORBATSettings_script = compile preprocessFileLineNumbers "OrbatSettings.sqf"; };

switch _mode do {
    case "onLoad": {
        private _ctrlGroup = _params select 0;
        GroupMarker_ctrlGroup = _ctrlGroup;
    
        private _entity = (get3DENSelected "group") select 0;
        
        _ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {GroupMarker_ctrlGroup = _this select 0;};}];
        _ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {GroupMarker_ctrlGroup = nil;};}];
        
        private _groupMarkerArray = (_entity get3DENAttribute "TMF_groupMarker") select 0;
        if (_groupMarkerArray isEqualType "") then {
            _groupMarkerArray = call compile _groupMarkerArray;
        };
        

        private _ctrlIconToolbox = _ctrlGroup controlsGroupCtrl 100;
        private _ctrlColourToolBox = _ctrlGroup controlsGroupCtrl 101;
        private _ctrlNameEdit = _ctrlGroup controlsGroupCtrl 102;
        private _ctrlSize = _ctrlGroup controlsGroupCtrl 103;
        GroupMarker_numID = 0;
        
        if (count _groupMarkerArray > 0) then {
            _groupMarkerArray params ["_icon","_mName","_size", "_numId"];
            GroupMarker_numID = _numId;
            if (_icon != "") then {
                private _parts = _icon splitString '\';
                private _lastPart = _parts select (count _parts -1);
                private _parts = _lastPart splitString '_';
                private _colour = _parts select 0;
                
                _parts deleteAt 0;
                _parts = "_" + (_parts joinString '_');
                
                private _toolBoxIcon = ["", "_inf.paa", "_inf_airmobile.paa", "_inf_mech.paa", "_inf_mech_wheeled.paa", "_inf_motor.paa", "_inf_para.paa", "_amphi.paa", "_amphi_mech_inf.paa", "_airdef.paa", "_airdef_not_a_nipple.paa", "_antitank.paa", "_antitank_rocket.paa", "_armor.paa", "_armor_wheeled.paa", "_arm_airdef.paa", "_arm_spaag.paa", "_artillery.paa", "_rotarywing.paa", "_helo_attack.paa", "_helo_cargo.paa", "_fixedwing.paa", "_hq.paa", "_logistics.paa", "_mg.paa", "_mg_m.paa", "_mg_h.paa", "_mortar.paa", "_motor.paa", "_para.paa", "_para_mech.paa", "_recon.paa", "_recon_mech.paa", "_recon_mech_wheeled.paa", "_recon_motor.paa", "_engineer.paa", "_service.paa", "_sf.paa", "_signal.paa", "_spaag.paa", "_transport.paa", "_uav.paa", ".paa"];
                private _colours = ["yellow", "blue", "green", "red", "orange", "gray"];
                
                
                _ctrlColourToolBox lbsetcursel (_colours find _colour);
                _ctrlIconToolbox lbsetcursel (_toolBoxIcon find _parts);
            };
            if (_size != "") then {
                private _sizeMod = ["x\tmf\addons\orbat\textures\empty.paa", "x\tmf\addons\orbat\textures\modif_o.paa","x\tmf\addons\orbat\textures\modif_dot.paa","x\tmf\addons\orbat\textures\modif_2dot.paa","x\tmf\addons\orbat\textures\modif_3dot.paa", "x\tmf\addons\orbat\textures\modif_company.paa"];
                _ctrlSize lbsetcursel (_sizeMod find _size);
            };
            _ctrlNameEdit ctrlSetText _mName;
        } else {
            _ctrlNameEdit ctrlSetText (GroupID _entity);
        };
    };

    case "attributeLoad": {
    };
    case "attributeSave": {
        private _ctrlGroup = uiNameSpace getVariable "GroupMarker_ctrlGroup";
        private _ctrlIconToolbox = _ctrlGroup controlsGroupCtrl 100;
        private _ctrlColourToolBox = _ctrlGroup controlsGroupCtrl 101;
        private _ctrlNameEdit = _ctrlGroup controlsGroupCtrl 102;
        private _ctrlSize = _ctrlGroup controlsGroupCtrl 103;

        private _toolBoxIcon = ["", "_inf.paa", "_inf_airmobile.paa", "_inf_mech.paa", "_inf_mech_wheeled.paa", "_inf_motor.paa", "_inf_para.paa", "_amphi.paa", "_amphi_mech_inf.paa", "_airdef.paa", "_airdef_not_a_nipple.paa", "_antitank.paa", "_antitank_rocket.paa", "_armor.paa", "_armor_wheeled.paa", "_arm_airdef.paa", "_arm_spaag.paa", "_artillery.paa", "_rotarywing.paa", "_helo_attack.paa", "_helo_cargo.paa", "_fixedwing.paa", "_hq.paa", "_logistics.paa", "_mg.paa", "_mg_m.paa", "_mg_h.paa", "_mortar.paa", "_motor.paa", "_para.paa", "_para_mech.paa", "_recon.paa", "_recon_mech.paa", "_recon_mech_wheeled.paa", "_recon_motor.paa", "_engineer.paa", "_service.paa", "_sf.paa", "_signal.paa", "_spaag.paa", "_transport.paa", "_uav.paa", ".paa"];
        private _colours = ["yellow", "blue", "green", "red", "orange", "gray"];
        private _sizeMod = ["x\tmf\addons\orbat\textures\empty.paa", "x\tmf\addons\orbat\textures\modif_o.paa","x\tmf\addons\orbat\textures\modif_dot.paa","x\tmf\addons\orbat\textures\modif_2dot.paa","x\tmf\addons\orbat\textures\modif_3dot.paa", "x\tmf\addons\orbat\textures\modif_company.paa"];
        
        private _icon = _toolBoxIcon select (lbcursel _ctrlIconToolbox);
        private _path = "";
        
        if (_icon != "") then {
            _path = "x\tmf\addons\orbat\textures\" + (_colours select  (lbcursel _ctrlColourToolBox)) + _icon;
        };
        
        private _idx = (lbcursel _ctrlSize);
        private _mod = "";
        if (_idx > 0) then {
            _mod = _sizeMod select _idx;
        };
        
        private _entity = (get3DENSelected "group") select 0;
        private _groupMarkerArray = [_path, (ctrlText _ctrlNameEdit), _mod, uiNameSpace getVariable ["GroupMarker_numID",0]];
        
        _entity set3DENAttribute ["TMF_groupMarker",str _groupMarkerArray];
                
        str _groupMarkerArray;
    };    
};