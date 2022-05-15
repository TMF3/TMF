class LabelUnitStats: RscText
{
    text = "Statistics";
    sizeEx = GUI_TEXT_SIZE_SMALL;
    x = 8 * GUI_GRID_W;
    y = 0;
    w = 13.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
};

// Header
class UnitStats_SideBackground: RscText
{
    text = "";
    colorBackground[] = {1, 1, 1, 0.2};
    sizeEx = GUI_TEXT_SIZE_SMALL;
    x = 8 * GUI_GRID_W;
    y = 1.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    w = 1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
};
class UnitStats_AI: UnitStats_SideBackground
{
    text = "AI";
    x = 9.1 * GUI_GRID_W;
    w = 2 * GUI_GRID_W;
};
class UnitStats_Players: UnitStats_AI
{
    text = "Players";
    x = 11.2 * GUI_GRID_W;
    w = 3 * GUI_GRID_W;
};
class UnitStats_Spectators: UnitStats_AI
{
    text = "Spectators";
    x = 14.3 * GUI_GRID_W;
    w = 4 * GUI_GRID_W;
};
class UnitStats_Total: UnitStats_AI
{
    text = "Total";
    x = 18.4 * GUI_GRID_W;
    w = 3 * GUI_GRID_W;
};

// Blufor
class UnitStats_SideBackground_Blufor: UnitStats_SideBackground
{
    colorBackground[] = {0.5, 0.5, 0.5, 0.1};
    y = 2.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_SideIcon_Blufor: RscPicture
{
    style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
    text = flag_west;
    colorText[] = Map_BLUFOR_RGBA;
    sizeEx = GUI_TEXT_SIZE_SMALL;
    x = 8 * GUI_GRID_W;
    y = 2.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    w = 1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
};
class UnitStats_AI_Blufor: UnitStats_AI
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_AI;
    text = "";
    colorBackground[] = {0.5, 0.5, 0.5, 0.1};
    y = 2.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Players_Blufor: UnitStats_Players
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_PLAYERS;
    text = "";
    colorBackground[] = {0.5, 0.5, 0.5, 0.1};
    y = 2.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Spectators_Blufor: UnitStats_Spectators
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_SPECTATORS;
    text = "";
    colorBackground[] = {0.5, 0.5, 0.5, 0.1};
    y = 2.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Total_Blufor: UnitStats_Total
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_TOTAL;
    text = "";
    colorBackground[] = {0.5, 0.5, 0.5, 0.1};
    y = 2.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};

// Opfor
class UnitStats_SideBackground_Opfor: UnitStats_SideBackground
{
    colorBackground[] = {1, 1, 1, 0.1};
    y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_SideIcon_Opfor: UnitStats_SideIcon_Blufor
{
    text = flag_east;
    colorText[] = Map_OPFOR_RGBA;
    y = 3.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_AI_Opfor: UnitStats_AI
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_AI;
    text = "";
    colorBackground[] = {1, 1, 1, 0.1};
    y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Players_Opfor: UnitStats_Players
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_PLAYERS;
    text = "";
    colorBackground[] = {1, 1, 1, 0.1};
    y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Spectators_Opfor: UnitStats_Spectators
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_SPECTATORS;
    text = "";
    colorBackground[] = {1, 1, 1, 0.1};
    y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Total_Opfor: UnitStats_Total
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_TOTAL;
    text = "";
    colorBackground[] = {1, 1, 1, 0.1};
    y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};

// Indep
class UnitStats_SideBackground_Indep: UnitStats_SideBackground_Blufor
{
    y = 4.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_SideIcon_Indep: UnitStats_SideIcon_Blufor
{
    text = flag_guer;
    colorText[] = Map_Independent_RGBA;
    y = 4.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_AI_Indep: UnitStats_AI_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_INDEP_AI;
    y = 4.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Players_Indep: UnitStats_Players_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_INDEP_PLAYERS;
    y = 4.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Spectators_Indep: UnitStats_Spectators_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_INDEP_SPECTATORS;
    y = 4.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Total_Indep: UnitStats_Total_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_INDEP_TOTAL;
    y = 4.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};

// Civilian
class UnitStats_SideBackground_Civilian: UnitStats_SideBackground_Opfor
{
    y = 5.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_SideIcon_Civilian: UnitStats_SideIcon_Blufor
{
    text = flag_civl;
    colorText[] = Map_Civilian_RGBA;
    y = 5.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_AI_Civilian: UnitStats_AI_Opfor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_CIV_AI;
    y = 5.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Players_Civilian: UnitStats_Players_Opfor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_CIV_PLAYERS;
    y = 5.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Spectators_Civilian: UnitStats_Spectators_Opfor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_CIV_SPECTATORS;
    y = 5.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Total_Civilian: UnitStats_Total_Opfor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_CIV_TOTAL;
    y = 5.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};

// Total
class UnitStats_SideBackground_Total: UnitStats_SideBackground_Blufor
{
    y = 6.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_SideIcon_Total: RscText
{
    style = ST_CENTER;
    text = "*";
    sizeEx = GUI_TEXT_SIZE_SMALL;
    x = 8 * GUI_GRID_W;
    y = 6.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    w = 1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
};
class UnitStats_AI_Total: UnitStats_AI_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_AI;
    y = 6.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Players_Total: UnitStats_Players_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_PLAYERS;
    y = 6.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Spectators_Total: UnitStats_Spectators_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_SPECTATORS;
    y = 6.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
class UnitStats_Total_Total: UnitStats_Total_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_TOTAL;
    y = 6.6 * GUI_GRID_H + GUI_GRID_CENTER_Y;
};
