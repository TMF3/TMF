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
#define IDC_TMF_ADMINMENU_DASH_CURRADMIN 56206

#define IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_AI 56207
#define IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_PLAYERS 56208
#define IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_SPECTATORS 56209
#define IDCS_TMF_ADMINMENU_DASH_STATS_BLUFOR [IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_AI, IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_SPECTATORS]
#define IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_AI 56210
#define IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_PLAYERS 56211
#define IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_SPECTATORS 56212
#define IDCS_TMF_ADMINMENU_DASH_STATS_OPFOR [IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_AI, IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_SPECTATORS]
#define IDC_TMF_ADMINMENU_DASH_STATS_INDEP_AI 56213
#define IDC_TMF_ADMINMENU_DASH_STATS_INDEP_PLAYERS 56214
#define IDC_TMF_ADMINMENU_DASH_STATS_INDEP_SPECTATORS 56215
#define IDCS_TMF_ADMINMENU_DASH_STATS_INDEP [IDC_TMF_ADMINMENU_DASH_STATS_INDEP_AI, IDC_TMF_ADMINMENU_DASH_STATS_INDEP_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_INDEP_SPECTATORS]
#define IDC_TMF_ADMINMENU_DASH_STATS_CIV_AI 56216
#define IDC_TMF_ADMINMENU_DASH_STATS_CIV_PLAYERS 56217
#define IDC_TMF_ADMINMENU_DASH_STATS_CIV_SPECTATORS 56218
#define IDCS_TMF_ADMINMENU_DASH_STATS_CIV [IDC_TMF_ADMINMENU_DASH_STATS_CIV_AI, IDC_TMF_ADMINMENU_DASH_STATS_CIV_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_CIV_SPECTATORS]
#define IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_AI 56219
#define IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_PLAYERS 56220
#define IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_SPECTATORS 56221
#define IDCS_TMF_ADMINMENU_DASH_STATS_TOTAL [IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_AI, IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_PLAYERS, IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_SPECTATORS]

#define IDC_TMF_ADMINMENU_PMAN_FILTER_SIDE 56301
#define IDC_TMF_ADMINMENU_PMAN_FILTER_STATE 56302
#define IDC_TMF_ADMINMENU_PMAN_FILTER_RESET 56303
#define IDC_TMF_ADMINMENU_PMAN_LIST 56304
#define IDC_TMF_ADMINMENU_PMAN_SEL_ALL 56305
#define IDC_TMF_ADMINMENU_PMAN_SEL_ROLE 56306
#define IDC_TMF_ADMINMENU_PMAN_SEL_LOADOUT 56307
#define IDC_TMF_ADMINMENU_PMAN_TELEPORT 56308
#define IDC_TMF_ADMINMENU_PMAN_MESSAGE 56309
#define IDC_TMF_ADMINMENU_PMAN_ASSIGNGEAR 56310
#define IDC_TMF_ADMINMENU_PMAN_ASSIGNRADIO 56311
#define IDC_TMF_ADMINMENU_PMAN_HEAL 56312
#define IDC_TMF_ADMINMENU_PMAN_KICK 56313
#define IDC_TMF_ADMINMENU_PMAN_RUNCODE 56314

#define IDC_TMF_ADMINMENU_RESP_SOMETHING 2341243

#define IDC_TMF_ADMINMENU_ENDM_LIST 56501
#define IDC_TMF_ADMINMENU_ENDM_ENDMISSION 56502
#define IDC_TMF_ADMINMENU_ENDM_EXPORTAAR 56503
#define IDC_TMF_ADMINMENU_ENDM_ACTIVATEHUNT 56504