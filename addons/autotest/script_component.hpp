#define COMPONENT autotest

#include "\x\tmf\addons\main\script_mod.hpp"
#include "\x\tmf\addons\main\script_macros.hpp"

#define GETGEAR(var) [_config >> var] call CFUNC(getCfgEntryFromPath)

#define ERROR 0
#define PASS -1
#define WARNING 1
