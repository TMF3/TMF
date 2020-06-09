class GVAR(safeStartText) : RscText
{
    idc = -1;
    text = ""; //--- ToDo: Localize;
    x = (0.50-0.5/2) * safezoneW + safezoneX;
    y = safezoneY;
    w = 0.5 * safezoneW;
    h = 0.05 * safezoneH;
    style = 0x02;
    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2)";
    colorText[] = {1,1,1,1};
    shadow = 2;
    font = "PuristaBold";

    onLoad = QUOTE(_this call FUNC(briefingText));
};
