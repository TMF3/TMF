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
        #include "OrbatSettings_onLoad.sqf"
    };
    case "refreshTree": {
        #include "OrbatSettings_refreshTree.sqf"
    };
    case "orbatToggleButton": {
        #include "OrbatSettings_orbatToggleButton.sqf"
    };
    case "treeDelClick": {
        #include "OrbatSettings_treeDelClick.sqf"
    };
    case "treeAddClick": {
        #include "OrbatSettings_treeAddClick.sqf"
    };
    case "treeEditClick": {
        #include "OrbatSettings_treeEditClick.sqf"
    };
    case "editOrbatEntryClickCancel": {
        #include "OrbatSettings_editOrbatEntryClickCancel.sqf"
    };
    case "editOrbatEntryClickOkay":{
        #include "OrbatSettings_editOrbatEntryClickOkay.sqf"
    };
    case "treeMoveClick": {
        #include "OrbatSettings_treeMoveClick.sqf"
    };
    case "moveTreeDoubleClick": {
        #include "OrbatSettings_moveTreeDoubleClick.sqf"
    };
    case "attributeSave": {
        #include "OrbatSettings_attributeSave.sqf"
    };
    case "attributeLoad": {
        #include "OrbatSettings_attributeLoad.sqf"
    };
    case "orbatBinChanged": {
        #include "OrbatSettings_orbatBinChanged.sqf"
    };
    case "moveUp";
    case "moveDown";
    case "moveBottom";
    case "moveTop": {
        #include "OrbatSettings_move.sqf"
    };
};
