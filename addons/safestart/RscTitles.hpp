class RscTitles {
    class GVAR(dialog) {
        idd = DIALOG_IDD;
        duration = 999999999;
        fadein = 0;
        fadeout = 0;
        onLoad = "uiNamespace setVariable ['TMF_safestart_display',_this select 0];";
        movingEnable = 0;
        class controls {
            class Text : RscText
            {
                idc = 101;
                text = "SAFESTART ACTIVE"; //--- ToDo: Localize;
                x = (0.50-0.5/2) * safeZoneW + safeZoneX;
                y = safeZoneY;
                w = 0.5 * safeZoneW;
                h = 0.05 * safeZoneH;
                style = 0x02;
                SizeEx = "(((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 2)";
                colorText[] = {1,1,1,1};
                shadow = 2;
                font = "PuristaBold";
            };
        };
    };
    class GVAR(refusefire) {
        idd = -1;
        duration = 0.3;
        fadein = 0;
        fadeout = 0.3;
        movingEnable = 0;
        class controls {
            class Text : RscText
            {
                text = "X"; //--- ToDo: Localize;
                x = safeZoneX;
                y = safeZoneY + 0.825;
                w = safeZoneW;
                h = 0.1 * safeZoneH;
                style = 0x02;
                SizeEx = "(((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 3)";
                colorText[] = {1,1,1,1};
                shadow = 2;
                font = "EtelkaMonospaceProBold";
            };
        };
    };
};
