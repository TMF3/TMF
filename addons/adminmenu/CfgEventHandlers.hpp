class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE( call COMPILE_FILE(XEH_postInit) );
        serverInit = QUOTE( call COMPILE_FILE(XEH_postServerInit) );
    };
};

XEH_PREINIT;
XEH_PRESTART;
