#include "\x\tmf\addons\orbat\script_component.hpp"

params ["_mode",["_params",[]]];

//idcs for various controls, as to hide/show them as needed.
#define MAIN_IDCS [102,103,104,105,106,107,124,125,126,127]
#define EDIT_IDCS [109,110,111,112,113,114,115,116,117,118,119,122,123]
#define MOVE_IDCS [120,108,121]

/*
TODO
- Dump vars with on unload var from UI Namespace?
*/

fn_findNextFreeId = {
    private _usedIDs = [];

    //private _duplicateIDs = [];
    fn_nextHelper = {
        params["_data","_children"];

        _data params ["_id"];
        if (_usedIDs pushBackUnique _id == -1) then {
            //TODO (FUTURE) - cleanup broke IDs.
            //_data set [0,-1];
            //_duplicateIDs pushBack _id;
        };

        {
            _x call fn_nextHelper;
        } forEach _children;

    };

    {
        _x params ["","_root"];
        _root call fn_nextHelper;
    } forEach OrbatSettings_Array;

    if (count _usedIDs == 0) exitWith {0};
    _usedIDs sort false;
    //Return last ID + 1. Alternatively go conservatively and re-use?
    (_usedIDs select 0)+1

};

switch _mode do {
    case "onLoad": {
        TRACE_1("OrbatSettings onLoad",_params);
        //Add EH On touch
        private _ctrlGroup = _params select 0;
        OrbatSettings_ctrlGroup = _ctrlGroup;

        private _playableUnits = playableUnits;
        _playableUnits pushBackUnique player;
        cacheAllPlayerGroups = allGroups select {{_x in _playableUnits} count (units _x) > 0};

        _ctrlGroup ctrladdeventhandler ["setfocus",{with uinamespace do {OrbatSettings_ctrlGroup = _this select 0;};}];
        _ctrlGroup ctrladdeventhandler ["killfocus",{with uinamespace do {OrbatSettings_ctrlGroup = nil;};}];
        {(_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MAIN_IDCS);
        {(_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
        {(_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);


        OrbatSettings_Array = ("TMF_ORBAT_Settings" get3DENMissionAttribute "TMF_ORBATSettings");
        if (OrbatSettings_Array isEqualType "") then {
            OrbatSettings_Array = call compile OrbatSettings_Array;
        };

        if (count OrbatSettings_array > 0) then {
            if ((((OrbatSettings_array) select 0) select 0) isEqualType 0) then {
                {
                    _x set [0,(_x select 0) call EFUNC(common,numToSide)];
                } forEach OrbatSettings_Array;
            };
        };

        // DIK_RETURN = 0x1C
        // Use enter key on controls seems to not work.
        /*
        {
            (_ctrlGroup controlsGroupCtrl _x) ctrladdeventhandler ["keyDown",{
                params ["_control","_key"];
                if (_key == 0x1C) exitWith {
                    with uinamespace do {["editOrbatEntryClickOkay"] call OrbatSettings_script;};
                    true;
                };
                false;
            }];
        } forEach [115,123];
        */

        // Test for now....
        // parameters, children
        //orbat [[],[]],

        //Setup array in recursive manner....

        // UNIQUE_ID will be used for verifying that an entity should be in the current thing.
        // start at 0, then use next free available UNIQUE_ID?
        // data = UNIQUE_ID , display name, texture1, texture2
        //texture 2 is designed for size

        // child = [[data],children]
        //children [child,child,child]

        /*OrbatSettings_Array = [
            [west,[
                    [0,"1PLT","x\tmf\addons\orbat\textures\yellow.paa","x\tmf\addons\orbat\textures\modif_3dot.paa"],
                    [
                        [[1,"A","x\tmf\addons\orbat\textures\red_inf.paa","x\tmf\addons\orbat\textures\modif_dot.paa"],[]]
                    ]
                   ]],
            [east,[
                    [2,"2PLT","x\tmf\addons\orbat\textures\yellow.paa","x\tmf\addons\orbat\textures\modif_3dot.paa"],
                    [
                        [[3,"A","x\tmf\addons\orbat\textures\red_inf.paa","x\tmf\addons\orbat\textures\modif_dot.paa"],[]]
                    ]
                   ]]
        ];*/


        private _ctrlBin = _ctrlGroup controlsGroupCtrl 100;
        private _ctrlToggle = _ctrlGroup controlsGroupCtrl 101;
        private _ctrlTree = _ctrlGroup controlsGroupCtrl 102;

        OrbatFactionsPresent = [];
        OrbatSidesPresent = [];

        {
            OrbatFactionsPresent pushBackUnique (faction (leader _x));
            OrbatSidesPresent pushBackUnique (side _x);
        } forEach cacheAllPlayerGroups;


        private _string = "";
        private _found = false;
        //Open on last open thing if valid.
        if (!isNil "OrbatSelection") then {
            {
                if ((_x select 0) isEqualTo OrbatSelection) exitWith {_found = true;};
            } forEach OrbatSettings_Array;
        };

        if (!_found) then {
            //Default
            if (count OrbatSidesPresent > 0) then {
                OrbatSelection = OrbatSidesPresent select 0;
            } else {
                OrbatSelection = east;
            };
            if (count OrbatSettings_Array > 0) then {
                private _entry = ((OrbatSettings_Array select 0) select 0);
                OrbatSelection = _entry;
                if (_entry isEqualType east) then {
                    _ctrlBin lbSetCurSel 0;
                } else {
                    _ctrlBin lbSetCurSel 1;
                };
            };
        };
        if (OrbatSelection isEqualType east) then {
            _string = OrbatSelection call EFUNC(common,sideToString);
        };
        if (OrbatSelection isEqualType "") then {
            _string = getText (configfile >> "CfgFactionClasses" >> OrbatSelection >> "displayName");
        };

        _ctrlToggle ctrlSetText format["< %1 >", _string];



        ["refreshTree"] call OrbatSettings_script;
    };
    case "refreshTree": {
        TRACE_1("OrbatSettings refreshTree",_params);
        with uiNamespace do {
            private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
            tvClear _ctrlTree;
            if (isNil "OrbatSelection") exitWith {};
            private _idx = -1;
            {
                if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
            } forEach OrbatSettings_Array;
            if ((count cacheAllPlayerGroups == 0) and _idx == -1) exitWith {};
            if (_idx == -1) then {
                _idx = OrbatSettings_Array pushBack [OrbatSelection,[]];
            };

            private _relevantGroups = [];
            private _relevantVehicles = [];
            if (OrbatSelection isEqualType east) then {
                _relevantGroups = (cacheAllPlayerGroups select {side _x == OrbatSelection});
                private _sideStr = str (OrbatSelection call EFUNC(common,sideToNum));
                _relevantVehicles = vehicles select {((_x get3DENAttribute "tmf_orbat_team") param [0,""]) isEqualTo _sideStr};
            };
            if (OrbatSelection isEqualType "") then {
                _relevantGroups = (cacheAllPlayerGroups select {faction (leader _x) == OrbatSelection});
                _relevantVehicles = vehicles select {((_x get3DENAttribute "tmf_orbat_team") param [0,""]) isEqualTo (toLower OrbatSelection)};
            };

            private _rootEntry = (OrbatSettings_Array select _idx) select 1;

            if (count _rootEntry == 0) then {
                _rootEntry pushBack (+[call fn_findNextFreeId, "", "", "", "Platoon",0]);
                _rootEntry pushBack [];
            };
            OrbatTree_Data = [];

            //Find existing IDs in the tree.
            private _orbatTreeUsedIDs = [];
            tmf_fnc_findUsedIDs = {
                params["_data","_children"];

                _data params ["_id"];
                _orbatTreeUsedIDs pushBack _id;

                {
                    _x call tmf_fnc_findUsedIDs;
                } forEach _children;
            };
            _rootEntry call tmf_fnc_findUsedIDs;
            tmf_fnc_findUsedIDs = nil;

            private _toPlace = [];
            private _reserveId = (_rootEntry select 0) select 0;
            private _playableUnits = (playableUnits+switchableUnits+[player]);
            _playableUnits = _playableUnits arrayIntersect _playableUnits;
            {
                if (_x in cacheAllPlayerGroups) then {
                    private _var = (_x get3DENAttribute "TMF_OrbatParent") # 0;
                    if (_var != -1) then {
                        if (_var in _orbatTreeUsedIDs) then {
                            _toPlace pushBack [_var, _x];
                        } else {
                            _x set3DENAttribute ["TMF_OrbatParent", -1];
                            _toPlace pushBack [_reserveId, _x];
                        };
                    } else {
                        _toPlace pushBack [_reserveId, _x];
                    };

                    {
                        private _markerEntry = (_x get3DENAttribute "TMF_SpecialistMarker") # 0;
                        if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                        if (count _markerEntry > 0) then {
                            _markerEntry params ["_mTexture"];
                            if (_mTexture != "") then {
                                if (_var != -1) then {
                                    _toPlace pushBack [_var, _x];
                                } else {
                                    _toPlace pushBack [_reserveId, _x];
                                };
                            };
                        };
                    } forEach (units _x);
                };
            } forEach _relevantGroups;

            {
                private _var = (_x get3DENAttribute "TMF_OrbatParent") # 0;
                if (_var != -1) then {
                    if (_var in _orbatTreeUsedIDs) then {
                        _toPlace pushBack [_var, _x];
                    } else {
                        _x set3DENAttribute ["TMF_OrbatParent", -1];
                        _toPlace pushBack [_reserveId, _x];
                    };
                } else {
                    _toPlace pushBack [_reserveId, _x];
                };
            } forEach _relevantVehicles;

            fn_processTreeEntry = {
                params ["_entry", "_location"];

                if (count _entry == 0) exitWith {}; // nothing to process

                _entry params ["_data", "_children"];
                _data params ["_uniqueID","_name","_tex1","_tex2",["_fName",""]];

                private _string = _fName;
                if (_name != "") then {
                    _string = format["%1 (Marker: %2)", _fName, _name];
                };

                private _myLocation = _location + [_ctrlTree tvAdd [_location, _string]];
                _ctrlTree tvExpand _myLocation;
                _ctrlTree tvSetPicture [_myLocation, _tex1];
                _ctrlTree tvSetValue [_myLocation, OrbatTree_Data pushBack _uniqueID];

                //ENTITY,SORT_ID
                orbat_queue = [];

                private _fnc_addinQueue = {
                    params["_proposedID", "_entity"];
                    private _returnID = -1;
                    for "_testingId" from _proposedID to _proposedID+200 do {
                        private _collision = false;
                        {
                            if (_testingId isEqualTo (_x select 0)) exitWith {_collision = true;}
                        } forEach orbat_queue;

                        if (!_collision) exitWith {
                            _returnID = _testingId;
                        };
                    };
                    orbat_queue pushBack [_returnId, _entity];
                    _returnID
                };

                // Children Logic
                {
                    if (count _x > 0) then {
                        private _data = (_x select 0);
                        if (count _data > 5) then {
                            private _sortId = (_x select 0) select 5; // ID
                            private _returnedId = [_sortId,_x] call _fnc_addinQueue;
                            if (_returnedId != _sortId) then {
                                _data set [5, _returnedId];
                            };
                        };
                    };
                } forEach _children;


                {
                    _x params ["_id", "_entity"];
                    if (_id == _uniqueID) then {
                        if (_entity isEqualType grpNull || {_entity in vehicles}) then {
                            private _markerEntry = (_entity get3DENAttribute "TMF_groupMarker") # 0;
                            if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };

                            private _sortId = 0;
                            if (count _markerEntry > 0) then {
                                if (count _markerEntry > 2) then {
                                    _sortId = _markerEntry select 3;
                                };
                            } else {
                                _markerEntry = ["","","",0];
                            };
                            private _returnedId = [_sortId, _entity] call _fnc_addinQueue;

                            if (_returnedId != _sortId) then {
                                _markerEntry set [3,_returnedId];
                                _entity set3DENAttribute ["TMF_groupMarker",str _markerEntry]
                            };

                            _toPlace set [_forEachIndex,-1];
                        } else {
                            if (_entity isEqualType objNull) then {
                                private _markerEntry = (_entity get3DENAttribute "TMF_SpecialistMarker") # 0;
                                if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                                private _sortId = 0;
                                if (count _markerEntry > 0) then {
                                    _markerEntry params ["_mTexture","",["_sortId",0]];
                                    if (_mTexture != "") then {
                                        private _returnedId = [_sortId, _entity] call _fnc_addinQueue;
                                        if (_returnedId != _sortId) then {
                                            _markerEntry set [2,_returnedId];
                                            _entity set3DENAttribute ["TMF_SpecialistMarker",str _markerEntry]
                                        };
                                    };
                                };/* else {
                                    _markerEntry = ["","",0];
                                };*/

                                _toPlace set [_forEachIndex,-1];
                            };
                        };
                    };
                } forEach _toPlace;
                _toPlace = _toPlace - [-1];

                //Sort queue
                orbat_queue sort true;

                {
                    _x params ["","_entry"];
                    //Virtual Array
                    if (_entry isEqualType []) then {
                        [_entry, _myLocation] call fn_processTreeEntry;
                    };
                    //Groups
                    private _isVeh = _entry in vehicles;
                    if (_entry isEqualType grpNull || _isVeh) then {
                        private _groupMarkerData =  (_entry get3DENAttribute "TMF_groupMarker") select 0;
                        if (_groupMarkerData isEqualType "") then { _groupMarkerData = call compile _groupMarkerData; };

                        private _string = "";
                        if (_isVeh) then {
                            // Get callsign.
                            private _callsign = (_entry get3DENAttribute "TMF_orbat_vehicleCallsign") param [0,""];
                            _string = format ["VEHICLE - %1",getText (configfile >> "CfgVehicles" >> (typeOf _entry) >> "displayName")];
                            if (count _callsign > 0) then {
                                _string = _string + format [" (Callsign: %1)",_callsign];
                            }
                        } else { // Not Veh must be group
                            _string = format["GROUP - %1", groupID _entry];
                        };
                        if (count _groupMarkerData > 0) then {
                            if ((_groupMarkerData select 1) != "") then {
                                _string = _string + format[" (Marker: %1)", _groupMarkerData select 1];
                            };
                        };
                        private _location = _myLocation + [_ctrlTree tvAdd [_myLocation, _string]];

                        _ctrlTree tvSetValue [_location, OrbatTree_Data pushBack _entry];
                        if (count _groupMarkerData > 0) then {
                            _groupMarkerData params ["_icon"];//,"_mName","_size"];
                            _ctrlTree tvSetPicture [_location, _icon];
                        };
                    } else {
                        if (_entry isEqualType objNull) then {
                            private _unitMarkerData =  (_entry get3DENAttribute "TMF_SpecialistMarker") select 0;
                            if (_unitMarkerData isEqualType "") then { _unitMarkerData = call compile _unitMarkerData; };
                            if (count _unitMarkerData > 0) then {
                                _unitMarkerData params ["_unitIcon","_mName"];
                                private _roleDesc = ((_entry get3DENAttribute "description") select 0);
                                if (_roleDesc isEqualTo "") then {
                                    _roleDesc =    getText (configfile >> "CfgVehicles" >> (typeOf _entry) >> "displayName");
                                };
                                private _string = format["UNIT - %1", _roleDesc];
                                if (_mName != "") then {
                                    _string = format["%1 (Marker: %2)", _string, _mName];
                                };

                                _location = _myLocation + [_ctrlTree tvAdd [_myLocation, _string]];

                                _ctrlTree tvSetPicture [_location, _unitIcon];
                                _ctrlTree tvSetValue [_location, OrbatTree_Data pushBack _entry];
                            };
                        };
                    };
                } forEach orbat_queue;
            };
            [_rootEntry, []] call fn_processTreeEntry;
            orbat_queue = nil;
            //orbat_toPlace = _toPlace;
            _ctrlTree tvExpand [0];
        };
    };
    case "orbatToggleButton": {
        TRACE_1("OrbatSettings orbatToggleButton",_params);
        with uiNamespace do {
            private _ctrlToggle = OrbatSettings_ctrlGroup controlsGroupCtrl 101;
            if (OrbatSelection isEqualType east) then {
                private _idx = (OrbatSidesPresent find OrbatSelection) + 1;
                if (_idx >= (count OrbatSidesPresent)) then {
                    _idx = 0;
                };
                OrbatSelection = (OrbatSidesPresent select _idx);
                private _string = OrbatSelection call EFUNC(common,sideToString);
                _ctrlToggle ctrlSetText format["< %1 >", _string];
            };
            if (OrbatSelection isEqualType "") then {
                private _idx = (OrbatFactionsPresent find OrbatSelection) + 1;
                if (_idx >= (count OrbatFactionsPresent)) then {
                    _idx = 0;
                };
                OrbatSelection = (OrbatFactionsPresent select _idx);
                private _string = getText (configfile >> "CfgFactionClasses" >> OrbatSelection >> "displayName");
                _ctrlToggle ctrlSetText format["< %1 >", _string];
            };


            ["refreshTree"] call OrbatSettings_script;
        };
    };
    case "treeDelClick": {
        TRACE_1("OrbatSettings treeDelClick",_params);
        with uiNamespace do {
            private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
            private _treeSel = tvCurSel _ctrlTree;

            if (count _treeSel == 0) exitWith {};
            private _value =  OrbatTree_Data select (_ctrlTree tvValue _treeSel);

            if (_value isEqualType 0) then {
                //find it.
                private _idx = -1;
                {
                    if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
                } forEach OrbatSettings_Array;
                private _entry = (OrbatSettings_Array select _idx) select 1;

                fn_delEntryHelper = {
                    params["_entry", "_value"];
                    private _children = _entry select 1;
                    {
                        _x params ["_data","_entryChildren"];

                        if ((_data select 0) == _value) exitWith {
                            _children append _entryChildren;
                            _children deleteAt _forEachIndex;
                        };
                        [_x, _value] call fn_delEntryHelper;
                    } forEach _children;
                };
                [_entry, _value] call fn_delEntryHelper;

                //Ensure all attributes and purged from groups/units with the attribute.
                {
                    private _attrValue = (_x get3DENAttribute "TMF_OrbatParent") select 0;
                    if (_attrValue == _val) then { _x set3DENAttribute ["TMF_OrbatParent", -1]; };
                    {
                        private _attrValue = (_x get3DENAttribute "TMF_OrbatParent") select 0;
                        if (_attrValue == _val) then { _x set3DENAttribute ["TMF_OrbatParent", -1]; }
                    } forEach (units _x);
                } forEach (cacheAllPlayerGroups);
            };

            ["refreshTree"] call OrbatSettings_script;
        };
    };
    case "treeAddClick": {
        TRACE_1("OrbatSettings treeAddClick",_params);
        with uiNamespace do {
            private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
            if ( count (tvCurSel _ctrlTree) == 0 ) exitWith {};

            private _treeSel = tvCurSel _ctrlTree;
            private _value = OrbatTree_Data select (_ctrlTree tvValue _treeSel);
            if ((_value isEqualType grpNull) or (_value isEqualType objNull)) exitWith {};
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MAIN_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (EDIT_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);

            private _ctrlIconToolbox = OrbatSettings_ctrlGroup controlsGroupCtrl 111;
            private _ctrlColourToolBox = OrbatSettings_ctrlGroup controlsGroupCtrl 113;
            private _ctrlNameEdit = OrbatSettings_ctrlGroup controlsGroupCtrl 115;
            private _ctrlSize = OrbatSettings_ctrlGroup controlsGroupCtrl 117;
            private _ctrlFullNameEdit = OrbatSettings_ctrlGroup controlsGroupCtrl 123;

            _ctrlColourToolBox lbsetcursel 0;
            _ctrlIconToolbox lbsetcursel 0;
            _ctrlSize lbsetcursel 0;
            _ctrlNameEdit ctrlSetText "";
            _ctrlFullNameEdit ctrlSetText "";

            OrbatEditMode = 0; // 0 for add

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

        };
    };
    case "treeEditClick": {
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
    };
    case "editOrbatEntryClickCancel": {
        TRACE_1("OrbatSettings editOrbatEntryClickCancel",_params);
        with uiNamespace do {
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MAIN_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);
            OrbatSettingsCurrentEntity = nil;
        };
    };
    case "editOrbatEntryClickOkay":{
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
    };

    case "treeMoveClick": {
        TRACE_1("OrbatSettings treeMoveClick",_params);
        with uiNamespace do {
            private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
            if ( count (tvCurSel _ctrlTree) == 0 ) exitWith {};
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MAIN_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MOVE_IDCS);

            private _value = OrbatTree_Data select (_ctrlTree tvValue (tvCurSel _ctrlTree));
            if (!(_value isEqualType 0)) then { _value = -1};
            _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 108;
            tvClear _ctrlTree;

            private _idx = -1;
            {
                if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
            } forEach OrbatSettings_Array;
            if (_idx == -1) then {
                _idx = OrbatSettings_Array pushBack [OrbatSelection,[]];
            };

            private _rootEntry = (OrbatSettings_Array select _idx) select 1;

            if (count _rootEntry == 0) then {
                _rootEntry pushBack [call fn_findNextFreeId, "", "", ""];
                _rootEntry pushBack [];
            };

            fn_processTreeEntry2 = {
                params ["_entry", "_location", "_value"];

                if (count _entry == 0) exitWith {}; // nothing to process

                _entry params ["_data", "_children"];
                _data params ["_id","_name","_tex1","_tex2",["_fName",""]];

                if (_id != _value) then {
                    private _string = _fName;
                    if (_name != "") then {
                        _string = format["%1 (Marker: %2)", _fName, _name];
                    };
                    private _myLocation = _location + [_ctrlTree tvAdd [_location, _string]];
                    _ctrlTree tvSetPicture [_myLocation, _tex1];
                    _ctrlTree tvSetValue [_myLocation, _id];
                    _ctrlTree tvExpand _myLocation;

                    {
                        [_x, _myLocation, _value] call fn_processTreeEntry2;
                    } forEach _children;
                };
            };

            [_rootEntry, [], _value] call fn_processTreeEntry2;

        };
    };
    case "moveTreeDoubleClick": {
        TRACE_1("OrbatSettings moveTreeDoubleClick",_params);
        with uiNamespace do {

            //Find entry to move and remove it
            private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
            private _value = (_ctrlTree tvValue (tvCurSel _ctrlTree));
            _value = (OrbatTree_Data select _value);

            if (_value isEqualType 0) then {
                private _idx = -1;
                {
                    if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
                } forEach OrbatSettings_Array;
                if (_idx == -1) then {
                    _idx = OrbatSettings_Array pushBack [OrbatSelection,[]];
                };

                private _rootEntry = (OrbatSettings_Array select _idx) select 1;

                OrbatSettingsDesiredEntry = [];
                fn_findEntryHelper = {
                    params["_entry", "_value"];
                    private _children = _entry select 1;
                    {
                        _x params ["_data","_entryChildren"];
                        if ((_data select 0) == _value) exitWith {
                            OrbatSettingsDesiredEntry = _x;
                            _children deleteAt _forEachIndex;
                        };
                        [_x, _value] call fn_findEntryHelper;
                    } forEach _children;
                };
                [_rootEntry, _value] call fn_findEntryHelper;

                //Push Entry...
                if (count OrbatSettingsDesiredEntry > 0) then {
                    _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 108;
                    _value = (_ctrlTree tvValue (tvCurSel _ctrlTree));
                    fn_orbatSearchHelper = {
                        params["_entry", "_value"];
                        _entry params ["_data","_children"];
                        if ((_data select 0) == _value) exitWith {
                            _children pushBack OrbatSettingsDesiredEntry;
                            true
                        };
                        {
                            if ([_x, _value] call fn_orbatSearchHelper) exitWith {true};
                        } forEach _children;
                        false
                    };
                    [_rootEntry, _value] call fn_orbatSearchHelper;
                };
                OrbatSettingsDesiredEntry = nil;
            };
            if (_value isEqualType grpNull || {_value in vehicles}) then {
                _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 108;
                _value set3DENAttribute ["TMF_OrbatParent", (_ctrlTree tvValue (tvCurSel _ctrlTree))];
            };

            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MAIN_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);
            ["refreshTree"] call OrbatSettings_script;
        };
    };
    case "attributeSave": {
        private _array = +(uiNamespace getVariable "OrbatSettings_Array");
        if (count _array > 0) then {
            if ((((_array) select 0) select 0) isEqualType east) then {
                {
                    _x set [0,(_x select 0) call EFUNC(common,sideToNum)];
                } forEach _array;
            };
        };
        TRACE_2("OrbatSettings attrSave",_params,_array);
        str _array
    };
    case "attributeLoad": {
        TRACE_1("OrbatSettings attrLoad",_params);
    // Do nothing.
    };
    case "orbatBinChanged": {
        TRACE_1("OrbatSettings orbatBinChanged",_params);
        if ((_params select 1)==0)then { //side
            with uiNamespace do {
                OrbatSelection = OrbatSidesPresent select 0;
            };
        } else {
            with uiNamespace do {
                OrbatSelection = OrbatFactionsPresent select 0;
            };
        };
        with uiNamespace do {

            OrbatSettings_Array = [    [OrbatSelection,[]]    ];

            //ERASE ATTRIBUTES
            {
                private _attrValue = (_x get3DENAttribute "TMF_OrbatParent") select 0;
                if (_attrValue == _val) then { _x set3DENAttribute ["TMF_OrbatParent", -1]; };
                {
                    private _attrValue = (_x get3DENAttribute "TMF_OrbatParent") select 0;
                    if (_attrValue == _val) then { _x set3DENAttribute ["TMF_OrbatParent", -1]; }
                } forEach (units _x);
            } forEach (cacheAllPlayerGroups);

            private _ctrlToggle = OrbatSettings_ctrlGroup controlsGroupCtrl 101;

            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow true;} forEach (MAIN_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (EDIT_IDCS);
            {(OrbatSettings_ctrlGroup controlsGroupCtrl _x) ctrlShow false;} forEach (MOVE_IDCS);
            private _string = "";
            if (OrbatSelection isEqualType east) then {
                _string = OrbatSelection call EFUNC(common,sideToString);
            };
            if (OrbatSelection isEqualType "") then {
                _string = getText (configfile >> "CfgFactionClasses" >> OrbatSelection >> "displayName");
            };

            _ctrlToggle ctrlSetText format["< %1 >", _string];
            ["refreshTree"] call OrbatSettings_script;
        };
    };
    case "moveUp";
    case "moveDown";
    case "moveBottom";
    case "moveTop": {
        TRACE_1("OrbatSettings moveAny",_params);
        with uiNamespace do {
            private _ctrlTree = OrbatSettings_ctrlGroup controlsGroupCtrl 102;
            private _value = OrbatTree_Data select (_ctrlTree tvValue (tvCurSel _ctrlTree));

            // MOVE CODE
            private _idx = -1;
            {
                if ((_x select 0) isEqualTo OrbatSelection) exitWith { _idx = _forEachIndex;};
            } forEach OrbatSettings_Array;
            if ((count cacheAllPlayerGroups == 0) and _idx == -1) exitWith {};
            if (_idx == -1) then {
                //_idx = OrbatSettings_Array pushBack [OrbatSelection,[]];
            };

            private _relevantGroups = [];
            private _relevantVehicles = [];
            if (OrbatSelection isEqualType east) then {
                _relevantGroups = (cacheAllPlayerGroups select {side _x == OrbatSelection});
                private _sideStr = str (OrbatSelection call EFUNC(common,sideToNum));
                _relevantVehicles = vehicles select {((_x get3DENAttribute "tmf_orbat_team") param [0,""]) isEqualTo _sideStr};
            };
            if (OrbatSelection isEqualType "") then {
                _relevantGroups = (cacheAllPlayerGroups select {faction (leader _x) == OrbatSelection});
                _relevantVehicles = vehicles select {((_x get3DENAttribute "tmf_orbat_team") param [0,""]) isEqualTo (toLower OrbatSelection)};
            };

            private _rootEntry = (OrbatSettings_Array select _idx) select 1;
            private _toPlace = [];
            private _reserveId = (_rootEntry select 0) select 0;
            private _playableUnits = (playableUnits+switchableUnits+[player]);
            _playableUnits = _playableUnits arrayIntersect _playableUnits;
            {
                if (_x in cacheAllPlayerGroups) then {
                    private _var = (_x get3DENAttribute "TMF_OrbatParent") # 0;
                    if (_var != -1) then {
                        _toPlace pushBack [_var, _x];
                    } else {
                        _toPlace pushBack [_reserveId, _x];
                    };
                    {
                        private _markerEntry = (_x get3DENAttribute "TMF_SpecialistMarker") # 0;
                        if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                        if (count _markerEntry > 0) then {
                            _markerEntry params ["_mTexture"];
                            if (_mTexture != "") then {
                                if (_var != -1) then {
                                    _toPlace pushBack [_var, _x];
                                } else {
                                    _toPlace pushBack [_reserveId, _x];
                                };
                            };
                        };
                    } forEach (units _x);
                };
            } forEach _relevantGroups;
            //Find existing IDs in the tree.
            private _orbatTreeUsedIDs = [];
            tmf_fnc_findUsedIDs = {
                params["_data","_children"];

                _data params ["_id"];
                _orbatTreeUsedIDs pushBack _id;

                {
                    _x call tmf_fnc_findUsedIDs;
                } forEach _children;
            };
            _rootEntry call tmf_fnc_findUsedIDs;
            tmf_fnc_findUsedIDs = nil;
            {
                private _var = (_x get3DENAttribute "TMF_OrbatParent") # 0;
                if (_var != -1) then {
                    if (_var in _orbatTreeUsedIDs) then {
                        _toPlace pushBack [_var, _x];
                    } else {
                        _x set3DENAttribute ["TMF_OrbatParent", -1];
                        _toPlace pushBack [_reserveId, _x];
                    };
                } else {
                    _toPlace pushBack [_reserveId, _x];
                };
            } forEach _relevantVehicles;

            fn_processTreeEntry = {
                params ["_entry", "_location"];

                if (count _entry == 0) exitWith {}; // nothing to process

                _entry params ["_data", "_children"];
                _data params ["_uniqueID"];

                //ENTITY,SORT_ID
                orbat_queue = [];

                // Children Logic
                {
                    if (count _x > 0) then {
                        private _data = (_x select 0);
                        if ((_data select 0) isEqualTo _value) then { _value = _x }; //attempted array fix
                        if (count _data > 5) then {
                            private _sortId = (_x select 0) select 5; // ID
                            orbat_queue pushBack [_sortId,_x];
                        };
                    };
                } forEach _children;


                {
                    _x params ["_id", "_entity"];
                    if (_id == _uniqueID) then {
                        if (_entity isEqualType grpNull || {_entity in vehicles}) then {
                            private _markerEntry = (_entity get3DENAttribute "TMF_groupMarker") # 0;
                            if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                            private _sortId = 0;
                            if (count _markerEntry > 3) then {
                                _sortId = _markerEntry select 3;
                            };
                            orbat_queue pushBack [_sortId, _entity];

                            _toPlace set [_forEachIndex, -1];
                        } else {
                            if (_entity isEqualType objNull) then {
                                private _markerEntry = (_entity get3DENAttribute "TMF_SpecialistMarker") # 0;
                                if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                                private _sortId = 0;
                                if (count _markerEntry > 2) then {
                                    _sortId = _markerEntry select 2;
                                };
                                orbat_queue pushBack [_sortId, _entity];

                                _toPlace set [_forEachIndex, -1];
                            };
                        };
                    };
                } forEach _toPlace;
                _toPlace = _toPlace - [-1];

                //Sort queue
                orbat_queue sort true;


                private _found = false;
                {
                    _x params ["_sortId","_entry"];
                    if (_entry isEqualTo _value) exitWith {
                        _found = true;
                        private _newsSortId = _sortId; // keep old ID

                        private _swapEntry = -1;

                        if (_mode == "moveTop") then {
                            _newsSortId = ((orbat_queue select (0)) select 0)-1;
                            _swapEntry = -1;
                        };
                        if (_mode == "moveBottom") then {
                            _newsSortId = ((orbat_queue select ((count orbat_queue) - 1)) select 0)+1;
                            _swapEntry = -1;
                        };
                        if (_mode == "moveDown") then {
                            if (_forEachIndex +1 < count orbat_queue) then {
                                _newsSortId = ((orbat_queue select (_forEachIndex + 1)) select 0);
                                _swapEntry = ((orbat_queue select (_forEachIndex + 1)) select 1);
                            };
                        };
                        if (_mode == "moveUp") then {
                            if (_forEachIndex - 1 > -1) then {
                                _newsSortId = ((orbat_queue select (_forEachIndex - 1)) select 0);
                                _swapEntry = ((orbat_queue select (_forEachIndex - 1)) select 1);
                            };
                        };
                        // Put in place
                        if (_entry isEqualType []) then {
                            private _data = (_entry select 0);
                            _data set [5,_newsSortId];
                        };
                        if (_entry isEqualType grpNull || {_entry in vehicles}) then {

                            private _markerEntry = (_entry get3DENAttribute "TMF_groupMarker") # 0;
                            if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };

                            if (count _markerEntry == 0) then {
                                _markerEntry = (+["","","",0]);
                            };

                            _markerEntry set [3,_newsSortId];
                            _entry set3DENAttribute ["TMF_groupMarker",str _markerEntry];
                        } else {
                            if (_entry isEqualType objNull) then {
                                private _markerEntry = _entry getVariable ["TMF_SpecialistMarker",[]];
                                if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                                if (count _markerEntry == 0) then {
                                    _markerEntry = ["","",0];
                                };

                                _markerEntry set [2,_newsSortId];
                                _entry set3DENAttribute ["TMF_SpecialistMarker",str _markerEntry]
                            };
                        };
                        // Swap
                        if (_swapEntry isEqualType []) then {
                            private _data = (_swapEntry select 0);
                            _data set [5,_sortId];
                        };
                        if (_swapEntry isEqualType grpNull || {_swapEntry in vehicles}) then {
                            private _markerEntry = (_swapEntry get3DENAttribute "TMF_groupMarker") # 0;
                            if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };

                            if (count _markerEntry == 0) then {
                                _markerEntry = (+["","","",0]);
                            };

                            _markerEntry set [3,_sortId];
                            _swapEntry set3DENAttribute ["TMF_groupMarker",str _markerEntry];
                        } else {
                            if (_swapEntry isEqualType objNull) then {
                                private _markerEntry = (_swapEntry get3DENAttribute "TMF_SpecialistMarker") # 0;
                                if (_markerEntry isEqualType "") then { _markerEntry = call compile _markerEntry; };
                                if (count _markerEntry == 0) then {
                                    _markerEntry = ["","",0];
                                };

                                _markerEntry set [2,_sortId];
                                _swapEntry set3DENAttribute ["TMF_SpecialistMarker",str _markerEntry]
                            };
                        };
                    };
                } forEach orbat_queue;

                //do sub children
                if (!_found) then {
                    {
                        _x params ["","_entry"];
                        if (_entry isEqualType []) then {
                            [_entry, _myLocation] call fn_processTreeEntry;
                        };
                    } forEach orbat_queue;
                };
                //orbat_queue = nil;
            };
            [_rootEntry, []] call fn_processTreeEntry;



            //END MOVE


            ["refreshTree"] call OrbatSettings_script;
        };
    };


};
