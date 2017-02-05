params ["_mode",["_params",[]]];

// with uiNameSpace do { RadioChannels_script = compile preprocessFileLineNumbers "RadioChannels.sqf"; };  with uiNameSpace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };  with uiNameSpace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; }; with uiNameSpace do { ORBATSettings_script = compile preprocessFileLineNumbers "OrbatSettings.sqf"; }; with uiNameSpace do { GroupMarker_script = compile preprocessFileLineNumbers "GroupMarker.sqf"; };

//with uiNameSpace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };  with uiNameSpace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; };
// with uiNameSpace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; }; with uiNameSpace do { ORBATSettings_script = compile preprocessFileLineNumbers "OrbatSettings.sqf"; };

switch _mode do {
    case "onLoad": {
        private _ctrlGroup = _params select 0;
        UnitMarker_ctrlGroup = _ctrlGroup;
    
        private _entity = (get3DENSelected "object") select 0;
        
        _ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {UnitMarker_ctrlGroup = _this select 0;};}];
        _ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {UnitMarker_ctrlGroup = nil;};}];
        
        private _unitMarkerArray = (_entity get3DENAttribute "TMF_SpecialistMarker") select 0;
        if (_unitMarkerArray isEqualType "") then {
            _unitMarkerArray = call compile _unitMarkerArray;
        };
        

        private _ctrlIconToolbox = _ctrlGroup controlsGroupCtrl 100;
        private _ctrlColourToolBox = _ctrlGroup controlsGroupCtrl 101;
        private _ctrlNameEdit = _ctrlGroup controlsGroupCtrl 102;
        
        if (count _unitMarkerArray > 0) then {
            _unitMarkerArray params ["_icon","_mName"];
            if (_icon != "") then {
                private _parts = _icon splitString '\';
                private _lastPart = _parts select (count _parts -1);
                private _parts = _lastPart splitString '_';
                private _colour = _parts select 0;
                
                _parts deleteAt 0;
                _parts = "_" + (_parts joinString '_');
                
                private _toolBoxIcon = ["","_cross.paa","_chevrons.paa","_sl_flag.paa","_sl_flag_s"];
                private _colours = ["yellow", "blue", "green", "red", "orange"];
                
                
                _ctrlColourToolBox lbsetcursel (_colours find _colour);
                _ctrlIconToolbox lbsetcursel (_toolBoxIcon find _parts);
            };
            _ctrlNameEdit ctrlSetText _mName;
        } else {
            _ctrlNameEdit ctrlSetText "";
        };
    };

    case "attributeLoad": {
    };
    case "attributeSave": {
        private _ctrlGroup = uiNameSpace getVariable "UnitMarker_ctrlGroup";
        private _ctrlIconToolbox = _ctrlGroup controlsGroupCtrl 100;
        private _ctrlColourToolBox = _ctrlGroup controlsGroupCtrl 101;
        private _ctrlNameEdit = _ctrlGroup controlsGroupCtrl 102;

        private _toolBoxIcon = ["","_cross.paa","_chevrons.paa","_sl_flag.paa","_sl_flag_s"];
        private _colours = ["yellow", "blue", "green", "red", "orange"];

        private _icon = _toolBoxIcon select (lbcursel _ctrlIconToolbox);
        private _path = "";
        
        if (_icon != "") then {
            _path = "x\tmf\addons\orbat\textures\" + (_colours select (lbcursel _ctrlColourToolBox)) + _icon;
        };
                
        private _entity = (get3DENSelected "object") select 0;
        private _unitMarkerArray = [_path, (ctrlText _ctrlNameEdit)];
        
        _entity set3DENAttribute ["TMF_SpecialistMarker",str _unitMarkerArray];
                
        str _unitMarkerArray;
    };    
};