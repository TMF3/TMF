#define COMPONENT assignGear

#include "\x\tmf\addons\main\script_mod.hpp"
#include "\x\tmf\addons\main\script_macros.hpp"

#define CURUNIT (call CBA_fnc_currentUnit)

/* RscGearSelector*/
#define IDD_RSCGEARSELECTOR             832400
#define IDC_RSCGEARSELECTOR_CATEGORY    832401
#define IDC_RSCGEARSELECTOR_FACTION     832402
#define IDC_RSCGEARSELECTOR_ROLE        832403
#define IDC_RSCGEARSELECTOR_SUBMIT      832404
#define IDC_RSCGEARSELECTOR_RANDOM      832405

/* AssignGear Vehicle */
#define IDC_VEHICLEGEAR_CATEGORY 666434
#define IDC_VEHICLEGEAR_FACTION 666343
#define IDC_VEHICLEGEAR_FILTER 666964
#define IDC_VEHICLEGEAR_LIST 666344
#define IDC_VEHICLEGEAR_CLEAR 666656
#define IDC_VEHICLEGEAR_ADD 666777
#define IDC_VEHICLEGEAR_SUBTRACT 666888
/* assignGear specific macros */
#define GETGEAR(var) [_cfg >> var] call CFUNC(getCfgEntryFromPath)
#define LIST_2(var1) var1,var1
#define LIST_3(var1) var1,var1,var1
#define LIST_4(var1) var1,var1,var1,var1
#define LIST_5(var1) var1,var1,var1,var1,var1
#define LIST_6(var1) var1,var1,var1,var1,var1,var1
#define LIST_7(var1) var1,var1,var1,var1,var1,var1,var1
#define LIST_8(var1) var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_9(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_10(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_11(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_12(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_13(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_14(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_15(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_16(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_17(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_18(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_19(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1
#define LIST_20(var1) var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1,var1


#define FILTER_WEAPON 0
#define FILTER_GEAR 1
#define FILTER_ITEMS 2