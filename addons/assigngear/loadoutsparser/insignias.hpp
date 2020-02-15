code = "private _insign = selectRandom %1; \
if (_insign != 'default') then { \
	if (isPlayer _this) then \
    { \
        [ \
            BIS_fnc_isLoading, \
            BIS_fnc_setUnitInsignia, \
            [_this, _insign], \
            15 \
        ] call CBA_fnc_waitUntilAndExecute; \
    } else { \
        [_this, _insign] call BIS_fnc_setUnitInsignia \
    }; \
}; \
";
