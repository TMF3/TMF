
private _ctrlGroup = uiNameSpace getVariable "GroupMarker_ctrlGroup";
private _ctrlIconToolbox = _ctrlGroup controlsGroupCtrl 100;
private _ctrlColourToolBox = _ctrlGroup controlsGroupCtrl 101;
private _ctrlNameEdit = _ctrlGroup controlsGroupCtrl 102;
private _ctrlSize = _ctrlGroup controlsGroupCtrl 103;

private _toolBoxIcon = ["", "_inf.paa", "_inf_airmobile.paa", "_inf_mech.paa", "_inf_mech_wheeled.paa", "_inf_motor.paa", "_inf_para.paa", "_amphi.paa", "_amphi_mech_inf.paa", "_airdef.paa", "_airdef_not_a_nipple.paa", "_antitank.paa", "_antitank_rocket.paa", "_armor.paa", "_armor_wheeled.paa", "_arm_airdef.paa", "_arm_spaag.paa", "_artillery.paa", "_rotarywing.paa", "_helo_attack.paa", "_helo_cargo.paa", "_fixedwing.paa", "_hq.paa", "_logistics.paa", "_mg.paa", "_mg_m.paa", "_mg_h.paa", "_mortar.paa", "_motor.paa", "_para.paa", "_para_mech.paa", "_recon.paa", "_recon_mech.paa", "_recon_mech_wheeled.paa", "_recon_motor.paa", "_engineer.paa", "_service.paa", "_sf.paa", "_signal.paa", "_spaag.paa", "_transport.paa", "_uav.paa", ".paa"];
private _colours = ["yellow", "blue", "green", "red", "orange", "gray", "purple"];
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

TRACE_3("Group Marker attrSave",_entity,_groupMarkerArray);

str _groupMarkerArray;
