
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
