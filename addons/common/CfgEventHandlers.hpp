
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE( call COMPILE_FILE(XEH_postInit) );
    };
};

class Extended_Init_EventHandlers {
    class CAManBase {
        class ADDON {
            serverInit = "_this call tmf_common_fnc_checkJIP; ";
            init = "if (isTMF && local (_this select 0)) then {(_this select 0) addRating 100000;};"; // prevent AI friendly fire.
        };
    };
    class GVAR(hideMapObjects) {
        class ADDON {
            init = QUOTE(_this call FUNC(hideMapObjectsInit));
        };
    };
};

class Extended_InitPost_EventHandlers {
    class Car {
        class ADDON {
            init = "(_this select 0) allowCrewInImmobile true;";
        };
    };
    class Tank {
        class ADDON {
            init = "(_this select 0) allowCrewInImmobile true;";
        };
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayMultiplayerSetup {
        tmf_slotting = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayMultiplayerSetup)'));
    };
};
