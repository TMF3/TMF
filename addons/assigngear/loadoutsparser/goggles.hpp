code = "private _goggles = selectRandom %1; \
if (_goggles != 'default') then { \
	if (isPlayer _this) then \
    { \
        [ \
            BIS_fnc_isLoading, \
            { \
                if (_this # 1 isEqualTo '') exitWith { \
                    removeGoggles _this # 0 \
                } else { \
                    (_this # 0) addGoggles (_this # 1); \
                }; \
            }, \
            [_this, _goggles], \
            15 \
        ] call CBA_fnc_waitUntilAndExecute; \
    } else { \
        if !(_goggles isEqualTo '') then { \
            _this addGoggles _goggles; \
        }; \
    }; \
} else \
{ \
    if !(_defGoggles isEqualTo '') then {_this addGoggles _defGoggles}; \
}; \
";
