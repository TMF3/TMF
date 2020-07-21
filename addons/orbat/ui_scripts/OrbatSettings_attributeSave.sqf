
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
