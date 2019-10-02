class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

class Extended_InitPost_EventHandlers {
    class CAManBase {
        class ADDON {
            init = QUOTE(_this call COMPILE_FILE(XEH_unitInit));
        };
    };
};
