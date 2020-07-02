#include "\x\cba\addons\main\script_macros_common.hpp"

// Change PREP to point to folder
#ifdef PREP
    #undef PREP
#endif
#ifdef PREPMAIN
    #undef PREPMAIN
#endif

#ifdef DISABLE_COMPILE_CACHE
    #define PREP(var1) TRIPLES(ADDON,fnc,var1) = compile preProcessFileLineNumbers 'PATHTO_SYS(PREFIX,COMPONENT_F,DOUBLES(functions\fnc,var1))'
    #define PREPMAIN(var1) TRIPLES(PREFIX,fnc,var1) = compile preProcessFileLineNumbers 'PATHTO_SYS(PREFIX,COMPONENT_F,DOUBLES(functions\fnc,var1))'
#else
    #define PREP(var1) ['PATHTO_SYS(PREFIX,COMPONENT_F,DOUBLES(fnc,var1))', 'TRIPLES(ADDON,(functions\fnc,var1)'] call SLX_XEH_COMPILE_NEW
    #define PREPMAIN(var1) ['PATHTO_SYS(PREFIX,COMPONENT_F,DOUBLES(fnc,var1))', 'TRIPLES(PREFIX,(functions\fnc,var1)'] call SLX_XEH_COMPILE_NEW
#endif

// Expanding on CBA macros
#define CFUNC(var) EFUNC(common,var)
#define QCFUNC(var) QUOTE(CFUNC(var))

// Chat macros
#define IS_CMND_AVAILABLE(var,cmnd) if !([var,cmnd] call EFUNC(chat,commandAvailable)) exitWith {}
