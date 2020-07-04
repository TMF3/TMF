#include "\x\cba\addons\main\script_macros_common.hpp"

// Change PREP to point to folder

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(var1) TRIPLES(ADDON,fnc,var1) = compile preProcessFileLineNumbers 'PATHTO_SYS(PREFIX,COMPONENT_F,DOUBLES(functions\fnc,var1))'
    #undef PREPMAIN
    #define PREPMAIN(var1) TRIPLES(PREFIX,fnc,var1) = compile preProcessFileLineNumbers 'PATHTO_SYS(PREFIX,COMPONENT_F,DOUBLES(functions\fnc,var1))'
#else
    #undef PREP
    #define PREP(var1) ['PATHTO_SYS(PREFIX,COMPONENT_F,DOUBLES(functions\fnc,var1))', 'TRIPLES(ADDON,fnc,var1)'] call SLX_XEH_COMPILE_NEW
    #undef PREPMAIN
    #define PREPMAIN(var1) ['PATHTO_SYS(PREFIX,COMPONENT_F,DOUBLES(functions\fnc,var1))', 'TRIPLES(PREFIX,fnc,var1)'] call SLX_XEH_COMPILE_NEW
#endif

// XEH templates
#define XEH_POSTINIT                                    \
class Extended_PostInit_EventHandlers {                 \
    class ADDON {                                       \
        init = QUOTE( call COMPILE_FILE(XEH_postInit) );\
    };                                                  \
}

#define XEH_PREINIT                                    \
class Extended_PreInit_EventHandlers {                 \
    class ADDON {                                      \
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );\
    };                                                 \
}

#define XEH_PRESTART                                    \
class Extended_PreStart_EventHandlers {                 \
    class ADDON {                                       \
        init = QUOTE( call COMPILE_FILE(XEH_preStart) );\
    };                                                  \
}

// Expanding on CBA macros
#define CFUNC(var) EFUNC(common,var)
#define QCFUNC(var) QUOTE(CFUNC(var))

// Chat macros
#define IS_CMND_AVAILABLE(var,cmnd) if !([var,cmnd] call EFUNC(chat,commandAvailable)) exitWith {}
