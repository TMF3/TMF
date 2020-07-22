
TRACE_1("UnitMarker onLoad",_params);
private _ctrlGroup = _params select 0;
UnitMarker_ctrlGroup = _ctrlGroup;

private _entity = (get3DENSelected "object") select 0;

_ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {UnitMarker_ctrlGroup = _this select 0;};}];
_ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {UnitMarker_ctrlGroup = nil;};}];

private _unitMarkerArray = (_entity get3DENAttribute "TMF_SpecialistMarker") # 0;
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
        private _colours = ["yellow", "blue", "green", "red", "orange", "gray", "purple"];


        _ctrlColourToolBox lbsetcursel (_colours find _colour);
        _ctrlIconToolbox lbsetcursel (_toolBoxIcon find _parts);
    };
    _ctrlNameEdit ctrlSetText _mName;
} else {
    _ctrlNameEdit ctrlSetText "";
};
