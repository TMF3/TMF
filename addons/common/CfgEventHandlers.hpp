
XEH_PRESTART;
XEH_PREINIT;
XEH_POSTINIT;

class Extended_Init_EventHandlers {
    class GVAR(hideMapObjects) {
        class ADDON {
            init = QUOTE(_this call FUNC(hideMapObjectsInit));
        };
    };
};

class Extended_Respawn_EventHandlers {
    class CAManBase {
        class ADDON {
            respawn = QUOTE((_this select 0) setVariable [ARR_3(QQGVARMAIN(lastRespawn),time,true)]);
        };
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayDebriefing {
        tmf_override_end_text = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayDebriefing)'));
    };
};
