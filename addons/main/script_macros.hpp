#include "\x\cba\addons\main\script_macros_common.hpp"

// Expanding on CBA macros
#define EGVAR(module,var) TRIPLES(PREFIX,module,var)
#define QEGVAR(module,var) QUOTE(EGVAR(module,var))
#define QGVARMAIN(var) QUOTE(GVARMAIN(var))
#define CFUNC(var) EFUNC(common,var)
#define QFUNC(var1) QUOTE(FUNC(var1))

#ifndef PATHTO_FOLDER_SYS
    #define PATHTO_FOLDER_SYS(var1,var2,var3) \MAINPREFIX\##var1\SUBPREFIX\##var2\##var3
#endif
#define PATHTO_FOLDER(var1) PATHTO_FOLDER_SYS(PREFIX,COMPONENT,var1)
#define QPATHTO_FOLDER(var1) QUOTE(PATHTO_FOLDER_SYS(PREFIX,COMPONENT,var1))

// Debug macros
#define DEBUG_LOG(text) [__FILE__,__LINE__,text] call CFUNC(debugLog)
#define DEBUG_LOG_1(text,A) DEBUG_LOG(FORMAT_1(text,A))
#define DEBUG_LOG_2(text,A,B) DEBUG_LOG(FORMAT_2(text,A,B))
#define DEBUG_LOG_3(text,A,B,C) DEBUG_LOG(FORMAT_3(text,A,B,C))
#define DEBUG_LOG_4(text,A,B,C,D) DEBUG_LOG(FORMAT_4(text,A,B,C,D))
#define DEBUG_LOG_5(text,A,B,C,D,E) DEBUG_LOG(FORMAT_5(text,A,B,C,D,E))
#define DEBUG_LOG_6(text,A,B,C,D,E,F) DEBUG_LOG(FORMAT_6(text,A,B,C,D,E,F))
#define DEBUG_LOG_7(text,A,B,C,D,E,F,G) DEBUG_LOG(FORMAT_7(text,A,B,C,D,E,F,G))
#define DEBUG_LOG_8(text,A,B,C,D,E,F,G,H) DEBUG_LOG(FORMAT_8(text,A,B,C,D,E,F,G,H))

#define DEBUG_ERR(text) [__FILE__,__LINE__,text] call CFUNC(debugError)
#define DEBUG_ERR_1(text,A) DEBUG_ERR(FORMAT_1(text,A))
#define DEBUG_ERR_2(text,A,B) DEBUG_ERR(FORMAT_2(text,A,B))
#define DEBUG_ERR_3(text,A,B,C) DEBUG_ERR(FORMAT_3(text,A,B,C))
#define DEBUG_ERR_4(text,A,B,C,D) DEBUG_ERR(FORMAT_4(text,A,B,C,D))
#define DEBUG_ERR_5(text,A,B,C,D,E) DEBUG_ERR(FORMAT_5(text,A,B,C,D,E))
#define DEBUG_ERR_6(text,A,B,C,D,E,F) DEBUG_ERR(FORMAT_6(text,A,B,C,D,E,F))
#define DEBUG_ERR_7(text,A,B,C,D,E,F,G) DEBUG_ERR(FORMAT_7(text,A,B,C,D,E,F,G))
#define DEBUG_ERR_8(text,A,B,C,D,E,F,G,H) DEBUG_ERR(FORMAT_8(text,A,B,C,D,E,F,G,H))

#define DEBUG_MSG(text) [QUOTE(COMPONENT),text] call CFUNC(debugMsg)
#define DEBUG_MSG_1(text,A) DEBUG_MSG(FORMAT_1(text,A))
#define DEBUG_MSG_2(text,A,B) DEBUG_MSG(FORMAT_2(text,A,B))
#define DEBUG_MSG_3(text,A,B,C) DEBUG_MSG(FORMAT_3(text,A,B,C))
#define DEBUG_MSG_4(text,A,B,C,D) DEBUG_MSG(FORMAT_4(text,A,B,C,D))
#define DEBUG_MSG_5(text,A,B,C,D,E) DEBUG_MSG(FORMAT_5(text,A,B,C,D,E))
#define DEBUG_MSG_6(text,A,B,C,D,E,F) DEBUG_MSG(FORMAT_6(text,A,B,C,D,E,F))
#define DEBUG_MSG_7(text,A,B,C,D,E,F,G) DEBUG_MSG(FORMAT_7(text,A,B,C,D,E,F,G))
#define DEBUG_MSG_8(text,A,B,C,D,E,F,G,H) DEBUG_MSG(FORMAT_8(text,A,B,C,D,E,F,G,H))

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(var1),var2)]
#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(var1),var2)]
#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(var1),var2,true)]

#define GETVAR(var1,var2,var3) var1 GETVAR_SYS(var2,var3)
#define GETMVAR(var1,var2) missionNamespace GETVAR_SYS(var1,var2)
#define GETUVAR(var1,var2) uiNamespace GETVAR_SYS(var1,var2)
#define GETPRVAR(var1,var2) profileNamespace GETVAR_SYS(var1,var2)
#define GETPAVAR(var1,var2) parsingNamespace GETVAR_SYS(var1,var2)

#define SETVAR(var1,var2,var3) var1 SETVAR_SYS(var2,var3)
#define SETPVAR(var1,var2,var3) var1 SETPVAR_SYS(var2,var3)
#define SETMVAR(var1,var2) missionNamespace SETVAR_SYS(var1,var2)
#define SETUVAR(var1,var2) uiNamespace SETVAR_SYS(var1,var2)
#define SETPRVAR(var1,var2) profileNamespace SETVAR_SYS(var1,var2)
#define SETPAVAR(var1,var2) parsingNamespace SETVAR_SYS(var1,var2)

#define GETGVAR(var1,var2) GETMVAR(GVAR(var1),var2)
#define GETEGVAR(var1,var2,var3) GETMVAR(EGVAR(var1,var2),var3)
