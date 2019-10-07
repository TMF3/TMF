#define COMPONENT autotest

#include "\x\tmf\addons\main\script_mod.hpp"
#include "\x\tmf\addons\main\script_macros.hpp"

#define GETGEAR(var) [_config >> var] call CFUNC(getCfgEntryFromPath)

#define CFGWEAPONS (configFile >> "CfgWeapons")
#define CFGVEHICLES (configFile >> "CfgVehicles")
#define CFGGLASSES (configFile >> "CfgGlasses")
#define CFGMAGAZINES (configFile >> "CfgMagazines")

#define PRIMARYSLOT 1
#define HANDGUNSLOT 2
#define SECONDARYSLOT 4

#define ERROR 0
#define PASS -1
#define WARNING 1
