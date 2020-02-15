code = "private _faces = %1; \
if (isPlayer _this) then { \
    [ \
        BIS_fnc_isLoading, \
        TMF_assignGear_fnc_setFace, \
        [_this, _faces], \
        15 \
    ] call CBA_fnc_waitUntilAndExecute; \
} else { \
    [_this, _faces] call TMF_assignGear_fnc_setFace; \
}; \
";
