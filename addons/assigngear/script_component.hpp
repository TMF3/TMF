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

/* RscAttributeLoadout */
#define IDC_RSCATTRIBUTELOADOUT_TITLE       833400
#define IDC_RSCATTRIBUTELOADOUT_COMBO       833401
#define IDC_RSCATTRIBUTELOADOUT_RSCATTRIBUTELOADOUT 833402

/* RscAttributeFaction */
#define IDC_RSCATTRIBUTEFACTION_TITLE       834400
#define IDC_RSCATTRIBUTEFACTION_COMBO       834401
#define IDC_RSCATTRIBUTEFACTION_RSCATTRIBUTEFACTION 834402

/* RscAttributeRetroactive */
#define IDC_RSCATTRIBUTERETROACTIVE_TITLE       835400
#define IDC_RSCATTRIBUTERETROACTIVE_BCG         835401
#define IDC_RSCATTRIBUTERETROACTIVE_TOOLBOX     835402
#define IDC_RSCATTRIBUTERETROACTIVE_RSCATTRIBUTERETROACTIVE 835403

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

/* assignGear _loadout indexes */
// Appearance
#define IDX_DISPLAY_NAME 0
// Containers - These must come before Items.
#define IDX_UNIFORM 1
#define IDX_VEST 2
#define IDX_BACKPACK 3
#define IDX_FACES 4
// Insignias - This must come after uniform otherwise it will fail to apply.
#define IDX_INSIGNIAS 5
// Equipment
#define IDX_HEADGEAR 6
#define IDX_GOGGLES 7
#define IDX_HMD 8
// Weapons & Weapon Magazine - These must come before magazines. 
// Otherwise the weapon specific magazines will not work. E.g. PrimaryMagazine
// Primary
#define IDX_PRIMARY_WEAPON 9
// Must come after PrimaryWeapon
#define IDX_PRIMARY_MAGAZINE 10 
#define IDX_PRIMARY_SCOPE 11
#define IDX_PRIMARY_BIPOD 12
#define IDX_PRIMARY_ATTACHMENT 13
#define IDX_PRIMARY_SILENCER 14
// Secondary
#define IDX_SECONDARY_WEAPON 15
// Must come after SecondaryWeapon
#define IDX_SECONDARY_MAGAZINE 16 
#define IDX_SECONDARY_ATTACHMENT 17
// Sidearm
#define IDX_SIDEARM_WEAPON 18
// Must come after SidearmWeapon
#define IDX_SIDEARM_MAGAZINE 19 
#define IDX_SIDEARM_ATTACHMENT 20
// Items & Magazines
// Items go first to guarantee specific mission items are always included regardless of mission maker. E.g. Demo charges.
#define IDX_BACKPACK_ITEMS 21
#define IDX_ITEMS 22
#define IDX_MAGAZINES 24
// Linked Items - Map, Compass, Radio, Watch
#define IDX_LINKED_ITEMS 25
#define IDX_TRAITS 26
#define IDX_CODE 27

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

#define DEF_LOADOUTS ["baseMan","r","g","car","m","smg","ftl","sl","co","fac","ar","aar","rat","dm","mmgg","mmgac","mmgag","hmgg","hmgac","matg","matac","matag","hatg","hatac","hatag","mtrg","mtrac","mtrag","samg","samag","sn","sp","vc","vd","vg","pp","pcc","pc","eng","engm","UAV","jp"]

#define FILTER_WEAPON 0
#define FILTER_GEAR 1
#define FILTER_ITEMS 2
