class RscButton;
class RscText;
class RscFrame;
class RscPicture;
class RscControlsGroupNoScrollbars;

class RscDisplayCurator {
    class Controls {
        class GVAR(zeusControls) : RscControlsGroupNoScrollbars
        {
            idc=99575;
            x="safezoneX + 12.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            w="safezoneW - 25 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y="(safezoneY + safeZoneH) - (1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
            h="1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            class controls
            {
                class GVAR(frame): RscFrame
                {
                    idc=99576;
                    w="safezoneW - 25 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    x="0 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y="0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    h="1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    colorText[]={0,0,0,1};
                };
                class GVAR(background): RscText
                {
                    idc=99577;
                    w="safezoneW - 25 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    x="0 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y="0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    h="1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    colorBackground[]={0.1,0.1,0.1,0.5};
                };
                class GVAR(logo): RscPicture
                {
                    idc=99578;
                    x="(safezoneW - 25 * (((safezoneW / safezoneH) min 1.2) / 40)) / 2 - 0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    text="\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
                    y="0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w="1 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h="1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    colorText[]={0,0,0,1};
                };
                class GVAR(label): RscText
                {
                    idc=99577;
                    style=0x02; // Center
                    x = "0";
                    w="4 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y="0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    h="1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    text = "Add Objects:";
                    SizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8";
                    colorBackground[]={0,0,0,0};
                };
                class GVAR(toggleUnitsZeus): RscButton {
                    idc = IDC_ToggleUnitsZeus;
                    x ="4 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y="0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w="5 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h="1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    SizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8";
                    text = "All Units";
                    action = QUOTE(_this call FUNC(toggleAllUnitsZeus));
                    toolip = "Toggle making AI units 'editable'"
                };
                class GVAR(toggleStaticsZeus): GVAR(toggleUnitsZeus) {
                    idc = IDC_ToggleStaticsZeus;
                    x ="9 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    text = "Static Objects";
                    action = QUOTE(_this call FUNC(toggleAllStaticsZeus));
                    toolip = "Toggle making Static objects 'editable'"
                };
                class GVAR(toggleACRESpectator): GVAR(toggleStaticsZeus) {
                    idc = IDC_ToggleACRESpectator;
                    x ="14 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    text = "ACRE Spectator";
                    action = QUOTE(_this call FUNC(toggleACRESpectator));
                    toolip = "Toggle ACRE Spectator, allowing you to hear specators and in-game players via the Zeus interface."
                };
            };
        };
    };
};
