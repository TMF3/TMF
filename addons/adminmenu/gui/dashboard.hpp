class Controls {
    // Shortcuts
    class LabelShortcuts: RscText {
        text = "Shortcuts";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 0;
        y = 0;
        w = 7 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class ButtonDebugConsole: GVAR(RscButtonMenu) {
        idc = IDC_TMF_ADMINMENU_DASH_DEBUGCON;
        text = "Debug Console";
        onButtonClick = "(ctrlParent param [0]) closeDisplay 1; createDialog 'RscDisplayDebugPublic';";
        x = 0;
        y = 1.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = 7 * GUI_GRID_W;
    };
    class ButtonClaimZeus: ButtonDebugConsole {
        idc = IDC_TMF_ADMINMENU_DASH_CLAIMZEUS;
        text = "Claim Zeus";
        onButtonClick = QUOTE(call FUNC(claimZeus));
        y = 2.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonCamera: ButtonDebugConsole {
        idc = IDC_TMF_ADMINMENU_DASH_CAMERA;
        text = "Camera";
        onButtonClick = "(ctrlParent param [0]) closeDisplay 1; [] spawn BIS_fnc_camera;";
        y = 3.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class ButtonArsenal: ButtonDebugConsole {
        idc = IDC_TMF_ADMINMENU_DASH_ARSENAL;
        text = "Arsenal";
        tooltip = "ACE Arsenal. Hold Shift to open vanilla Arsenal.";
        onButtonClick = "";
        onMouseButtonClick = "if (player isKindOf 'CAManBase' && alive player) then {(ctrlParent param [0]) closeDisplay 1; if (!param [4]) then {[player, player, true] call ACE_arsenal_fnc_openBox;} else {['Open', true] spawn BIS_fnc_arsenal;};} else {systemChat '[TMF Admin Menu] Player object not compatible with Arsenal';};";
        y = 4.4 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class TabAdminEye: ButtonDebugConsole {
        idc = IDC_TMF_ADMINMENU_ADME;
        text = "Map";
        tooltip = "View Admin Map";
        onButtonClick = QUOTE([] call FUNC(adminEye_open));
        y = 5.5 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };

    // Safestart
    class LabelSafestart: LabelShortcuts {
        text = "Safestart";
        y = 6.8 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class CheckboxSafestartEnabled: RscCheckBox {
        idc = IDC_TMF_ADMINMENU_DASH_SAFESTART;
        x = 0.1 * GUI_GRID_W;
        y = 7.7 * GUI_GRID_H;
        w = 1 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class LabelSafestartEnabled: LabelShortcuts {
        idc = -1;
        text = "Enabled";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        colorText[] = {0.8, 0.8, 0.8, 1};
        x = 0.9 * GUI_GRID_W;
        y = 7.7 * GUI_GRID_H;
        w = 5.8 * GUI_GRID_W;
    };

    // Toggle Spectator Talk
    class LabelSpectatorTalk: LabelShortcuts {
        text = "Talk with Spectators";
        y = 9.0 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class CheckboxSpectatorTalkEnabled: RscCheckBox {
        idc = IDC_TMF_ADMINMENU_DASH_SPECTATORTALK;
        x = 0.1 * GUI_GRID_W;
        y = 9.9 * GUI_GRID_H;
        w = 1 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class LabelSpectatorTalkEnabled: LabelShortcuts {
        idc = -1;
        text = "Enabled";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        colorText[] = {0.8, 0.8, 0.8, 1};
        x = 0.9 * GUI_GRID_W;
        y = 9.9 * GUI_GRID_H;
        w = 5.8 * GUI_GRID_W;
    };


    // Units stats table
    #include "dashboard_table.hpp"

    // General stats, center bottom
    class LabelInformation: RscText {
        text = "General Information";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 8 * GUI_GRID_W;
        y = 8.7 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = 7 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class StatsLabel_Vehicles: RscText {
        text = "Vehicles";
        colorBackground[] = {1, 1, 1, 0.2};
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 8 * GUI_GRID_W;
        y = 9.8 * GUI_GRID_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class StatsValue_Vehicles: StatsLabel_Vehicles {
        idc = IDC_TMF_ADMINMENU_DASH_VEHICLES;
        text = "0";
        colorBackground[] = {0.5, 0.5, 0.5, 0.1};
        x = 12.6 * GUI_GRID_W;
        w = 8.8 * GUI_GRID_W;
    };
    class StatsLabel_DeadUnits: StatsLabel_Vehicles {
        text = "Dead Units";
        y = 10.9 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class StatsValue_DeadUnits: StatsValue_Vehicles {
        idc = IDC_TMF_ADMINMENU_DASH_DEADMEN;
        text = "0";
        y = 10.9 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class StatsLabel_HeadlessClients: StatsLabel_Vehicles {
        text = "AI Load Balance";
        tooltip = "The number of groups being run on the server and each HC.";
        y = 12 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class StatsValue_HeadlessClients: StatsValue_Vehicles {
        idc = IDC_TMF_ADMINMENU_DASH_HEADLESS;
        text = "0";
        y = 12 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class StatsLabel_Curators: StatsLabel_Vehicles {
        text = "Zeuses";
        y = 13.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class StatsValue_Curators: StatsValue_Vehicles {
        idc = IDC_TMF_ADMINMENU_DASH_CURATORS;
        text = "0";
        y = 13.1 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class StatsLabel_CurrentAdmin: StatsLabel_Vehicles {
        text = "Current Admin";
        y = 14.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class StatsValue_CurrentAdmin: StatsValue_Vehicles {
        idc = IDC_TMF_ADMINMENU_DASH_CURRADMIN;
        text = "no data";
        y = 14.2 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class StatsLabel_MissionRuntime: StatsLabel_Vehicles {
        text = "Mission Runtime";
        y = 15.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };
    class StatsValue_MissionRuntime: StatsValue_Vehicles {
        idc = IDC_TMF_ADMINMENU_DASH_RUNTIME;
        text = "18m 37s";
        y = 15.3 * GUI_GRID_H + GUI_GRID_CENTER_Y;
    };

    // Mission maker's notes, right
    class LabelMissionNotes: RscText {
        text = "Mission Maker's Notes";
        sizeEx = GUI_TEXT_SIZE_SMALL;
        x = 22.4 * GUI_GRID_W;
        y = 0;
        w = 15.4 * GUI_GRID_W;
        h = 1 * GUI_GRID_H;
    };
    class GroupMissionNotes: RscControlsGroup {
        idc = IDC_TMF_ADMINMENU_G_DASH_MISSIONNOTES;
        x = 22.4 * GUI_GRID_W;
        y = 1.1 * GUI_GRID_H;
        w = 15.4 * GUI_GRID_W;
        h = 19.5 * GUI_GRID_H;
        class Controls {
            class TextMissionNotes: RscStructuredText {
                idc = IDC_TMF_ADMINMENU_DASH_MISSIONNOTES;
                size = GUI_TEXT_SIZE_SMALL;
                sizeEx = GUI_TEXT_SIZE_SMALL;
                x = 0;
                y = 0;
                w = 14.9 * GUI_GRID_W; // Margin for vertical scrollbar
                h = 1 * GUI_GRID_H;
            };
        };
    };
};
