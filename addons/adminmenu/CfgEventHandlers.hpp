class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE( call COMPILE_FILE(XEH_postInit) );
        serverInit = QUOTE( call COMPILE_FILE(XEH_postServerInit) );
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
        serverInit = QUOTE( call COMPILE_FILE(XEH_preServerInit) );
    };
};
