#define COMPONENT adminMenu

#include "\x\tmf\addons\main\script_mod.hpp"
#include "\x\tmf\addons\main\script_macros.hpp"

#define IDD_TMF_ADMINMENU 56100

#define IDC_TMF_ADMINMENU_FPS 56101
#define IDC_TMF_ADMINMENU_DASH 56102
#define IDC_TMF_ADMINMENU_PMAN 56103
#define IDC_TMF_ADMINMENU_RESP 56104
#define IDC_TMF_ADMINMENU_ENDM 56105
#define IDCS_TMF_ADMINMENU_BTNS [IDC_TMF_ADMINMENU_DASH, IDC_TMF_ADMINMENU_PMAN, IDC_TMF_ADMINMENU_RESP, IDC_TMF_ADMINMENU_ENDM]

#define IDC_TMF_ADMINMENU_G_DASH 56200
#define IDC_TMF_ADMINMENU_G_PMAN 56300
#define IDC_TMF_ADMINMENU_G_RESP 56400
#define IDC_TMF_ADMINMENU_G_ENDM 56500
#define IDCS_TMF_ADMINMENU_GRPS [IDC_TMF_ADMINMENU_G_DASH, IDC_TMF_ADMINMENU_G_PMAN, IDC_TMF_ADMINMENU_G_RESP, IDC_TMF_ADMINMENU_G_ENDM]

#define IDC_TMF_ADMINMENU_DASH_DEBUGCON 56201
#define IDC_TMF_ADMINMENU_DASH_CLAIMZEUS 56202
#define IDC_TMF_ADMINMENU_DASH_CAMERA 56203
#define IDC_TMF_ADMINMENU_DASH_ARSENAL 56204
#define IDC_TMF_ADMINMENU_DASH_SAFESTART 56205

#define IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_AI 56207
#define IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_PLAYERS 56208
#define IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_SPECTATORS 56209
#define IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_TOTAL 56210
#define IDCS_TMF_ADMINMENU_DASH_STATS_BLUFOR [IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_AI, IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_SPECTATORS, IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_TOTAL]
#define IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_AI 56211
#define IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_PLAYERS 56212
#define IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_SPECTATORS 56213
#define IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_TOTAL 56214
#define IDCS_TMF_ADMINMENU_DASH_STATS_OPFOR [IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_AI, IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_SPECTATORS, IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_TOTAL]
#define IDC_TMF_ADMINMENU_DASH_STATS_INDEP_AI 56215
#define IDC_TMF_ADMINMENU_DASH_STATS_INDEP_PLAYERS 56216
#define IDC_TMF_ADMINMENU_DASH_STATS_INDEP_SPECTATORS 56217
#define IDC_TMF_ADMINMENU_DASH_STATS_INDEP_TOTAL 56218
#define IDCS_TMF_ADMINMENU_DASH_STATS_INDEP [IDC_TMF_ADMINMENU_DASH_STATS_INDEP_AI, IDC_TMF_ADMINMENU_DASH_STATS_INDEP_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_INDEP_SPECTATORS, IDC_TMF_ADMINMENU_DASH_STATS_INDEP_TOTAL]
#define IDC_TMF_ADMINMENU_DASH_STATS_CIV_AI 56219
#define IDC_TMF_ADMINMENU_DASH_STATS_CIV_PLAYERS 56220
#define IDC_TMF_ADMINMENU_DASH_STATS_CIV_SPECTATORS 56221
#define IDC_TMF_ADMINMENU_DASH_STATS_CIV_TOTAL 56222
#define IDCS_TMF_ADMINMENU_DASH_STATS_CIV [IDC_TMF_ADMINMENU_DASH_STATS_CIV_AI, IDC_TMF_ADMINMENU_DASH_STATS_CIV_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_CIV_SPECTATORS, IDC_TMF_ADMINMENU_DASH_STATS_CIV_TOTAL]
#define IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_AI 56223
#define IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_PLAYERS 56224
#define IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_SPECTATORS 56225
#define IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_TOTAL 56226
#define IDCS_TMF_ADMINMENU_DASH_STATS_TOTAL [IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_AI, IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_SPECTATORS, IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_TOTAL]
#define IDCS_TMF_ADMINMENU_DASH_STATS_ALLSIDES [IDCS_TMF_ADMINMENU_DASH_STATS_BLUFOR, IDCS_TMF_ADMINMENU_DASH_STATS_OPFOR, IDCS_TMF_ADMINMENU_DASH_STATS_INDEP, IDCS_TMF_ADMINMENU_DASH_STATS_CIV]

#define IDC_TMF_ADMINMENU_DASH_HEADLESS 56227
#define IDC_TMF_ADMINMENU_DASH_VIRTUALS 56228
#define IDC_TMF_ADMINMENU_DASH_CURRADMIN 56229
#define IDC_TMF_ADMINMENU_DASH_RUNTIME 56230

#define IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE 56301
#define IDC_TMF_ADMINMENU_PMAN_FILTER_STATE 56302
#define IDC_TMF_ADMINMENU_PMAN_FILTER_RESET 56303
#define IDC_TMF_ADMINMENU_PMAN_LIST 56304
#define IDC_TMF_ADMINMENU_PMAN_SEL_ALL 56305
#define IDC_TMF_ADMINMENU_PMAN_SEL_GROUP 56306
#define IDC_TMF_ADMINMENU_PMAN_SEL_ROLE 56307
#define IDC_TMF_ADMINMENU_PMAN_SEL_LOADOUT 56308
#define IDC_TMF_ADMINMENU_PMAN_TELEPORT 56309
#define IDC_TMF_ADMINMENU_PMAN_MESSAGE 56310
#define IDC_TMF_ADMINMENU_PMAN_ASSIGNGEAR 56311
#define IDC_TMF_ADMINMENU_PMAN_ASSIGNRADIO 56312
#define IDC_TMF_ADMINMENU_PMAN_HEAL 56313
#define IDC_TMF_ADMINMENU_PMAN_KICK 56314
#define IDC_TMF_ADMINMENU_PMAN_RUNCODE 56315
#define IDC_TMF_ADMINMENU_PMAN_GRANTZEUS 56316
#define IDC_TMF_ADMINMENU_PMAN_ACRELANGUAGES 56317

#define IDC_TMF_ADMINMENU_RESP_SOMETHING 2341243

#define IDC_TMF_ADMINMENU_ENDM_LIST 56501
#define IDC_TMF_ADMINMENU_ENDM_ENDMISSION 56502
#define IDC_TMF_ADMINMENU_ENDM_EXPORTAAR 56503
#define IDC_TMF_ADMINMENU_ENDM_ACTIVATEHUNT 56504
#define IDC_TMF_ADMINMENU_ENDM_FROMMISSION 56505
#define IDC_TMF_ADMINMENU_ENDM_SIDESPECIFIC 56506
#define IDC_TMF_ADMINMENU_ENDM_BLUFOR 56507
#define IDC_TMF_ADMINMENU_ENDM_OPFOR 56508
#define IDC_TMF_ADMINMENU_ENDM_INDEP 56509
#define IDC_TMF_ADMINMENU_ENDM_CIVILIAN 56510
#define IDCS_TMF_ADMINMENU_ENDM_SIDES [IDC_TMF_ADMINMENU_ENDM_BLUFOR, IDC_TMF_ADMINMENU_ENDM_OPFOR, IDC_TMF_ADMINMENU_ENDM_INDEP, IDC_TMF_ADMINMENU_ENDM_CIVILIAN]
#define IDC_TMF_ADMINMENU_ENDM_SIDEDRAW 56511
#define IDCS_TMF_ADMINMENU_ENDM_RIGHT [IDC_TMF_ADMINMENU_ENDM_BLUFOR, IDC_TMF_ADMINMENU_ENDM_OPFOR, IDC_TMF_ADMINMENU_ENDM_INDEP, IDC_TMF_ADMINMENU_ENDM_CIVILIAN, IDC_TMF_ADMINMENU_ENDM_SIDEDRAW]
#define IDC_TMF_ADMINMENU_ENDM_OCCLUDER_L 56512
#define IDC_TMF_ADMINMENU_ENDM_OCCLUDER_R 56513
#define IDC_TMF_ADMINMENU_ENDM_TOOLBOX 56514