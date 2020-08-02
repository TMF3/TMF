private _ctrlGroup = uiNameSpace getVariable "UnitMarker_ctrlGroup";
private _ctrlIconToolbox = _ctrlGroup controlsGroupCtrl 100;
private _ctrlColourToolBox = _ctrlGroup controlsGroupCtrl 101;
private _ctrlNameEdit = _ctrlGroup controlsGroupCtrl 102;

private _toolBoxIcon = ["","_cross.paa","_chevrons.paa","_sl_flag.paa","_sl_flag_s"];
private _colours = ["yellow", "blue", "green", "red", "orange", "gray", "purple"];

private _icon = _toolBoxIcon select (lbcursel _ctrlIconToolbox);
private _path = "";

if (_icon != "") then {
    _path = "x\tmf\addons\orbat\textures\" + (_colours select (lbcursel _ctrlColourToolBox)) + _icon;
};

private _entity = (get3DENSelected "object") # 0;
private _unitMarkerArray = [_path, (ctrlText _ctrlNameEdit)];

_entity set3DENAttribute ["TMF_SpecialistMarker",str _unitMarkerArray];
TRACE_2("UnitMarker attrSave",_params,_unitMarkerArray);

str _unitMarkerArray;
