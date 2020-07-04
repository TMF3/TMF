
XEH_PRESTART;
XEH_PREINIT;

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE( call COMPILE_FILE(XEH_postInit) );
        clientInit = QUOTE( call COMPILE_FILE(XEH_clientPostInit) );
    };
};

class Extended_Init_EventHandlers {
    class GVAR(unit) {
        class ADDON {
            // Throw player into spectator on launch.
            init = QUOTE(_this spawn {                         \
                if !(hasInterface) exitWith {};                \
                waitUntil {!isNull player};                    \
                params ['_unit'];                              \
                if (player == _unit) then {                    \
                    [ARR_3(_unit,_unit,true)] call FUNC(init); \
                };};                                           \
            );
        };
    };
};
