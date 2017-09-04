class Controls
{
    // Shortcuts
    class LabelShortcuts: RscText
    {
        text = "Shortcuts";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "0";
        y = "0";
        w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class ButtonDebugConsole: GVAR(RscButtonMenu)
    {
        idc = IDC_TMF_ADMINMENU_DASH_DEBUGCON;
        text = "Debug Console";
        onButtonClick = "(ctrlParent param [0]) closeDisplay 1; createDialog 'RscDisplayDebugPublic';";
        x = "0";
        y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };
    class ButtonClaimZeus: ButtonDebugConsole
    {
        idc = IDC_TMF_ADMINMENU_DASH_CLAIMZEUS;
        text = "Claim Zeus";
        onButtonClick = QUOTE(call FUNC(claimZeus));
        y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonCamera: ButtonDebugConsole
    {
        idc = IDC_TMF_ADMINMENU_DASH_CAMERA;
        text = "Camera";
        onButtonClick = "(ctrlParent param [0]) closeDisplay 1; [] spawn BIS_fnc_camera;";
        y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class ButtonArsenal: ButtonDebugConsole
    {
        idc = IDC_TMF_ADMINMENU_DASH_ARSENAL;
        text = "Arsenal";
        onButtonClick = "if (player isKindOf 'CAManBase') then {(ctrlParent param [0]) closeDisplay 1; ['Open', true] spawn BIS_fnc_arsenal;} else {systemChat '[TMF Admin Menu] Player object not compatible with Arsenal';};";
        y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };

    // Safestart
    class LabelSafestart: LabelShortcuts
    {
        text = "Safestart";
        y = "5.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class CheckboxSafestartEnabled: RscCheckBox
    {
        idc = IDC_TMF_ADMINMENU_DASH_SAFESTART;
        x = "0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class LabelSafestartEnabled: LabelShortcuts
    {
        idc = -1;
        text = "Enabled";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        colorText[] = {0.8, 0.8, 0.8, 1};
        x = "0.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "5.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };

    // Toggle Spectator Talk
    class LabelSpectatorTalk: LabelShortcuts
    {
        text = "Talk with Spectators";
        y = "7.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class CheckboxSpectatorTalkEnabled: RscCheckBox
    {
        idc = IDC_TMF_ADMINMENU_DASH_SPECTATORTALK;
        x = "0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "8.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class LabelSpectatorTalkEnabled: LabelShortcuts
    {
        idc = -1;
        text = "Enabled";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        colorText[] = {0.8, 0.8, 0.8, 1};
        x = "0.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "8.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "5.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };


    // Units stats table
    #include "dashboard_table.hpp"

    class LabelInformation: RscText
    {
        text = "General Information";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "7 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        y = "8.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class StatsLabel_HeadlessClients: RscText
    {
        text = "Headless Clients";
        colorBackground[] = {1, 1, 1, 0.2};
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = "7 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        y = "9.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
        w = "4.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
        h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class StatsValue_HeadlessClients: StatsLabel_HeadlessClients
    {
        idc = IDC_TMF_ADMINMENU_DASH_HEADLESS;
        text = "0";
        colorBackground[] = {0.5, 0.5, 0.5, 0.1};
        x = "11.6 * (((safezoneW / safezoneH) min 1.2) / 40) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "8.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
    };
    class StatsLabel_VirtualCurators: StatsLabel_HeadlessClients
    {
        text = "Virtual Zeuses";
        y = "10.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class StatsValue_VirtualCurators: StatsValue_HeadlessClients
    {
        idc = IDC_TMF_ADMINMENU_DASH_VIRTUALS;
        text = "0";
        y = "10.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class StatsLabel_CurrentAdmin: StatsLabel_HeadlessClients
    {
        text = "Current Admin";
        y = "12 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class StatsValue_CurrentAdmin: StatsValue_HeadlessClients
    {
        idc = IDC_TMF_ADMINMENU_DASH_CURRADMIN;
        text = "no data";
        y = "12 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class StatsLabel_MissionRuntime: StatsLabel_HeadlessClients
    {
        text = "Mission Runtime";
        y = "13.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
    class StatsValue_MissionRuntime: StatsValue_HeadlessClients
    {
        idc = IDC_TMF_ADMINMENU_DASH_RUNTIME;
        text = "18m 37s";
        y = "13.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
    };
};
