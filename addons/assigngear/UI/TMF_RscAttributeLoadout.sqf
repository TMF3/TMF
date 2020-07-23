#include "\x\tmf\addons\assigngear\script_component.hpp"
#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\A3\ui_f\hpp\defineCommonGrids.inc"

params ["_mode","_params","_unit"];
TRACE_3("RscAttributeLoadout",_mode,_params,_unit);
_params params ["_display"];
private _loadoutCombo = _display displayCtrl IDC_RSCATTRIBUTELOADOUT_COMBO;

switch _mode do {
	case "onLoad": {
        {
            {
                TRACE_1("Adding loadout",_x);
                private _lbAdd = _loadoutCombo lbAdd getText (_x >> "displayName");
                _loadoutCombo lbSetData [_lbAdd, configName _x];
                private _dlcLogo = if (configsourcemod _x != '') then {
                    (modParams [configSourceMod _x,['logo']]) param [0];
                };
                if (!isNil "_dlcLogo" && {_dlcLogo != ''}) then {
                    _loadoutCombo lbSetPictureRight [_lbAdd,_dlcLogo];
                };
            } forEach ("true" configClasses _x);
        } forEach [configFile >> "CfgLoadouts", missionConfigFile >> "CfgLoadouts"];

        lbsort _loadoutCombo;
        _loadoutCombo lbSetCurSel 0;
    };
    case "onUnload": {};
    case "confirmed": {
        _unit setVariable ["Loadout",_loadoutCombo lbData lbCurSel _loadoutCombo];
        _unit setVariable ["updated",true];
    };
};
