
#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

params["","_type"];
//28 = enter key
if (_type == 28) then {
    if (GVAR(respawnMousePos) isEqualTo -1) then {
        hint "No position selected for respawn. Click on a position then hit enter.";

    } else {
        private _position = [0,0,0];
        private _halo = false;
        if (GVAR(respawnMousePos) isEqualType []) then {
            _position = GVAR(respawnMousePos);
            _halo = GVAR(respawnHalo);
        } else {
            private _var = missionNamespace getVariable[format["tmf_respawnPoint%1",GVAR(respawnMousePos)],objNull];
            if (!isNull _var) then {
                _position = position _var;
            };
        };
        if (_halo) then {
            hint "Group created as HALO group.";
        } else {
            hint "Group created on ground.";
        };

        GVAR(respawnGuiParameters) params ["_faction", "_groupName", "_markerType", "_markerColor", "_markerName"];

        {
            _x params ["_rankIdx","_obj", "_roleIdx"];
            _x set [2,(respawnMenuRoles select _roleIdx) select 0];
        } forEach GVAR(selectedRespawnGroup);

        TRACE_9("Triggered respawn wave",_groupName,_position, _faction, GVAR(selectedRespawnGroup), _markerType, _markerColor, _markerName,_halo,GVAR(selectedSide));
        [[_groupName,_position, _faction, GVAR(selectedRespawnGroup), _markerType, _markerColor, _markerName,_halo,GVAR(selectedSide)], QEFUNC(respawn,respawnWaveServer), false] call BIS_fnc_MP;

        // Print to log
        private _argsStr = [
            format ["Side: %1,",[east,west,resistance,civilian] # GVAR(selectedSide)],
            format ["Position: %1,", _position],
            format ["Group array: %1,",GVAR(selectedRespawnGroup) apply {[name (_x # 1),_x # 2]}]
        ];
        [format ["%1 Triggered a respawn wave: %2",profileName,_argsStr joinString " "], false, "Admin Menu"] call FUNC(log);

        GVAR(selectedRespawnGroup) = [];

        // Close the Map
        ((findDisplay IDC_TMF_ADMINMENU_RESP_MAP_DISPLAY) displayCtrl IDC_TMF_ADMINMENU_RESP_MAP_CONTROL) ctrlShow false;
        ((findDisplay IDC_TMF_ADMINMENU_RESP_MAP_DISPLAY) displayCtrl IDC_TMF_ADMINMENU_RESP_MAP_CONTROL) mapCenterOnCamera false;
        closeDialog IDC_TMF_ADMINMENU_RESP_MAP_DISPLAY;
    };
};
//SPACEBAR (HALO TOGGLE)
if (_type == 57) then {
    GVAR(respawnHalo) = !GVAR(respawnHalo);
};
