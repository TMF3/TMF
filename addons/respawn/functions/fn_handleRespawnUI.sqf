#include "\x\tmf\addons\respawn\script_component.hpp"

disableSerialization;
params["_input",["_params",[]]];

#define RESPAWN_DISPLAY (findDisplay 26893)

private _ctrlDeadListBox = (RESPAWN_DISPLAY displayCtrl 26891);
private _ctrlGroupListBox = (RESPAWN_DISPLAY displayCtrl 26892);

switch _input do {
    case "onLoad": {
        
        GVAR(deadPlayerList) = [];
        GVAR(selectedRespawnGroup) = [];
        if (isNil QGVAR(lastFactionSelection)) then {GVAR(lastFactionSelection) = [0,0];};
        // GVAR(selectedRespawnGroup) format 
        // Rank: Int (0-6), Object: Player, Role: Int (0 -> count respawnMenuRoles)
        
        // Propogate the list of dead players.
        if (!isMultiplayer) then {
            {
                GVAR(deadPlayerList) pushBack _x;  
            } forEach allUnits;
        } else {
            {
                if (isPlayer _x) then { //not all of them will be players.
                    GVAR(deadPlayerList) pushBack _x;  
                };
            } forEach ([0,0,0] nearEntities ["tmf_spectator_unit",500]);
            {
                if (!alive _x) then { //not all of them will be players.
                    GVAR(deadPlayerList) pushBackUnique _x;  
                };
            } forEach allPlayers;
        };


        private _control = (RESPAWN_DISPLAY displayCtrl 26894); /* respawnMenuFactionCategoryCombo */
        private _missionConfig = (configProperties [missionConfigFile >> "CfgLoadouts","isClass _x"]);
        private _index = -1;

        // Handle all the factions

        // Build up a pool of who is using what faction from assign gear.
        private _playerFactions = [] call CBA_fnc_hashCreate;
        {
            private _faction = _x getVariable ["tmf_assignGear_faction",""];
            if (_faction != "") then {
                if ([_playerFactions,_faction] call CBA_fnc_hashHasKey) then {
                    private _value = [_playerFactions,_faction] call CBA_fnc_hashGet;
                    [_playerFactions,_faction,_value + 1] call CBA_fnc_hashSet;
                } else {
                    [_playerFactions,_faction,1] call CBA_fnc_hashSet;
                };
            };
        } forEach (allPlayers);

        if (count _missionConfig > 0) then {
            private _players = 0;
            {
                private _factionName = (toLower(configName _x));
                 if ([_playerFactions,_factionName] call CBA_fnc_hashHasKey) then {
                    _players = _players + ([_playerFactions,_factionName] call CBA_fnc_hashGet);
                };
            } forEach _missionConfig;

            private _text = "From Mission File";
            if (_players > 0) then {
                _text = format ["From Mission File (%1p)",_players];
            };
            private _index = _control lbAdd _text;
            _control lbSetData [_index, "mission"];
        };

        private _factionCategories = [];
        private _factionCategoryPlayerCounts = [];
        {
            private _category = getText (_x >> "category");
            if (_category isEqualTo "") then {_category = "Other";};
            private _configName = toLower (configName _x);
            private _players = 0;
            // Mission faction class overrides so show 0 if configFile class is of same name.
            if (!isClass (missionConfigFile >> "CfgLoadouts" >> _configName)) then {
                if ([_playerFactions,_configName] call CBA_fnc_hashHasKey) then {
                    _players = [_playerFactions,_configName] call CBA_fnc_hashGet;
                };
            };

            private _idx = _factionCategories find _category;
            if (_idx == -1) then {
                _idx = _factionCategories pushBack _category;
                _factionCategoryPlayerCounts set [_idx,_players];
            } else {
                 _factionCategoryPlayerCounts set [_idx,(_factionCategoryPlayerCounts select _idx) + _players];
            };
        } forEach (configProperties [configFile >> "CfgLoadouts", "isClass _x"]);

        // Sort Alphabetically.
        _factionCategories sort true;

        {
            private _text = _x;
            private _players = _factionCategoryPlayerCounts select _forEachIndex;
            if (_players > 0) then {
                _text = format ["%1 (%2p)",_x,_players];
            };
            private _index = _control lbAdd _text;
            _control lbSetData [_index,_x];
        } forEach (_factionCategories);

        GVAR(currentFactionCategory) = "";
        if (lbSize _control > 0) then {
            private _lastIndex = GVAR(lastFactionSelection) select 0;
            if (lbSize _control <= _lastIndex) then {
                _lastIndex = 0;
            };
            _control lbSetCurSel _lastIndex; // set to previously used element.
            GVAR(currentFactionCategory) = _control lbData _lastIndex;
            GVAR(lastFactionSelection) set [0,_lastIndex];
        };
        _control ctrlAddEventHandler ["LBSelChanged",{["factionCategoryChanged"] call FUNC(handleRespawnUI);}];
        

        private _lastIndex = GVAR(lastFactionSelection) select 1; // Store this before executing below code, otherwise it will override.
        
         /* Fill Faction files respawnMenuFactionCombo */
        _control = (RESPAWN_DISPLAY displayCtrl 26928); /* respawnMenuFactionCombo */
        _control ctrlAddEventHandler ["LBSelChanged",{["factionChanged"] call FUNC(handleRespawnUI);}];
        ["refreshFactionCategoryChanged"] call FUNC(handleRespawnUI);

        if (lbSize _control > 0) then {
            private _newIdx = lbCurSel _control;
            if (lbSize _control > _lastIndex) then {
                _control lbSetCurSel _lastIndex; // set to previously used element.
                _newIdx = _lastIndex;
            };
            GVAR(lastFactionSelection) set [1,_newIdx];
        };
        /* Fill Roles */
        
        //_control = (RESPAWN_DISPLAY displayCtrl 26896); /* Role control */
        
        ["factionChanged"] call FUNC(handleRespawnUI);
        
        /* Fill Side selection */
        
        private _west = 0; private _east = 0; private _resistance = 0; private _civilian = 0;
        {
            switch (side _x) do {
                case blufor: {_west = _west + 1;};
                case opfor: {_east = _east + 1;};
                case independent: {_resistance = _resistance + 1;};
                case civilian: {_civilian = _civilian + 1;};
            };
        } forEach (allPlayers select {alive _x});


        _control = (RESPAWN_DISPLAY displayCtrl 26929); /* Side control */
        private _idx = _control lbAdd format["BLUFOR (%1p)",_west];
        _control lbSetValue [_idx,1];
        _control lbSetColor [_idx,(west) call EFUNC(common,sideToColor)];
        private _idx = _control lbAdd format["OPFOR (%1p)",_east];
        _control lbSetValue [_idx,0];
        _control lbSetColor [_idx,(east) call EFUNC(common,sideToColor)];
        private _idx = _control lbAdd format["GREENFOR (%1p)",_resistance];
        _control lbSetValue [_idx,2];
        _control lbSetColor [_idx,(independent) call EFUNC(common,sideToColor)];
        private _idx = _control lbAdd format["Civilian (%1p)",_civilian];
        _control lbSetValue [_idx,3];
        if (!isNil QGVAR(selectedSide)) then {
            _control lbSetCurSel ([1,0,2,3] find GVAR(selectedSide));
        } else {
            _control lbSetCurSel 0;
            GVAR(selectedSide) = 1;
        };
        _control ctrlAddEventHandler ["LBSelChanged",{GVAR(selectedSide) = (_this select 0) lbValue (_this select 1);}];
        
        //Default Rank listbox
        _control = (RESPAWN_DISPLAY displayCtrl 26897);
        
        {
            _control lbAdd _x;
        } forEach ["Pvt.", "Cpl.", "Sgt.", "Lt.", "Cpt.", "Mjr.", "Col."];

        {
            _control lbSetPicture [_forEachIndex, "\A3\Ui_f\data\GUI\Cfg\Ranks\" + _x];
        } forEach ["private_gs.paa", "corporal_gs.paa", "sergeant_gs.paa", "lieutenant_gs.paa", "captain_gs.paa", "major_gs.paa", "colonel_gs.paa"];
        
        _control lbSetCurSel 0;
        
        (RESPAWN_DISPLAY displayCtrl 26895) ctrlSetText format["Players in Spectator: %1",count GVAR(deadPlayerList)];
        
        // Marker Type
        _control = (RESPAWN_DISPLAY displayCtrl 26900);
        {
            private _idx = _control lbAdd (_x select 1);
            _markerImg = (_x select 0);
            if (_markerImg != "") then {
                _control lbSetPicture[_idx,_markerImg]; 
                _control lbSetColor[_idx,[1,1,1,1]];
            };
        } forEach GVAR(respawnMenuMarkers);
        _control ctrlAddEventHandler ["LBSelChanged",{GVAR(MarkerIdx) = (_this select 1);}];
        if (!isNil QGVAR(MarkerIdx)) then {
            _control lbSetCurSel GVAR(MarkerIdx);
        } else {
            _control lbSetCurSel 0;
        };
        
        // Marker Colours
        _control = (RESPAWN_DISPLAY displayCtrl 26901);
        {
            private _idx = _control lbAdd (_x select 1);
            _control lbSetColor [_idx,(_x select 0)];
        } forEach GVAR(respawnMenuMarkerColours);

        _control ctrlAddEventHandler ["LBSelChanged",{GVAR(MarkerColour) = (_this select 1);}];
        if (!isNil QGVAR(MarkerColour)) then {
            _control lbSetCurSel GVAR(MarkerColour);
        } else {
            _control lbSetCurSel 0;
        };

        // Group ID
        _control = (RESPAWN_DISPLAY displayCtrl 26898);
        if (isNil QGVAR(groupName)) then {
            GVAR(groupName) = "INSERT_GROUP_NAME";
        } else {
            _control ctrlSetText GVAR(groupName);
        };
        _control ctrlAddEventHandler ["KeyUp",{GVAR(groupName) = ctrlText (_this select 0);}];

        // Marker Name
        _control = (RESPAWN_DISPLAY displayCtrl 26899);
        if (isNil QGVAR(markerName)) then {
            GVAR(markerName) = "INSERT_MARKER_NAME";
        } else {
            _control ctrlSetText GVAR(markerName);
        };
        _control ctrlAddEventHandler ["KeyUp",{GVAR(markerName) = ctrlText (_this select 0);}];
        
        if (!isNil QGVAR(respawnGroupMarkerCheckBoxVal)) then {
            (RESPAWN_DISPLAY displayCtrl 26903) cbSetChecked GVAR(respawnGroupMarkerCheckBoxVal);
        } else {
            GVAR(respawnGroupMarkerCheckBoxVal) = false;
        };
        
       ["refreshDeadListBox"] call FUNC(handleRespawnUI);
       
       //Use PFH to keep the lists updated ;0
       [{
            params["_input", "_pfhID"];
            _input params ["_oldSpectList"];
            _display = findDisplay 26893;
            if (isNull (findDisplay 26893)) exitWith { [_pfhID] call CBA_fnc_removePerFrameHandler;} ;

            //Recompute who is alive and Dead.
            
            private _deadList = [];
            if ((!isMultiplayer) or (isMultiplayer and isServer)) then {
                {
                    _deadList pushBack _x;  
                } forEach allUnits;
            } else {
                {
                    if (isPlayer _x) then { //not all of them will be players.
                        _deadList pushBack _x;  
                    };
                } forEach ([0,0,0] nearEntities ["tmf_spectator_unit",500]);
                {
                    if (!alive _x) then { //not all of them will be players.
                        _deadList pushBackUnique _x;
                    };
                } forEach allPlayers;
            };

            if (({_x in GVAR(deadPlayerList)} count _deadList) == count _deadList) exitWith {};
            
            GVAR(deadPlayerList) = _deadList;
            _input set [0,_deadList];
                        
            (RESPAWN_DISPLAY displayCtrl 26895) ctrlSetText format["Players in Spectator: %1",count GVAR(deadPlayerList)];
            
            //CHeck specatator List4
            ["refreshDeadListBox"] call FUNC(handleRespawnUI);
            ["refreshAliveListBox"] call FUNC(handleRespawnUI);
            
        },  0.4,[]] call CBA_fnc_addPerFrameHandler;
    };
    case "factionCategoryChanged": {
        private _control = (RESPAWN_DISPLAY displayCtrl 26894); /* respawnMenuFactionCategoryCombo */
        private _newIdx = (lbCurSel _control);
        GVAR(currentFactionCategory) = _control lbData _newIdx;
        GVAR(lastFactionSelection) set [0,_newIdx];
        ["refreshFactionCategoryChanged"] call FUNC(handleRespawnUI);
    };
    case "refreshFactionCategoryChanged": {
        private _control = (RESPAWN_DISPLAY displayCtrl 26928); //Faction list control (for given category)
        lbClear _control;
        private _activeFactionCategory = GVAR(currentFactionCategory);

        if (_activeFactionCategory == "other") then {_activeFactionCategory = "";};

        private _factions = [];

        /* Fill Faction categories */
        private _playerFactions = [] call CBA_fnc_hashCreate;
        {
            private _faction = _x getVariable ["tmf_assignGear_faction",""];
            if (_faction != "") then {
                if ([_playerFactions,_faction] call CBA_fnc_hashHasKey) then {
                    private _value = [_playerFactions,_faction] call CBA_fnc_hashGet;
                    [_playerFactions,_faction,_value + 1] call CBA_fnc_hashSet;
                } else {
                    [_playerFactions,_faction,1] call CBA_fnc_hashSet;
                };
            };
        } forEach (allPlayers);

        if (_activeFactionCategory == "mission") then {
            // use missionConfigFile
            {
                private _factionName = (toLower(configName _x));
                _factions pushBackUnique [getText(_x >> "displayName"),_factionName];
            } forEach (configProperties [missionConfigFile >> "CfgLoadouts","isClass _x"]);

        } else {
            // Then configFile
            {
                private _category = toLower (getText (_x >> "category"));
                if (_activeFactionCategory == _category) then {
                    private _factionName = (toLower(configName _x));
                    _factions pushBackUnique [getText(_x >> "displayName"),_factionName];
                };
            } forEach (configProperties [configFile >> "CfgLoadouts","isClass _x"]);
        };

        //Alphabetical sort.
        _factions sort true;

        {
            _x params ["_displayName","_configName"];
            private _players = 0;
            // Mission factioni class overrides so show 0 if configFile class is of same name.
            if (_activeFactionCategory != "mission" && {isClass (missionConfigFile >> "CfgLoadouts" >> _configName)}) then {
                _players = 0;
            } else {
                if ([_playerFactions,_configName] call CBA_fnc_hashHasKey) then {
                    _players = [_playerFactions,_configName] call CBA_fnc_hashGet;
                };
            };
            private _text = _displayName;
            if (_players > 0) then {
                _text = format ["%1 (%2p)",_displayName,_players];
            };
            private _index = _control lbAdd _text;
            _control lbSetData [_index, _configName];
        } forEach _factions;
        // missionConfigFile first, only add unique factions now

        if (lbSize _control > 0) then {
            _control lbSetCurSel 0; // set to first element.
        };
    };
    case "factionChanged": {

        private _control = (RESPAWN_DISPLAY displayCtrl 26928);  /* Faction Control */
        private _faction = _control lbData (lbCurSel _control);
        GVAR(lastFactionSelection) set [1,lbCurSel _control];
        private _classes = [];

        //MissionConfigFile overrides.
        call {
            if(isClass (missionConfigFile >> "CfgLoadouts" >> _faction)) exitWith {_classes = configProperties [missionConfigFile >> "CfgLoadouts" >> _faction,"isClass _x"];};
            if(isClass (configFile >> "CfgLoadouts" >> _faction) && count _classes <= 0) exitWith {_classes = configProperties [configFile >> "CfgLoadouts" >> _faction,"isClass _x"];};
        };

        private _control = (RESPAWN_DISPLAY displayCtrl 26896); /* Role control */ 
        lbClear _control;
        respawnMenuRoles = [];
        {
            private _displayName = getText(_x >> "displayName");
            private _index = _control lbAdd _displayName;
            private _configName = (configName _x);
            respawnMenuRoles pushBack [_configName,_displayName];
            _control lbSetData [_index,_configName];
        } forEach _classes;
        if (count _classes > 0) then {
            _control lbSetCurSel 0;
        };

    
        GVAR(selectedRespawnGroup) = [];
        ["refreshDeadListBox"] call FUNC(handleRespawnUI);
        ["refreshAliveListBox"] call FUNC(handleRespawnUI);
    };
    case "refreshDeadListBox": {
        lbClear _ctrlDeadListBox;
        {
            private _found = false;
            private _deadPlayer = _x;
            //Check if already selected and thus in the selected respawn listBox.
            {
                if (_deadPlayer == (_x select 1)) exitWith {
                    _found = true;  
                };
            } forEach GVAR(selectedRespawnGroup);
            
            if (!_found) then {
                private _name = _deadPlayer getVariable ["tmf_spectator_name",name _deadPlayer];
                private _idx = _ctrlDeadListBox lbAdd _name;
                _ctrlDeadListBox lbSetData[_idx,_name];
            };
        } forEach GVAR(deadPlayerList);
    };
    case "refreshAliveListBox": {    
        lbClear _ctrlGroupListBox;
        {
            _x params ["_rankIdx","_obj", "_roleIdx"];
            private _name = _obj getVariable ["tmf_spectator_name",name _obj];
            private _idx = _ctrlGroupListBox lbAdd format["%1 - %2", _name, (respawnMenuRoles select _roleIdx) select 1];
           //Set image based on rank
            switch (_rankIdx) do {
                case 0 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa"]; };
                case 1 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa"];};
                case 2 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa"];};
                case 3 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa"];};
                case 4 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa"];};
                case 5 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa"];};
                case 6 : { _ctrlGroupListBox lbSetPicture[_idx,"\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"];};
                default { };
            };
            _ctrlGroupListBox lbSetColor [_idx, [1, 1, 1, 1]];
            _ctrlGroupListBox lbSetPictureColor [_idx, [1,1,1,0.7]];
            _ctrlGroupListBox lbSetPictureColorSelected [_idx,[1,1,1,1]];
        } forEach GVAR(selectedRespawnGroup);
    };
    case "respawnMenuAddAction" : {        
        private _selection = _ctrlDeadListBox lbText (lbCurSel _ctrlDeadListBox);
        
        private _obj = objNull;
        {
            private _name = _x getVariable ["tmf_spectator_name",name _x];
            if (_selection == _name) exitWith {
                _obj = _x;
            };
        } forEach GVAR(deadPlayerList);
        
        if (!(isNull _obj)) then {
            private _role = lbCurSel (RESPAWN_DISPLAY displayCtrl 26896); // Role
            private _rank = lbCurSel (RESPAWN_DISPLAY displayCtrl 26897); // Rank
            
            GVAR(selectedRespawnGroup) pushBack [_rank,_obj,_role];
        };
        
        ["refreshDeadListBox"] call FUNC(handleRespawnUI); 
        ["refreshAliveListBox"] call FUNC(handleRespawnUI); 
    };
    case "respawnMenuRemoveAction": {
        private _ctrlGroupListBox = (RESPAWN_DISPLAY displayCtrl 26892);
        
        GVAR(selectedRespawnGroup) deleteAt (lbCurSel _ctrlGroupListBox);
        
        ["refreshDeadListBox"] call FUNC(handleRespawnUI); 
        ["refreshAliveListBox"] call FUNC(handleRespawnUI); 
    };
    case "respawnMenuChangeRoleAction": {
        private _selection =  (lbCurSel _ctrlGroupListBox);
        if (_selection isEqualTo -1) exitWith {};
        
        private _entry = (GVAR(selectedRespawnGroup) select _selection);
        _entry set [2,((_entry select 2)+1)%(count respawnMenuRoles)];
        GVAR(selectedRespawnGroup) set [_selection,_entry];
        
        ["refreshAliveListBox"] call FUNC(handleRespawnUI); 
    };
    case "respawnMenuChangeRankAction": {
        private _selection =  (lbCurSel _ctrlGroupListBox);
        if (_selection isEqualTo -1) exitWith {};
        
        private _entry = (GVAR(selectedRespawnGroup) select _selection);
        _entry set [0,((_entry select 0)+1)%7];
        GVAR(selectedRespawnGroup) set [_selection,_entry];
        
        ["refreshAliveListBox"] call FUNC(handleRespawnUI); 
    };
    case "respawnMenuToggleGroupCheckbox": {
        GVAR(respawnGroupMarkerCheckBoxVal) = !GVAR(respawnGroupMarkerCheckBoxVal);
    };
    case "respawnMenuRespawnAction": { // respawn button
        if (count GVAR(selectedRespawnGroup) < 1) exitWith { hint "No players selected"; };
   
        private _groupName = ctrlText (RESPAWN_DISPLAY displayCtrl 26898);
        
        // respawnMenuFactions control.
        private _control = (RESPAWN_DISPLAY displayCtrl 26928);
        private _faction = _control lbData (lbCurSel _control);
        
        private _markerName = ctrlText (RESPAWN_DISPLAY displayCtrl 26899);
        private _markerType = lbCurSel (RESPAWN_DISPLAY displayCtrl 26900); // type == -1 if no spawn marker
        private _markerColor =lbCurSel (RESPAWN_DISPLAY displayCtrl 26901);
        if (!GVAR(respawnGroupMarkerCheckBoxVal)) then {
            _markerType = -1;  
        }; 
              
        // Hand over control to the map dialog.
        closeDialog 26893;
        createDialog "respawnMenuMapDialog";

        GVAR(respawnGuiParameters) = [_faction, _groupName, _markerType, _markerColor, _markerName];
    };
    case "respawnMapLoaded": {
        private _mapCtrl = ((findDisplay 26950) displayCtrl 26902);//_this select 0;//
        private _pos = [0,0,0];
        if (alive player && !(player isKindOf "tmf_spectator_unit")) then {
          _pos = getPos player;  
        } else {
            if (count playableUnits > 0) then {
                _pos = getPos (playableUnits select 0);
            } else {
                if (count allUnits > 0) then {
                    _pos = getPos (allUnits select 0);
                };
            };                          
        };
        _mapCtrl ctrlMapAnimAdd [0, 0.1, _pos]; 
        ctrlMapAnimCommit _mapCtrl;
        GVAR(respawnMousePos) = -1;
        GVAR(respawnHalo) = false;
        hint "Click on the map or click on respawn location to draft a position. Hit enter to confirm. Spacebar toggles HALO option (only for user defined point).";
    };
    case "toggleSpectator": {
        if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
            private _isSpectator = [player] call acre_api_fnc_isSpectator;
            [!_isSpectator] call acre_api_fnc_setSpectator;
            if (_isSpectator) then {
                hint "ACRE: Spectator mode de-activated";  
            } else {
                hint "ACRE: Spectator mode activated";  
            };
        };
    };
    case "respawnMap_onMouseButtonDown": {
        _params params["_fullmapWindow","_type","_x","_y"];
        
        if (_type == 0) then { // left click
            private _i = 1;
            private _found = false;
            private _var = missionNamespace getVariable[format["tmf_respawnPoint%1",_i],objNull];
            while {!(isNull _var)} do {
                private _pos = (position _var);
                if (([_x,_y] distance (_fullmapWindow posWorldToScreen _pos)) < 0.1) then {
                    GVAR(respawnMousePos) = _i;
                    _found = true;
                };
                _i = _i + 1;
                _var = missionNamespace getVariable[format["tmf_respawnPoint%1",_i],objNull];
            };
            if (!_found) then {
                GVAR(respawnMousePos) = _fullmapWindow posScreenToWorld [_x,_y];
            };
        };
    };
    case "respawnMap_keyUp": {
        _params params["","_type"];
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
                
                [[_groupName,_position, _faction, GVAR(selectedRespawnGroup), _markerType, _markerColor, _markerName,_halo,GVAR(selectedSide)], QFUNC(respawnWaveServer), false] call BIS_fnc_MP;
                GVAR(selectedRespawnGroup) = [];

                // Close the Map
                ((findDisplay 26950) displayCtrl 26902) ctrlShow false;
                ((findDisplay 26950) displayCtrl 26902) mapCenterOnCamera false;
                closeDialog 26950;
            };
        };
        //SPACEBAR (HALO TOGGLE)
        if (_type == 57) then {
            GVAR(respawnHalo) = !GVAR(respawnHalo);        
        };
    
    };
};
