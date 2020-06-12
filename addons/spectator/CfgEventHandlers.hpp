class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE( call COMPILE_FILE(XEH_postInit) );
        clientInit = QUOTE( call COMPILE_FILE(XEH_clientPostInit) );
    };
};

class Extended_PreInit_Eventhandlers {
    class ADDON {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};
