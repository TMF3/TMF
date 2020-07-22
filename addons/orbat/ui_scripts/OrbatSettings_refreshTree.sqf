
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
