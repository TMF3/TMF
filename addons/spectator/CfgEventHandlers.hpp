
XEH_PRESTART;
XEH_PREINIT;

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE( call COMPILE_FILE(XEH_postInit) );
        clientInit = QUOTE( call COMPILE_FILE(XEH_clientPostInit) );
    };
};
