class LabelUnitStats: RscText
{
    text = "Statistics";
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    //colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
    x = "7 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    y = "0";
    w = "21 * (((safezoneW / safezoneH) min 1.2) / 40)";
    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};

// Header
class UnitStats_SideBackground: RscText
{
    text = "";
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    x = "7 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};
class UnitStats_AI: UnitStats_SideBackground
{
    text = "AI";
    colorBackground[] = {1, 1, 1, 0.2};
    x = "8.1 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    w = "3 * (((safezoneW / safezoneH) min 1.2) / 40)";
};
class UnitStats_Players: UnitStats_AI
{
    text = "Players";
    x = "11.2 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    w = "3 * (((safezoneW / safezoneH) min 1.2) / 40)";
};
class UnitStats_Spectators: UnitStats_AI
{
    text = "Spectators";
    x = "14.3 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    w = "4 * (((safezoneW / safezoneH) min 1.2) / 40)";
};

// Blufor
class UnitStats_SideBackground_Blufor: UnitStats_SideBackground
{
    colorBackground[] = {0.5, 0.5, 0.5, 0.1};
    y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_SideIcon_Blufor: RscPicture
{
    colorText[] = {"(profilenamespace getvariable ['Map_BLUFOR_R',0])", "(profilenamespace getvariable ['Map_BLUFOR_G',0])", "(profilenamespace getvariable ['Map_BLUFOR_B',1])", 0.8};
    style = 48 + 2048; // picture + keep aspect ratio
    text = "\a3\ui_f\data\GUI\Rsc\RscDisplayMultiplayerSetup\flag_indep_ca.paa";
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    x = "7 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    y = "2.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};
class UnitStats_AI_Blufor: UnitStats_AI
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_AI;
    text = "";
    colorBackground[] = {0.5, 0.5, 0.5, 0.1};
    y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Players_Blufor: UnitStats_Players
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_PLAYERS;
    text = "";
    colorBackground[] = {0.5, 0.5, 0.5, 0.1};
    y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Spectators_Blufor: UnitStats_Spectators
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_BLUFOR_SPECTATORS;
    text = "";
    colorBackground[] = {0.5, 0.5, 0.5, 0.1};
    y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};

// Opfor
class UnitStats_SideBackground_Opfor: UnitStats_SideBackground
{
    colorBackground[] = {1, 1, 1, 0.1};
    y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_SideIcon_Opfor: UnitStats_SideIcon_Blufor
{
    colorText[] = {"(profilenamespace getvariable ['Map_OPFOR_R',1])", "(profilenamespace getvariable ['Map_OPFOR_G',0])", "(profilenamespace getvariable ['Map_OPFOR_B',0])", 0.8};
    y = "3.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_AI_Opfor: UnitStats_AI
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_AI;
    text = "";
    colorBackground[] = {1, 1, 1, 0.1};
    y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Players_Opfor: UnitStats_Players
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_PLAYERS;
    text = "";
    colorBackground[] = {1, 1, 1, 0.1};
    y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Spectators_Opfor: UnitStats_Spectators
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_OPFOR_SPECTATORS;
    text = "";
    colorBackground[] = {1, 1, 1, 0.1};
    y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};

// Indep
class UnitStats_SideBackground_Indep: UnitStats_SideBackground_Blufor
{
    y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_SideIcon_Indep: UnitStats_SideIcon_Blufor
{
    colorText[] = {"(profilenamespace getvariable ['Map_Independent_R',0])", "(profilenamespace getvariable ['Map_Independent_G',1])", "(profilenamespace getvariable ['Map_Independent_B',0])", 0.8};
    y = "4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_AI_Indep: UnitStats_AI_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_INDEP_AI;
    y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Players_Indep: UnitStats_Players_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_INDEP_PLAYERS;
    y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Spectators_Indep: UnitStats_Spectators_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_INDEP_SPECTATORS;
    y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};

// Civilian
class UnitStats_SideBackground_Civilian: UnitStats_SideBackground_Opfor
{
    y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_SideIcon_Civilian: UnitStats_SideIcon_Blufor
{
    colorText[] = {"(profilenamespace getvariable ['Map_Civilian_R',0.5])", "(profilenamespace getvariable ['Map_Civilian_G',0])", "(profilenamespace getvariable ['Map_Civilian_B',0.5])", 0.8};
    y = "5.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_AI_Civilian: UnitStats_AI_Opfor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_CIV_AI;
    y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Players_Civilian: UnitStats_Players_Opfor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_CIV_PLAYERS;
    y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Spectators_Civilian: UnitStats_Spectators_Opfor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_CIV_SPECTATORS;
    y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};

// Total
class UnitStats_SideBackground_Total: UnitStats_SideBackground_Blufor
{
    y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_SideIcon_Total: RscText
{
    style = 2; // Center
    text = "*";
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    x = "7 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};
class UnitStats_AI_Total: UnitStats_AI_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_AI;
    y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Players_Total: UnitStats_Players_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_PLAYERS;
    y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};
class UnitStats_Spectators_Total: UnitStats_Spectators_Blufor
{
    idc = IDC_TMF_ADMINMENU_DASH_STATS_TOTAL_SPECTATORS;
    y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
};